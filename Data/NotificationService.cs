using Microsoft.EntityFrameworkCore;
using System.Collections.Concurrent;
using off2.Data.Enums;
using off2.Data.Models;

namespace off2.Data;

public class NotificationService
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<NotificationService> _logger;
    private readonly ConcurrentDictionary<string, Action<Notification>> _subscribers = new();

    public NotificationService(
        ApplicationDbContext context,
        ILogger<NotificationService> logger)
    {
        _context = context;
        _logger = logger;
    }

    public void Subscribe(string userId, Action<Notification> callback)
    {
        _subscribers.TryAdd(userId, callback);
    }

    public void Unsubscribe(string userId)
    {
        _subscribers.TryRemove(userId, out _);
    }

    private void NotifyUser(string userId, Notification notification)
    {
        if (_subscribers.TryGetValue(userId, out var callback))
        {
            callback(notification);
        }
    }

    public async Task<Notification> CreateNotificationAsync(string userId, int ticketId, NotificationType type, string message)
    {
        var notification = new Notification
        {
            UserId = userId,
            TicketId = ticketId,
            Type = type,
            Message = message,
            CreatedAt = DateTime.UtcNow
        };

        _context.Notifications.Add(notification);
        await _context.SaveChangesAsync();

        NotifyUser(userId, notification);

        _logger.LogInformation("Notification created for user {UserId}: {Message}", userId, message);
        return notification;
    }

    public async Task MarkAsReadAsync(int notificationId)
    {
        var notification = await _context.Notifications.FindAsync(notificationId);
        if (notification == null) return;

        notification.IsRead = true;
        notification.ReadAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();
    }

    public async Task<List<Notification>> GetUnreadNotificationsAsync(string userId)
    {
        return await _context.Notifications
            .Include(n => n.Ticket)
            .Where(n => n.UserId == userId && !n.IsRead)
            .OrderByDescending(n => n.CreatedAt)
            .ToListAsync();
    }

    public async Task<int> GetUnreadCountAsync(string userId)
    {
        return await _context.Notifications
            .Where(n => n.UserId == userId && !n.IsRead)
            .CountAsync();
    }

    public async Task DeleteNotificationAsync(int notificationId, string userId)
    {
        var notification = await _context.Notifications.FindAsync(notificationId);
        if (notification == null || notification.UserId != userId) return;

        _context.Notifications.Remove(notification);
        await _context.SaveChangesAsync();
    }

    public async Task NotifyTicketStatusChanged(string assignedUserId, int ticketId, TicketStatus oldStatus, TicketStatus newStatus)
    {
        if (string.IsNullOrEmpty(assignedUserId)) return;

        var message = $"Ticket #{ticketId} status changed from {oldStatus} to {newStatus}";
        await CreateNotificationAsync(assignedUserId, ticketId, NotificationType.StatusChanged, message);
    }

    public async Task NotifyTicketAssigned(string userId, int ticketId, string? assignerName)
    {
        var message = $"Ticket #{ticketId} has been assigned to you by {assignerName ?? "system"}";
        await CreateNotificationAsync(userId, ticketId, NotificationType.AssignmentChanged, message);
    }

    public async Task NotifyNewComment(string userId, int ticketId, string commenterName)
    {
        var message = $"New comment on ticket #{ticketId} by {commenterName}";
        await CreateNotificationAsync(userId, ticketId, NotificationType.NewComment, message);
    }

    public async Task NotifyPriorityChanged(string userId, int ticketId, TicketPriority oldPriority, TicketPriority newPriority)
    {
        var message = $"Ticket #{ticketId} priority changed from {oldPriority} to {newPriority}";
        await CreateNotificationAsync(userId, ticketId, NotificationType.PriorityChanged, message);
    }

    public async Task NotifyAttachmentAdded(string userId, int ticketId, string uploaderName)
    {
        var message = $"New attachment added to ticket #{ticketId} by {uploaderName}";
        await CreateNotificationAsync(userId, ticketId, NotificationType.AttachmentAdded, message);
    }

    public async Task NotifyAttachmentDeleted(string userId, int ticketId, string deleterName)
    {
        var message = $"Attachment deleted from ticket #{ticketId} by {deleterName}";
        await CreateNotificationAsync(userId, ticketId, NotificationType.AttachmentDeleted, message);
    }
}
