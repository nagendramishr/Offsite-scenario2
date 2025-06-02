using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using off2.Data.Enums;

namespace off2.Data;

public class RoleHelper
{
    private readonly RoleManager<IdentityRole> _roleManager;
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly AuthenticationStateProvider _authStateProvider;

    public RoleHelper(
        RoleManager<IdentityRole> roleManager,
        UserManager<ApplicationUser> userManager,
        AuthenticationStateProvider authStateProvider)
    {
        _roleManager = roleManager;
        _userManager = userManager;
        _authStateProvider = authStateProvider;
    }

    public async Task EnsureRolesCreatedAsync()
    {
        foreach (var role in Enum.GetValues<UserRole>())
        {
            var roleName = role.ToString();
            if (!await _roleManager.RoleExistsAsync(roleName))
            {
                await _roleManager.CreateAsync(new IdentityRole(roleName));
            }
        }
    }

    public async Task<bool> IsAdmin()
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        return authState.User.IsInRole(UserRole.Admin.ToString());
    }

    public async Task<bool> IsAgent()
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        return authState.User.IsInRole(UserRole.SupportAgent.ToString());
    }

    public async Task<bool> IsEndUser()
    {
        var authState = await _authStateProvider.GetAuthenticationStateAsync();
        return authState.User.IsInRole(UserRole.EndUser.ToString());
    }

    public async Task<UserRole> GetUserRoleAsync(ApplicationUser user)
    {
        var roles = await _userManager.GetRolesAsync(user);
        var roleStr = roles.FirstOrDefault();
        return roleStr != null ? Enum.Parse<UserRole>(roleStr) : UserRole.EndUser;
    }

    public async Task UpdateUserRoleAsync(ApplicationUser user, UserRole newRole)
    {
        var currentRoles = await _userManager.GetRolesAsync(user);
        
        // Remove existing roles
        if (currentRoles.Any())
        {
            await _userManager.RemoveFromRolesAsync(user, currentRoles);
        }

        // Add new role
        await _userManager.AddToRoleAsync(user, newRole.ToString());
        
        // Update the Role property
        user.Role = newRole;
    }
}
