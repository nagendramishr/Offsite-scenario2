using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;

namespace off2.Components.Account;

public class RoleAuthStateProvider : AuthenticationStateProvider
{
    private readonly AuthenticationStateProvider _baseAuthStateProvider;
    
    public RoleAuthStateProvider(AuthenticationStateProvider baseAuthStateProvider)
    {
        _baseAuthStateProvider = baseAuthStateProvider;
    }

    public override async Task<AuthenticationState> GetAuthenticationStateAsync()
    {
        return await _baseAuthStateProvider.GetAuthenticationStateAsync();
    }
}
