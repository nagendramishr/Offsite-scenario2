using System.Security.Claims;
using System.Text.Json;
using Microsoft.Extensions.Configuration;
using Markdig;

namespace off2.Data
{
    public class LocalChatService : IChatService
    {
        private readonly IConfiguration _config;
        private readonly ILogger<LocalChatService> _logger;
        private readonly string _faqPath;
        private readonly string _chatDataFolder;
        private Dictionary<string, string> _faqMap = new();
        private bool _faqLoaded = false;

        public LocalChatService(IConfiguration config, ILogger<LocalChatService> logger)
        {
            _config = config;
            _logger = logger;
            _chatDataFolder = Path.Combine(AppContext.BaseDirectory, "Data", "ChatData");
            _faqPath = Path.Combine(_chatDataFolder, "FAQ.json");
            _logger.LogInformation("Chat data folder: {ChatDataFolder}", _chatDataFolder);
            // Load FAQ at startup
            LoadFaq();
        }

        public async Task<string> GetChatResponseAsync(string userMessage, ClaimsPrincipal? user)
        {
            if (string.IsNullOrWhiteSpace(userMessage))
                return "Please enter a question.";
            var lowerMsg = userMessage.ToLowerInvariant();
            // Match on whole word for each keyword
            foreach (var kvp in _faqMap)
            {
                var keyword = kvp.Key;
                if ($" {lowerMsg} ".Contains($" {keyword} "))
                {
                    _logger.LogInformation($"Loading answer for keyword: {keyword}.  File: {_chatDataFolder}/{kvp.Value}");
                    var filePath = Path.Combine(_chatDataFolder, kvp.Value);
                    if (File.Exists(filePath))
                    {
                        var content = await File.ReadAllTextAsync(filePath);
                        // If file is .md or contains Markdown formatting, convert to HTML
                        if (Path.GetExtension(filePath).Equals(".md", StringComparison.OrdinalIgnoreCase) || LooksLikeMarkdown(content))
                        {
                            var html = Markdown.ToHtml(content);
                            return html;
                        }
                        return content;
                    }
                    else
                        return $"Sorry, I couldn't find the answer file for '{kvp.Key}'.";
                }
            }
            return "Sorry, I couldn't find an answer for your question in the local FAQ.";
        }

        // Heuristic: treat as markdown if it contains at least one markdown header, list, or formatting
        private static bool LooksLikeMarkdown(string content)
        {
            return content.Contains("\n#") || content.Contains("\n##") || content.Contains("* ") || content.Contains("- ") || content.Contains("**") || content.Contains("_");
        }

        private class FaqEntry
        {
            public List<string> keywords { get; set; } = new();
            public string filename { get; set; } = string.Empty;
        }

        private void LoadFaq()
        {
            _faqMap.Clear();
            var faqJsonPath = Path.Combine(_chatDataFolder, "FAQ.json");
            if (!File.Exists(faqJsonPath))
                return;
            var json = File.ReadAllText(faqJsonPath);
            var entries = JsonSerializer.Deserialize<List<FaqEntry>>(json);
            if (entries == null) return;
            foreach (var entry in entries)
            {
                foreach (var keyword in entry.keywords)
                {
                    var key = keyword.Trim().ToLowerInvariant();
                    if (!_faqMap.ContainsKey(key))
                        _faqMap[key] = entry.filename;
                }
            }
            _faqLoaded = true;
            _logger.LogDebug("Parsed keywords: {Keywords}", string.Join(", ", _faqMap.Keys));
        }

        public List<string> GetMatchingKeywords(string input)
        {
            _logger.LogDebug("FAQ Map contains: {FaqMap}", string.Join(", ", _faqMap.Select(kvp => $"{kvp.Key}={kvp.Value}")));
            _logger.LogDebug($"Searching for keywords matching: {input}");
            var lowerInput = input.ToLowerInvariant();
            var matchingKeywords = _faqMap.Keys.Where(keyword => keyword.Contains(lowerInput)).ToList();
            _logger.LogDebug($"Found matching keywords: {string.Join(", ", matchingKeywords)}");
            return matchingKeywords;
        }
    }
}
