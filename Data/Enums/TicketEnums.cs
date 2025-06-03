namespace off2.Data.Enums;

public enum TicketStatus
{
    Open,
    InProgress,
    OnHold,
    Resolved,
    Closed
}

public enum TicketPriority
{
    Low,
    Medium,
    High,
    Critical
}

public enum UserRole
{
    EndUser,
    SupportAgent,
    Admin
}
