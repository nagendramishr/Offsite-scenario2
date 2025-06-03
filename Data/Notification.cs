using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace off2.Data;

public enum NotificationType
{
    NewComment,
    StatusChanged,
    AssignmentChanged,
    PriorityChanged,
    AttachmentAdded,
    AttachmentDeleted
}

public class Notification
{
    public int Id { get; set; }

    [Required]
    public string UserId { get; set; } = "";
    [ForeignKey("UserId")]
    public ApplicationUser? User { get; set; }

    public int TicketId { get; set; }
    [ForeignKey("TicketId")]
    public Ticket? Ticket { get; set; }

    [Required]
    public NotificationType Type { get; set; }

    [Required]
    public string Message { get; set; } = "";

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public bool IsRead { get; set; }

    public DateTime? ReadAt { get; set; }
}
