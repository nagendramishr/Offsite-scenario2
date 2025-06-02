using Microsoft.AspNetCore.Identity;
using off2.Data.Enums;
using System.Linq;
using System.Security.Claims;

namespace off2.Data;

// Add profile data for application users by adding properties to the ApplicationUser class
public class ApplicationUser : IdentityUser
{    // Current role of the user, defaulting to EndUser
    public UserRole Role { get; set; } = UserRole.EndUser;
}

