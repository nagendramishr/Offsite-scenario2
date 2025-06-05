using System;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Components;

namespace off2.Components.Account
{
    // Centralized configuration provider with validation and defaults
    public class ConfigProvider
    {
        public string AppUrl { get; }
        public string AdminUsername { get; }
        public string AdminPassword { get; }
        public string MicrosoftClientId { get; }
        public string MicrosoftClientSecret { get; }
        public string GoogleClientId { get; }
        public string GoogleClientSecret { get; }
        public bool UseLocalChat { get; }
        public bool RequireConfirmedAccount { get; }

        public ConfigProvider(IConfiguration configuration)
        {
            // AppUrl
            var appUrl = configuration["AppUrl"]?.TrimEnd('/');
            if (string.IsNullOrWhiteSpace(appUrl))
            {
                appUrl = "http://localhost:8080"; // fallback for non-Blazor startup
            }
            AppUrl = appUrl;
            Console.WriteLine($"[ConfigProvider] AppUrl resolved to: {AppUrl}");

            // Admin credentials
            AdminUsername = configuration["AdminSetup:Username"]
                ?? Environment.GetEnvironmentVariable("ADMIN_USERNAME")
                ?? throw new InvalidOperationException("Admin username is not set in configuration or environment variable ADMIN_USERNAME.");
            AdminPassword = configuration["AdminSetup:Password"]
                ?? Environment.GetEnvironmentVariable("ADMIN_PASSWORD")
                ?? throw new InvalidOperationException("Admin password is not set in configuration or environment variable ADMIN_PASSWORD.");

            // Microsoft Auth
            MicrosoftClientId = configuration["Authentication:Microsoft:ClientId"] ?? string.Empty;
            MicrosoftClientSecret = configuration["Authentication:Microsoft:ClientSecret"] ?? string.Empty;

            // Google Auth
            GoogleClientId = configuration["Authentication:Google:ClientId"] ?? string.Empty;
            GoogleClientSecret = configuration["Authentication:Google:ClientSecret"] ?? string.Empty;

            // Chat
            UseLocalChat = configuration.GetValue("Chat:UseLocalChat", true);

            // Identity
            RequireConfirmedAccount = configuration.GetValue("Identity:RequireConfirmedAccount", true);
        }
    }
}