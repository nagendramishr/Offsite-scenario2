# Contoso Tech Blazor Support Site

---

## Reference Repository & Practice Goals

This repository is intended as a **reference project** for practicing advanced .NET, Blazor, and AI integration scenarios. You can use this repo to experiment, extend, and learn modern full-stack development patterns.

### Practice Goals
- **Add a Semantic Kernel Agent**
  - Integrate [Semantic Kernel](https://github.com/microsoft/semantic-kernel) to generate new content for the chat assistant.
  - Enable the agent to inject content into the chat based on support data and user context.
- **Stretch Goals**
  - Deploy the app to Azure (App Service, Container Apps, or similar).
  - Use Azure SQL or CosmosDB as the backend database.
  - Integrate with Microsoft Entra ID (Azure AD) for authentication.
  - Add Retrieval-Augmented Generation (RAG) search to enhance chat and support article relevance.

Feel free to fork, extend, and contribute!

---

## Special Notes for GitHub Codespaces

If you are running this project in **GitHub Codespaces**, you may encounter issues with email confirmation or other links containing `8080` in the URL (e.g., `https://your-codespace-url:8080/...`). This happens because Codespaces uses a public proxy URL, and the application may generate links with the internal port, which results in a 404 error.

**Workaround:**  
To ensure links work correctly, add an `AppUrl` setting to your `appsettings.json` (replace with your Codespace URL):

```json
{
  // ...existing settings...
  "AppUrl": "https://supreme-waddle-7x4gg67p7q5cp6r7-8080.app.github.dev"
}
```

---

## Features

- **AI Chat Assistant**
  - Keyword-based and OpenAI-powered chat for instant help.
  - Suggests keywords as you type and displays support articles (Markdown supported).
  - Secure, server-side processing—no sensitive data exposed to the client.
  - Role-based features: all users get help, agents get suggestions, admins can review chat logs.

- **Ticketing System**
  - Users can create, view, and manage support tickets with attachments, comments, and status updates.
  - Support agents can assign, update, and resolve tickets.
  - Admins have dashboards and audit logs for oversight.

- **Authentication & Authorization**
  - ASP.NET Core Identity with role-based access (End User, Support Agent, Admin).
  - Microsoft OAuth integration supported (see `MA-readme.md`).

- **Notifications**
  - In-app notifications for ticket updates and comments (real-time improvements in progress).

- **Audit Trail**
  - All ticket actions are logged for accountability.

- **Modern Dev Environment**
  - Dev Container with .NET 9, SQLite, Azure CLI, Python, and Git for easy onboarding.

---

## Getting Started

### Prerequisites
- .NET 9 SDK ([Download](https://dotnet.microsoft.com/en-us/download/dotnet/9.0))
- Docker ([Get Started](https://www.docker.com/get-started/)) (for Dev Container, optional)
- SQLite3 ([Download](https://www.sqlite.org/download.html)) (optional, for DB inspection)
- Python 3 ([Download](https://www.python.org/downloads/)) (for FAQ generation scripts)
- Azure CLI ([Install Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)) (if using Azure features)

### Quick Setup
1. **Clone the repository**
2. **(Recommended) Open in VS Code Dev Container**
   - All dependencies (including Python, SQLite, Azure CLI) are pre-installed in the dev container.  If you are running this in codespaces, proceed to step 3.   Otherwise, make sure that the pre-requisits above are installed.
        
- Learn more about Blazor: [Blazor Documentation](https://learn.microsoft.com/en-us/aspnet/core/blazor/)

3. **Configure `appsettings.json`**
   - Before setting up the database, update your `appsettings.json` file with admin credentials and authentication settings. For Microsoft OAuth, see `MA-readme.md`.  Copy appsettings.json.orig to appsettings.json and update.
   - Example:
     ```json
     {
       "AdminSetup": {
         "Username": "admin@contoso.com",
         "Password": "YourSecurePassword123!"
       }
     }
     ```
   - Make sure to keep your credentials secure and never commit secrets to source control.
   - If you are using Microsoft Authentication, edit the following two fields as well:
   ```json
   {
        "Authentication": {
         "Microsoft": {
           "ClientId": "your-client-id-here",
           "ClientSecret": "your-client-secret-here"
         }
       }
   }

4. **Generate or Update the Keywords Dictionary (FAQ.json)**
   - Before starting the application, you must generate or update the keywords dictionary (`FAQ.json`) used by the chat assistant.
   - Run the following command from the project root:
     ```sh
     python generate_faq.py
     ```
   - This will scan all article files in `Data/ChatData/` and create or update `FAQ.json`.
   - **Note:** The app will not function correctly if `FAQ.json` is missing or outdated. Re-run this script whenever you add or change support articles.

5. **Set the ASP.NET Core Environment**
   - For development, set the environment variable before running the app:
     ```sh
     export ASPNETCORE_ENVIRONMENT=Development
     ```
   - This enables development settings and detailed error messages.

6. **Database Setup**
   - Run:
     ```sh
     rm Migrations/*
     [ NOTE: you may need to install dotnet ef first: *dotnet tool install --global dotnet-ef* ]
     dotnet ef migrations add InitialCreate
     dotnet ef database update 
     dotnet run update-admin-password
     ```
   - See `DATABASE-SETUP.md` and `DB-readme.md` for details.
7. **Run the app**
   ```sh
   export ASPNETCORE_ENVIRONMENT=Development
   dotnet run
   ```
8. **Login**
   - Default admin credentials are set in `appsettings.json` (see docs for details).

---

## Project Structure

- `Components/` — Blazor UI components (Chat, Layout, Tickets, etc.)
- `Data/` — Data models, services, and database context
- `Data/ChatData/` — Support articles and FAQ data (Markdown/text)
- `Migrations/` — Entity Framework Core migrations
- `wwwroot/` — Static assets (CSS, JS, images)
- `.devcontainer/` — Dev Container configuration

---

## Key Artifacts & Documentation

- **Database Setup:**
  - `DATABASE-SETUP.md`, `DB-readme.md`, `dbsetup.txt`, `dbupdate.txt`
- **Authentication:**
  - `MA-readme.md` (Microsoft OAuth setup), `db-auth.readme.md`
- **Requirements & User Stories:**
  - `Ticketing.txt`, `UserStories.txt`, `requirements-questions.txt`, `Story 9 tasks.txt`, `scenario2.txt`
- **Open Issues:**
  - `openIssues.txt` (current known issues and roadmap)

---

## Development & Contribution

- Use the Dev Container for a consistent environment.
- Database migrations: see `dbsetup.txt` and `dbupdate.txt` for common commands.
- FAQ/Support article updates: edit files in `Data/ChatData/` and run `generate_faq.py`.
- For Azure/OpenAI integration, store API keys in configuration (never in code).

---

## Authentication Modes

By default, this application uses **database authentication** (ASP.NET Core Identity with SQLite) out of the box. This means users register and log in with a username/email and password, and roles are managed in the local database.

- **Default:** Database authentication (no extra setup required)
- **Optional:** Microsoft (OAuth) authentication can be enabled as a separate task. See `MA-readme.md` for setup instructions.

#### How Authentication Mode is Selected
- The code is set up to always use database authentication unless you explicitly configure Microsoft authentication in `appsettings.json` and register the Microsoft authentication services in `Program.cs`.
- If you want to enable Microsoft authentication, follow the steps in `MA-readme.md` and ensure the relevant configuration and service registration are present.
- If the Microsoft authentication section is missing or incomplete in `appsettings.json`, only database authentication will be available.

---

## License
This project is for demonstration and internal use by Contoso Tech. See individual files for copyright.
