# Microsoft Authentication Setup

## Prerequisites
- Microsoft Azure Account
- Access to Azure Portal (portal.azure.com)

## Azure AD App Registration Steps

1. **Go to Azure Portal**
   - Visit [Azure Portal](https://portal.azure.com)
   - Sign in with your Microsoft Account

2. **Create App Registration**
   - Navigate to "Azure Active Directory" > "App registrations"
   - Click "New registration"
   - Fill in the details:
     - Name: "Ticketing System" (or your app name)
     - Supported account types: Choose "Accounts in any organizational directory and personal Microsoft accounts"
     - Redirect URI: 
       - Type: Web
       - URL: `https://localhost:xxxx/signin-microsoft` (replace xxxx with your port number)

3. **Configure Authentication**
   - In your new app registration:
   - Go to "Authentication" tab
   - Under "Implicit grant and hybrid flows":
     - Check "ID tokens"
   - Under "Advanced settings":
     - Set "Access tokens" and "ID tokens" to "Yes"

4. **Get Credentials**
   - Go to "Overview" tab
   - Copy the "Application (client) ID"
   - Go to "Certificates & secrets" tab
   - Create a new "Client secret"
   - Copy the secret value immediately (you won't be able to see it again)

5. **Update Application Settings**
   Edit `appsettings.json`:
   ```json
   {
     "Authentication": {
       "Microsoft": {
         "ClientId": "your-client-id-here",
         "ClientSecret": "your-client-secret-here"
       }
     }
   }
   ```

## Production Setup
For production deployment:
1. Add your production URI to the Azure AD app's redirect URIs
2. Use Azure Key Vault or similar to store secrets
3. Update CORS settings if needed

## Troubleshooting

### Common Issues
1. **Invalid redirect URI**
   - Ensure the redirect URI exactly matches what's registered in Azure
   - Include the correct port number
   - Use HTTPS

2. **Authentication failed**
   - Check if ClientId and ClientSecret are correct
   - Verify the secret hasn't expired
   - Ensure the app registration is in the correct directory

3. **CORS errors**
   - Add your domain to the allowed origins in Azure AD

### Testing
1. Use private/incognito mode for testing
2. Clear cookies if experiencing issues
3. Check browser console for errors

## Security Notes
- Never commit `appsettings.json` with real secrets
- Use user secrets or environment variables in development
- Use Azure Key Vault in production
- Rotate client secrets periodically
