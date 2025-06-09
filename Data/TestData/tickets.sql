-- Insert test tickets for the Contoso Tech Support system
-- These tickets span the past 3 years of system usage

-- Ticket Status Reference:
-- 0 = New
-- 1 = In Progress
-- 2 = Waiting for Customer
-- 3 = Waiting for Third Party
-- 4 = Resolved
-- 5 = Closed

-- Ticket Priority Reference:
-- 0 = Low
-- 1 = Medium
-- 2 = High
-- 3 = Critical

-- Group 1: Older Tickets (2-3 years ago) - Mostly Closed
INSERT INTO Tickets (Title, Description, Status, Priority, CreatedAt, UpdatedAt, CreatedById, AssignedToId, Category)
VALUES    -- Long-time user ticket (closed, high priority)
    ('Unable to access customer portal', 
    'I cannot log into the customer portal. It keeps saying my password is incorrect even after resetting it.', 
    5, 2, '2022-07-15 09:23:15', '2022-07-17 14:30:22', 
    '6a8c63e1-7732-4553-8451-ca38f7a3bbdb', -- robert.johnson (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Account Access'),    -- Long-time user ticket (closed, medium priority)
    ('Invoice PDF not downloading correctly', 
    'When I try to download my invoice as a PDF, I get a blank page. This happens for all recent invoices.', 
    5, 1, '2022-08-03 11:47:32', '2022-08-05 16:12:09', 
    'b7cd89c2-9355-40d5-a80a-7e917cdab69f', -- jennifer.smith (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Billing'),    -- Ticket with multiple comments and updates (complex history)
    ('System crash during data import', 
    'The system crashes whenever I try to import more than 1000 records from our Excel sheet. This is urgent as we need to complete this import by end of week.', 
    5, 3, '2022-09-21 08:05:44', '2022-09-24 17:30:19', 
    'e3f2dd17-f0ca-45fc-a1ca-d8a5e631bf6e', -- michael.williams (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Technical Issue');

-- Group 2: Medium-age Tickets (1-2 years ago) - Mix of Closed and Resolved
INSERT INTO Tickets (Title, Description, Status, Priority, CreatedAt, UpdatedAt, CreatedById, AssignedToId, Category)
VALUES    -- Mid-term user ticket (resolved, low priority)
    ('Feature request: Export to CSV', 
    'Would it be possible to add an export to CSV feature for the reports section? This would help us integrate with our analytics tools.', 
    4, 0, '2023-03-12 15:20:37', '2023-03-20 10:15:42', 
    '1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', -- richard.thomas (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Feature Request'),    -- Mid-term user ticket (resolved, high priority)
    ('Security concern with user permissions', 
    'I noticed that standard users can see admin-level reports in the analytics dashboard. This seems like a security issue that needs immediate attention.', 
    4, 2, '2023-05-28 09:12:54', '2023-05-28 15:45:21', 
    '2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', -- karen.jackson (customer)
    '13ed5b02-9857-4496-8be3-5409b95d2a1c', -- daniel.rodriguez (agent)
    'Security'),    -- Complex ticket with multiple assignments (escalated)
    ('Data discrepancy between reports', 
    'The monthly sales report and the product performance report show different totals for the same period. We need to understand which one is correct.', 
    5, 1, '2023-08-17 14:33:27', '2023-08-25 11:28:35', 
    '3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', -- charles.white (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent, initially)
    'Reporting');

-- Group 3: Recent Tickets (last 6 months) - Many still active
INSERT INTO Tickets (Title, Description, Status, Priority, CreatedAt, UpdatedAt, CreatedById, AssignedToId, Category)
VALUES    -- Recent ticket (in progress, critical priority)
    ('Unable to process payments', 
    'Since this morning, our customers are unable to complete purchases. The payment processing page shows an error after entering credit card details. This is causing significant revenue loss.', 
    1, 3, '2025-01-15 08:42:19', '2025-01-15 09:15:32', 
    'a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d6', -- steve.rodriguez (customer)
    '2af3bd42-1c6a-4cb1-a9f2-90bd2e258f1d', -- olivia.washington (agent)
    'Billing'),    -- Recent ticket (waiting for customer, medium priority)
    ('Bulk user import not working', 
    'I tried to import 200 users using the bulk import template, but nothing happened after I clicked submit. No error message was displayed.', 
    2, 1, '2025-02-20 13:27:45', '2025-02-21 10:35:18', 
    'b2c3d4e5-f6a7-b8c9-d0e1-f2a3b4c5d6e7', -- helen.lee (customer)
    '84bf359e-f99d-46c3-8dbc-4c35cf0d6306', -- benjamin.nguyen (agent)
    'User Management'),    -- Brand new ticket (not yet assigned)
    ('Dashboard loading very slowly', 
    'For the past week, the main dashboard has been taking over 30 seconds to load. This is affecting our team\'s productivity as we use it constantly throughout the day.', 
    0, 2, '2025-06-07 16:05:22', '2025-06-07 16:05:22', 
    'c3d4e5f6-a7b8-c9d0-e1f2-a3b4c5d6e7f8', -- paul.walker (customer)
    NULL, -- Not yet assigned
    'Performance');

-- Group 4: Current Active Tickets
INSERT INTO Tickets (Title, Description, Status, Priority, CreatedAt, UpdatedAt, CreatedById, AssignedToId, Category)
VALUES    -- Current ticket (new, high priority)
    ('API integration failing with timeout', 
    'Our integration with your API is failing with timeout errors. This started happening yesterday and is affecting our automated processes.', 
    0, 2, '2025-06-08 09:12:34', '2025-06-08 09:12:34', 
    'd4e5f6a7-b8c9-d0e1-f2a3-b4c5d6e7f8a9', -- deborah.hall (customer)
    NULL, -- Not yet assigned
    'API'),    -- Current ticket (in progress, medium priority)
    ('Need assistance with custom report', 
    'I\'m trying to create a custom report that shows user activity by department, but I can\'t figure out how to add the department field as a filter.', 
    1, 1, '2025-06-08 10:45:29', '2025-06-08 11:30:15', 
    'e5f6a7b8-c9d0-e1f2-a3b4-c5d6e7f8a9b0', -- mark.allen (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Reporting'),    -- Current ticket (waiting for third party, critical priority)
    ('Integration with Salesforce broken', 
    'After the latest update, our Salesforce integration is no longer syncing data. This is critical for our sales team operations.', 
    3, 3, '2025-06-09 08:30:00', '2025-06-09 09:45:12', 
    'f6a7b8c9-d0e1-f2a3-b4c5-d6e7f8a9b0c1', -- cynthia.young (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Integration');

-- Additional ticket comments/history would go here

-- INSERT INTO TicketComments (TicketId, Content, CreatedAt, CreatedById, IsEdited)
-- VALUES
--     (1, 'I\'ve reset your password from the admin panel. Please try logging in with the temporary password I\'ve sent to your email.', '2022-07-15 10:15:22', '70f2af46-88df-4025-adbd-e5382a5910e7', 0),
--     (1, 'Thank you, I can log in now.', '2022-07-16 09:35:47', '6a8c63e1-7732-4553-8451-ca38f7a3bbdb', 0);

-- Additional ticket attachments would go here

-- INSERT INTO TicketAttachments (TicketId, FileName, ContentType, FilePath, FileSize, UploadedAt, UploadedById)
-- VALUES
--     (5, 'screenshot.png', 'image/png', '/uploads/2023/05/screenshot.png', 245678, '2023-05-28 09:13:05', '2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e');

-- Additional ticket audit records would go here

-- INSERT INTO TicketAudits (TicketId, Action, FieldName, OldValue, NewValue, ChangedAt, ChangedById)
-- VALUES
--     (6, 'AssignmentChange', 'AssignedToId', '70f2af46-88df-4025-adbd-e5382a5910e7', 'eb15cb97-395e-4c5e-9112-a67bc324e8a3', '2023-08-20 15:22:43', '70f2af46-88df-4025-adbd-e5382a5910e7');