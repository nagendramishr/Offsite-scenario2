# Database Authentication Setup

## Overview
This application uses ASP.NET Core Identity with SQLite for local database authentication. This is the default authentication method and works out of the box.

## Features
- Username/Email + Password authentication
- Role-based authorization (Admin, SupportAgent, EndUser)
- Password hashing and security
- Email confirmation support
- Account lockout protection
- Cookie-based authentication

## Configuration
The authentication is configured in `Program.cs` with these settings:

```csharp
// Password requirements
options.Password.RequiredLength = 6;
options.Password.RequireDigit = true;
options.Password.RequireLowercase = true;
options.Password.RequireUppercase = true;
options.Password.RequireNonAlphanumeric = true;

// Account confirmation
options.SignIn.RequireConfirmedAccount = true;
```

## Database Tables
The authentication system uses these Identity tables:
- `AspNetUsers` - User accounts
- `AspNetRoles` - User roles
- `AspNetUserRoles` - User-role assignments
- `AspNetUserClaims` - User claims
- `AspNetRoleClaims` - Role claims
- `AspNetUserLogins` - External login information
- `AspNetUserTokens` - User tokens (2FA, etc.)

## How It Works

### Registration
1. User submits registration form with:
   - Username
   - Email
   - Password
   - Role (Admin users only can select roles)
2. Password is hashed and stored
3. User account is created in AspNetUsers
4. Confirmation email is sent (if configured)

### Login
1. User provides username/email and password
2. System validates credentials against database
3. On success:
   - Authentication cookie is created
   - User is signed in
   - Roles and claims are loaded

### Role-Based Access
1. Roles are stored in AspNetRoles
2. User-role assignments in AspNetUserRoles
3. Authorization is enforced via:
   - `[Authorize]` attributes
   - Role checks in components
   - Policy-based authorization

## User Types

### End Users (Default)
- Can create and view their own tickets
- Limited access to system features
- Auto-assigned on registration

### Support Agents
- Can view and manage tickets
- Access to ticket management features
- Must be assigned by admin

### Administrators
- Full system access
- Can manage user roles
- Can manage all tickets

## Testing Authentication

### Create Test Users
```sql
-- In SQLite CLI (Data/app.db)

-- Create a test user (password must be hashed correctly via registration)
-- It's recommended to create users through the application interface

-- View existing users
SELECT UserName, Email, EmailConfirmed 
FROM AspNetUsers;

-- View user roles
SELECT u.UserName, r.Name as Role
FROM AspNetUsers u
JOIN AspNetUserRoles ur ON u.Id = ur.UserId
JOIN AspNetRoles r ON ur.RoleId = r.Id;
```

### Common Operations
1. User Registration:
   - Navigate to `/Account/Register`
   - Fill in required fields
   - Submit form

2. User Login:
   - Navigate to `/Account/Login`
   - Enter username/email and password
   - Submit form

3. Role Assignment:
   - Login as admin
   - Navigate to `/admin/roles`
   - Select role for user

## Security Considerations

### Password Storage
- Passwords are hashed using ASP.NET Core Identity's password hasher
- Original passwords are never stored
- Salt is automatically generated and used

### Cookie Protection
- Authentication cookies are encrypted
- Anti-forgery tokens are used
- Secure cookie policy enforced

### Lockout Protection
- Failed login attempts are tracked
- Accounts can be locked after multiple failures
- Protects against brute force attacks

## Troubleshooting

### Common Issues

1. **Cannot Login**
   - Verify username/email and password
   - Check if account is confirmed (if required)
   - Check if account is locked

2. **Role Not Working**
   - Verify role exists in AspNetRoles
   - Check user-role assignment in AspNetUserRoles
   - Clear browser cookies and try again

3. **Registration Failed**
   - Check password meets requirements
   - Verify email is unique
   - Check database connectivity

### Debugging Tips
- Check application logs for authentication errors
- Use SQL queries to verify database state
- Monitor failed login attempts
- Check email configuration for confirmation emails

## Additional Security Recommendations
1. Enable HTTPS in production
2. Configure proper password requirements
3. Implement account lockout policies
4. Use secure headers
5. Regular security audits
6. Monitor authentication attempts
