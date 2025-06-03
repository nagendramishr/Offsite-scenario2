using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace off2.Data;

public class TicketAttachment
{
    public int Id { get; set; }

    public int TicketId { get; set; }
    [ForeignKey("TicketId")]
    public Ticket? Ticket { get; set; }

    [Required]
    [StringLength(255)]
    public string FileName { get; set; } = "";

    public long FileSize { get; set; }

    [Required]
    [StringLength(100)]
    public string ContentType { get; set; } = "";

    [Required]
    public string UploadedById { get; set; } = "";
    [ForeignKey("UploadedById")]
    public ApplicationUser? UploadedBy { get; set; }

    public DateTime UploadedAt { get; set; } = DateTime.UtcNow;

    [Required]
    [StringLength(255)]
    public string FilePath { get; set; } = "";
}
