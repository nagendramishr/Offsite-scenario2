using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.EntityFrameworkCore;
using off2.Data.Enums;
using System.Linq;

namespace off2.Data;

public class TicketService
{
    private readonly ApplicationDbContext _context;
    private readonly RoleHelper _roleHelper;
    private readonly AuthenticationStateProvider _authStateProvider;

    public TicketService(
        ApplicationDbContext context,
        RoleHelper roleHelper,
        AuthenticationStateProvider authStateProvider)
    {
        _context = context;
        _roleHelper = roleHelper;
        _authStateProvider = authStateProvider;
    }    public async Task<List<Ticket>> GetTicketsAsync(
        string? searchQuery = null,
        TicketStatus? status = null,
        TicketPriority? priority = null,
        string? assignedToId = null,
        DateTime? startDate = null,
        DateTime? endDate = null)
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var user = authState.User;
        var userId = user.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

        // Start with a base query
        IQueryable<Ticket> query = _context.Tickets
            .Include(t => t.CreatedBy)
            .Include(t => t.AssignedTo)
            .Include(t => t.Comments)
                .ThenInclude(c => c.CreatedBy);

        // Apply role-based filtering
        if (!await _roleHelper.IsAdmin() && !await _roleHelper.IsAgent())
        {
            // End users can only see their own tickets
            query = query.Where(t => t.CreatedById == userId);
        }

        // Apply search filters
        if (!string.IsNullOrWhiteSpace(searchQuery))
        {
            query = query.Where(t =>
                t.Id.ToString().Contains(searchQuery) ||
                t.Title.Contains(searchQuery) ||
                t.Description.Contains(searchQuery) ||
                t.Comments.Any(c => c.Content.Contains(searchQuery)));
        }

        // Apply status filter
        if (status.HasValue)
        {
            query = query.Where(t => t.Status == status);
        }

        // Apply priority filter
        if (priority.HasValue)
        {
            query = query.Where(t => t.Priority == priority);
        }

        // Apply assignee filter
        if (!string.IsNullOrEmpty(assignedToId))
        {
            query = query.Where(t => t.AssignedToId == assignedToId);
        }

        // Apply date range filter
        if (startDate.HasValue)
        {
            query = query.Where(t => t.CreatedAt.Date >= startDate.Value.Date);
        }

        if (endDate.HasValue)
        {
            query = query.Where(t => t.CreatedAt.Date <= endDate.Value.Date);
        }

