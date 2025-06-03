using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace off2.Data;

public class CommentService
{    private readonly ApplicationDbContext _context;
    private readonly ILogger<CommentService> _logger;

    public event Action<int>? CommentsChanged;

    public CommentService(
        ApplicationDbContext context, 
        ILogger<CommentService> logger)
    {
        _context = context;
        _logger = logger;
    }

    private void NotifyCommentsChanged(int ticketId)
    {
        CommentsChanged?.Invoke(ticketId);
    }

    public async Task<TicketComment> AddComment(int ticketId, string content, string userId)
    {
        var ticket = await _context.Tickets.FindAsync(ticketId)
            ?? throw new ArgumentException($"Ticket with ID {ticketId} not found.");

        var comment = new TicketComment
        {
            TicketId = ticketId,
            Content = content,
            CreatedById = userId,
            CreatedAt = DateTime.UtcNow
        };        _context.TicketComments.Add(comment);
        await _context.SaveChangesAsync();

        NotifyCommentsChanged(ticketId);

        _logger.LogInformation("Comment {CommentId} added to ticket {TicketId} by user {UserId}", 
            comment.Id, ticketId, userId);

        return comment;
    }

    public async Task<List<TicketComment>> GetCommentsForTicket(int ticketId)
    {
        return await _context.TicketComments
            .Include(c => c.CreatedBy)
            .Where(c => c.TicketId == ticketId)
            .OrderBy(c => c.CreatedAt)
            .ToListAsync();
    }

    public async Task<TicketComment> EditComment(int commentId, string newContent, string userId)
    {
        var comment = await _context.TicketComments.FindAsync(commentId)
            ?? throw new ArgumentException($"Comment with ID {commentId} not found.");

        // Only the comment creator can edit it
        if (comment.CreatedById != userId)
        {
            throw new UnauthorizedAccessException("You can only edit your own comments.");
        }        comment.Content = newContent;
        comment.LastModifiedAt = DateTime.UtcNow;
        comment.IsEdited = true;

        await _context.SaveChangesAsync();

        NotifyCommentsChanged(comment.TicketId);
        _logger.LogInformation("Comment {CommentId} edited by user {UserId}", commentId, userId);

        return comment;
    }

    public async Task DeleteComment(int commentId, string userId)
    {
        var comment = await _context.TicketComments.FindAsync(commentId)
            ?? throw new ArgumentException($"Comment with ID {commentId} not found.");

        // Only the comment creator can delete it
        if (comment.CreatedById != userId)
        {
            throw new UnauthorizedAccessException("You can only delete your own comments.");
        }        int ticketId = comment.TicketId;
        _context.TicketComments.Remove(comment);
        await _context.SaveChangesAsync();

        NotifyCommentsChanged(ticketId);
        _logger.LogInformation("Comment {CommentId} deleted by user {UserId}", commentId, userId);
    }
}
