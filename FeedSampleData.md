# Loading Sample Data into Contoso Tech Support System

This document explains how to import the test data into your development environment. The sample data includes users with different roles (Admin, Support Agent, End User) and a comprehensive 3-year history of support tickets.

## Prerequisites

- Make sure you have SQLite installed on your system
- Ensure the application has been built at least once to create the app.db file

## Import Sample Data

To import the test data, follow these steps:

```sql
sqlite3 Data/app.db
-- Type the following commands in the SQLite console
.read Data/TestData/users.sql
.read Data/TestData/tickets.sql
.read Data/TestData/blazorTickets.sql
```

## Sample Data Overview

The imported data includes:

1. **Users (users.sql)**:
   - 7 Support Agents with varying tenure (3 years to new hires)
   - 100 End Users with realistic names and contact information
   - All users have proper role assignments in AspNetUserRoles
   - All test accounts use the password: `Test123!`

2. **Tickets (blazorTickets.sql)**:
   - 40+ support tickets spanning from 2022 to 2025
   - Realistic Blazor-related issues and descriptions
   - Varied statuses (Open, In Progress, On Hold, Resolved, Closed)
   - Different priority levels (Low, Medium, High, Critical)
   - Tickets distributed across time to simulate realistic system usage

## Accessing the System

After importing the data:

1. Launch the application
2. Login as any user from the users.sql file
   - Example Support Agent: `john.thompson@contoso.com` (password: `Test123!`)
   - Example End User: `robert.johnson@example.com` (password: `Test123!`)

## Working with the Sample Data

The sample data is designed to provide a realistic testing environment:

- Older tickets (2022-2023) are mostly Closed or Resolved
- Recent tickets (2024-early 2025) have mixed statuses
- Current tickets (2025 Q2) include several Open tickets
- Each support agent has tickets assigned to them based on their tenure
- Ticket descriptions are based on real Blazor development issues