        // Order by creation date
        return await query.OrderByDescending(t => t.CreatedAt).ToListAsync();
    }

    public async Task<Ticket?> GetTicketByIdAsync(int id)
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var user = authState.User;
        var userId = user.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

        var ticket = await _context.Tickets
            .Include(t => t.CreatedBy)
            .Include(t => t.AssignedTo)
            .FirstOrDefaultAsync(t => t.Id == id);

        if (ticket == null) return null;

        // Check if user has permission to view this ticket
        if (await _roleHelper.IsAdmin() || await _roleHelper.IsAgent())
        {
            return ticket;
        }
        else if (ticket.CreatedById == userId)
        {
            return ticket;
        }

        return null; // User doesn't have permission
    }

    public async Task<Ticket> CreateTicketAsync(Ticket ticket)
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var userId = authState.User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value
            ?? throw new InvalidOperationException("User is not authenticated");

        ticket.CreatedById = userId;
        ticket.CreatedAt = DateTime.UtcNow;
        ticket.Status = TicketStatus.Open;

        _context.Tickets.Add(ticket);
        await _context.SaveChangesAsync();

        return ticket;
    }    private async Task AddAuditLogAsync(int ticketId, string action, string fieldName, string? oldValue, string? newValue)
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var userId = authState.User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value
            ?? throw new InvalidOperationException("User is not authenticated");

        var audit = new TicketAudit
        {
            TicketId = ticketId,
            Action = action,
            FieldName = fieldName,
            OldValue = oldValue,
            NewValue = newValue,
            ChangedById = userId
        };

        _context.TicketAudits.Add(audit);
        await _context.SaveChangesAsync();
    }

    public async Task<bool> UpdateTicketAsync(Ticket ticket)
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var userId = authState.User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

        var existingTicket = await _context.Tickets.FindAsync(ticket.Id);
        if (existingTicket == null) return false;

        // Check permissions
        if (!await _roleHelper.IsAdmin() && !await _roleHelper.IsAgent() && existingTicket.CreatedById != userId)
        {
            return false;
        }

        // Track changes for audit log
        if (existingTicket.Title != ticket.Title)
            await AddAuditLogAsync(ticket.Id, "Update", "Title", existingTicket.Title, ticket.Title);
            
        if (existingTicket.Description != ticket.Description)
            await AddAuditLogAsync(ticket.Id, "Update", "Description", existingTicket.Description, ticket.Description);
            
        if (existingTicket.Priority != ticket.Priority)
            await AddAuditLogAsync(ticket.Id, "Update", "Priority", existingTicket.Priority.ToString(), ticket.Priority.ToString());
            
        if (existingTicket.Status != ticket.Status)
            await AddAuditLogAsync(ticket.Id, "Update", "Status", existingTicket.Status.ToString(), ticket.Status.ToString());
            
        if (existingTicket.Category != ticket.Category)
            await AddAuditLogAsync(ticket.Id, "Update", "Category", existingTicket.Category, ticket.Category);
            
        if (existingTicket.TechArea != ticket.TechArea)
            await AddAuditLogAsync(ticket.Id, "Update", "TechArea", existingTicket.TechArea, ticket.TechArea);

        if (existingTicket.AssignedToId != ticket.AssignedToId)
            await AddAuditLogAsync(ticket.Id, "Update", "AssignedTo", existingTicket.AssignedToId, ticket.AssignedToId);

        // Update allowed fields
        existingTicket.Title = ticket.Title;
        existingTicket.Description = ticket.Description;
        existingTicket.Priority = ticket.Priority;
        existingTicket.Category = ticket.Category;
        existingTicket.TechArea = ticket.TechArea;
        existingTicket.UpdatedAt = DateTime.UtcNow;

        // Only agents and admins can update these fields
        if (await _roleHelper.IsAdmin() || await _roleHelper.IsAgent())
        {
            existingTicket.Status = ticket.Status;
            existingTicket.AssignedToId = ticket.AssignedToId;
        }

        await _context.SaveChangesAsync();
        return true;
    }

    public async Task<bool> DeleteTicketAsync(int id)
    {
        // Only admins can delete tickets
        if (!await _roleHelper.IsAdmin())
        {
            return false;
        }

        var ticket = await _context.Tickets.FindAsync(id);
        if (ticket == null) return false;

        _context.Tickets.Remove(ticket);
        await _context.SaveChangesAsync();
        return true;
    }    public async Task<List<Ticket>> GetAssignedTicketsAsync()
    {
        if (!await _roleHelper.IsAgent() && !await _roleHelper.IsAdmin())
        {
            return new List<Ticket>();
        }

        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var userId = authState.User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value;

        return await _context.Tickets
            .Include(t => t.CreatedBy)
            .Include(t => t.AssignedTo)
            .Where(t => t.AssignedToId == userId)
            .OrderByDescending(t => t.CreatedAt)
            .ToListAsync();
    }

    public async Task<TicketComment> AddCommentAsync(TicketComment comment)
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        var userId = authState.User.FindFirst(System.Security.Claims.ClaimTypes.NameIdentifier)?.Value
            ?? throw new InvalidOperationException("User is not authenticated");

        comment.CreatedById = userId;
        comment.CreatedAt = DateTime.UtcNow;

        _context.TicketComments.Add(comment);
        await _context.SaveChangesAsync();

        return comment;
    }
}
