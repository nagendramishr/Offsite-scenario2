using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace off2.Data;

public class TicketComment
{
    public int Id { get; set; }

    public int TicketId { get; set; }
    [ForeignKey("TicketId")]
    public Ticket? Ticket { get; set; }

    [Required]
    public string Content { get; set; } = "";

    [Required]
    public string CreatedById { get; set; } = "";
    [ForeignKey("CreatedById")]
    public ApplicationUser? CreatedBy { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
