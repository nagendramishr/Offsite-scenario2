using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace off2.Data;

public class TicketAudit
{
    public int Id { get; set; }

    public int TicketId { get; set; }
    [ForeignKey("TicketId")]
    public Ticket? Ticket { get; set; }

    [Required]
    public string Action { get; set; } = "";

    [Required]
    public string FieldName { get; set; } = "";

    public string? OldValue { get; set; }
    public string? NewValue { get; set; }

    [Required]
    public string ChangedById { get; set; } = "";
    [ForeignKey("ChangedById")]
    public ApplicationUser? ChangedBy { get; set; }

    public DateTime ChangedAt { get; set; } = DateTime.UtcNow;
}
