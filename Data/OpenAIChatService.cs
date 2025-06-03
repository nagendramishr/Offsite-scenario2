using System.Security.Claims;
using Microsoft.Extensions.Configuration;

namespace off2.Data
{
    public class OpenAIChatService : IChatService
    {
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IConfiguration _config;
        private readonly ILogger<OpenAIChatService> _logger;

        public OpenAIChatService(IHttpClientFactory httpClientFactory, IConfiguration config, ILogger<OpenAIChatService> logger)
        {
            _httpClientFactory = httpClientFactory;
            _config = config;
            _logger = logger;
        }

        public async Task<string> GetChatResponseAsync(string userMessage, ClaimsPrincipal? user)
        {
            // Log the chat interaction for admin review
            _logger.LogInformation("Chat request from {User}: {Message}", user?.Identity?.Name, userMessage);

            // TODO: Replace with actual OpenAI/Azure OpenAI API call
            // For now, return a placeholder response
            await Task.Delay(500); // Simulate latency
            return "[AI Response Placeholder]";
        }

        public List<string> GetMatchingKeywords(string input)
        {
            // OpenAIChatService does not use local keywords, so return an empty list.
            return new List<string>();
        }
    }
}
