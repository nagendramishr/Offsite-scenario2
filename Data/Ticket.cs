using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using off2.Data.Enums;

namespace off2.Data;

public class Ticket
{
    public int Id { get; set; }

    [Required]
    [StringLength(200)]
    public string Title { get; set; } = "";

    [Required]
    public string Description { get; set; } = "";

    public TicketStatus Status { get; set; } = TicketStatus.Open;

    public TicketPriority Priority { get; set; } = TicketPriority.Medium;

    [Required]
    public string CreatedById { get; set; } = "";

    [ForeignKey("CreatedById")]
    public ApplicationUser? CreatedBy { get; set; }

    public string? AssignedToId { get; set; }

    [ForeignKey("AssignedToId")]
    public ApplicationUser? AssignedTo { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public DateTime? UpdatedAt { get; set; }

    [Required]
    [StringLength(100)]
    public string Category { get; set; } = "";

    [StringLength(100)]    public string? TechArea { get; set; }
    public string? AttachmentUrl { get; set; }
    
    public ICollection<TicketComment> Comments { get; set; } = new List<TicketComment>();
}
