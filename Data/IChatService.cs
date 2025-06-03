using System.Security.Claims;
using Microsoft.Extensions.Configuration;

namespace off2.Data
{
    public interface IChatService
    {
        Task<string> GetChatResponseAsync(string userMessage, ClaimsPrincipal? user);
        List<string> GetMatchingKeywords(string input);
    }
}
