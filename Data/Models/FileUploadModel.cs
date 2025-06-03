using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Components.Forms;

namespace off2.Data.Models;

public class FileUploadModel
{
    [Required(ErrorMessage = "Please select a file")]
    public IBrowserFile? File { get; set; }

    public static readonly string[] AllowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".pdf", ".doc", ".docx" };
    public static readonly long MaxFileSize = 10 * 1024 * 1024; // 10MB
}
