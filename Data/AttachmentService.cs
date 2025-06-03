using Microsoft.AspNetCore.Components.Forms;
using Microsoft.EntityFrameworkCore;
using off2.Data.Models;
using off2.Data.Enums;
using System.Security.Cryptography;
using Microsoft.AspNetCore.Hosting;

namespace off2.Data;

public class AttachmentService
{
    private readonly ApplicationDbContext _context;
    private readonly ILogger<AttachmentService> _logger;
    private readonly IWebHostEnvironment _environment;

    public event Action<int>? AttachmentsChanged;

    public AttachmentService(
        ApplicationDbContext context,
        ILogger<AttachmentService> logger,
        IWebHostEnvironment environment)
    {
        _context = context;
        _logger = logger;
        _environment = environment;
    }

    private void NotifyAttachmentsChanged(int ticketId)
    {
        AttachmentsChanged?.Invoke(ticketId);
    }

    public async Task<TicketAttachment> UploadFileAsync(int ticketId, IBrowserFile file, string userId)
    {
        // Validate file size
        if (file.Size > FileUploadModel.MaxFileSize)
            throw new ArgumentException($"File size cannot exceed {FileUploadModel.MaxFileSize / 1024 / 1024}MB");

        // Validate file extension
        var extension = Path.GetExtension(file.Name).ToLowerInvariant();
        if (!FileUploadModel.AllowedExtensions.Contains(extension))
            throw new ArgumentException($"File type {extension} is not allowed");

        // Create upload directory if it doesn't exist
        var uploadPath = Path.Combine(_environment.WebRootPath, "uploads", ticketId.ToString());
        Directory.CreateDirectory(uploadPath);

        // Generate unique filename
        var uniqueFileName = $"{Path.GetFileNameWithoutExtension(Path.GetRandomFileName())}{extension}";
        var filePath = Path.Combine(uploadPath, uniqueFileName);

        // Save file
        await using var stream = file.OpenReadStream(FileUploadModel.MaxFileSize);
        await using var fileStream = new FileStream(filePath, FileMode.Create);
        await stream.CopyToAsync(fileStream);

        // Create attachment record
        var attachment = new TicketAttachment
        {
            TicketId = ticketId,
            FileName = file.Name,
            FileSize = file.Size,
            ContentType = file.ContentType,
            FilePath = $"uploads/{ticketId}/{uniqueFileName}",
            UploadedById = userId,
            UploadedAt = DateTime.UtcNow
        };

        _context.TicketAttachments.Add(attachment);
        await _context.SaveChangesAsync();

        NotifyAttachmentsChanged(ticketId);

        _logger.LogInformation("File {FileName} uploaded for ticket {TicketId} by user {UserId}",
            file.Name, ticketId, userId);

        return attachment;
    }

    public async Task<List<TicketAttachment>> GetAttachmentsForTicketAsync(int ticketId)
    {
        return await _context.TicketAttachments
            .Include(a => a.UploadedBy)
            .Where(a => a.TicketId == ticketId)
            .OrderByDescending(a => a.UploadedAt)
            .ToListAsync();
    }

    public async Task DeleteAttachmentAsync(int attachmentId, string userId)
    {
        var attachment = await _context.TicketAttachments.FindAsync(attachmentId)
            ?? throw new ArgumentException($"Attachment with ID {attachmentId} not found.");

        // Only the uploader can delete attachments
        if (attachment.UploadedById != userId)
            throw new UnauthorizedAccessException("You can only delete your own attachments.");

        // Delete file from disk
        var filePath = Path.Combine(_environment.WebRootPath, attachment.FilePath);
        if (File.Exists(filePath))
            File.Delete(filePath);

        // Remove from database
        _context.TicketAttachments.Remove(attachment);
        await _context.SaveChangesAsync();

        NotifyAttachmentsChanged(attachment.TicketId);

        _logger.LogInformation("Attachment {AttachmentId} deleted by user {UserId}", attachmentId, userId);
    }

    public async Task<Stream> GetFileStreamAsync(int attachmentId)
    {
        var attachment = await _context.TicketAttachments.FindAsync(attachmentId)
            ?? throw new ArgumentException($"Attachment with ID {attachmentId} not found.");

        var filePath = Path.Combine(_environment.WebRootPath, attachment.FilePath);
        if (!File.Exists(filePath))
            throw new FileNotFoundException($"File {attachment.FileName} not found");

        return File.OpenRead(filePath);
    }
}
