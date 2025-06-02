# Google Authentication Setup

## Prerequisites
- Google Cloud Platform Account
- Access to Google Cloud Console (console.cloud.google.com)

## Google OAuth Setup Steps

1. **Access Google Cloud Console**
   - Go to [Google Cloud Console](https://console.cloud.google.com)
   - Sign in with your Google Account

2. **Create New Project**
   - Click on the project dropdown at the top
   - Click "New Project"
   - Enter project name (e.g., "Ticketing System")
   - Click "Create"

3. **Enable OAuth API**
   - Select your project
   - Go to "APIs & Services" > "OAuth consent screen"
   - Choose "External" user type (unless this is for internal organization use)
   - Fill in the OAuth consent screen:
     - App name
     - User support email
     - Developer contact information
   - Click "Save and Continue"
   - Skip scopes (we only need basic profile)
   - Add test users if needed
   - Click "Save and Continue"

4. **Create Credentials**
   - Go to "APIs & Services" > "Credentials"
   - Click "Create Credentials" > "OAuth client ID"
   - Choose "Web application"
   - Set name: "Ticketing System Web Client"
   - Add Authorized redirect URIs:
     - `https://localhost:xxxx/signin-google` (replace xxxx with your port)
   - Click "Create"
   - Copy the Client ID and Client Secret

5. **Update Application Settings**
   Edit `appsettings.json`:
   ```json
   {
     "Authentication": {
       "Google": {
         "ClientId": "your-client-id-here",
         "ClientSecret": "your-client-secret-here"
       }
     }
   }
   ```

## Production Setup
For production:
1. Add production URIs to authorized redirect URIs
2. Move from "Testing" to "Production" status if needed
3. Add production domain to authorized domains
4. Use secure secret storage (not appsettings.json)

## Configuration Options
Additional options available in `Program.cs`:
```csharp
.AddGoogle(options =>
{
    options.ClientId = "your-client-id";
    options.ClientSecret = "your-client-secret";
    
    // Optional configurations:
    options.Scope.Add("profile");
    options.SaveTokens = true;
    options.AccessType = "offline"; // For refresh tokens
});
```

## Troubleshooting

### Common Issues
1. **Redirect URI Mismatch**
   - Exact match required
   - Check for trailing slashes
   - Verify HTTPS/HTTP
   - Port number must match

2. **Invalid Client ID**
   - Verify credentials in appsettings.json
   - Check Google Console for correct values
   - Ensure project is enabled

3. **Consent Screen Errors**
   - Verify app is verified (if needed)
   - Check if consent screen is properly configured
   - Ensure required fields are filled

### Testing
1. Use incognito/private browsing
2. Test with multiple Google accounts
3. Verify OAuth consent screen appears correctly

## Security Best Practices
1. Never commit credentials to source control
2. Use user secrets in development
   ```bash
   dotnet user-secrets set "Authentication:Google:ClientId" "your-client-id"
   dotnet user-secrets set "Authentication:Google:ClientSecret" "your-client-secret"
   ```
3. Use environment variables or secure storage in production
4. Regularly rotate client secrets
5. Limit redirect URIs to trusted domains
6. Implement proper CORS policies
7. Use HTTPS only
