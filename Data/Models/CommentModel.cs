using System.ComponentModel.DataAnnotations;

namespace off2.Data.Models;

public class CommentModel
{
    [Required(ErrorMessage = "Comment content is required")]
    [MinLength(1, ErrorMessage = "Comment cannot be empty")]
    [MaxLength(1000, ErrorMessage = "Comment cannot exceed 1000 characters")]
    public string Content { get; set; } = string.Empty;
}
