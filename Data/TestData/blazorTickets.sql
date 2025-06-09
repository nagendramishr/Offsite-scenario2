-- Insert test tickets for the Contoso Tech Support Blazor Application
-- These tickets span the past 3 years of system usage (2022-2025)

-- Ticket Status Reference:
-- 0 = Open
-- 1 = InProgress
-- 2 = OnHold
-- 3 = Resolved
-- 4 = Closed

-- Ticket Priority Reference:
-- 0 = Low
-- 1 = Medium
-- 2 = High
-- 3 = Critical

-- ===================================================
-- Group 1: Older Tickets (2022) - Mostly Closed
-- ===================================================

INSERT INTO Tickets (Title, Description, Status, Priority, CreatedAt, UpdatedAt, CreatedById, AssignedToId, Category)
VALUES
    -- Q1 2022
    ('Blazor component not rendering correctly', 
    'I created a custom Blazor component but it''s not displaying properly in my application. The CSS seems to be ignored.', 
    4, 1, '2022-01-12 10:23:15', '2022-01-15 14:30:22', 
    '6a8c63e1-7732-4553-8451-ca38f7a3bbdb', -- robert.johnson (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Blazor UI'),
    
    ('Authentication failing with external provider', 
    'Our application uses external authentication but users are getting kicked back to the login page after successful authentication with Google.', 
    4, 2, '2022-02-05 09:12:32', '2022-02-07 11:45:09', 
    'b7cd89c2-9355-40d5-a80a-7e917cdab69f', -- jennifer.smith (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Authentication'),
    
    ('Error handling in Blazor components', 
    'Need guidance on implementing proper error handling in our Blazor components. Currently, errors cause the entire application to crash.', 
    4, 1, '2022-03-17 14:32:45', '2022-03-19 10:15:27', 
    '2e5f36b7-9ed1-4acc-87a3-08fdff5fb190', -- michael.brown (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Error Handling'),
    
    -- Q2 2022
    ('Data binding not working in forms', 
    'I''m trying to implement two-way data binding in our form components but the model is not updating correctly when the user modifies the input.', 
    4, 1, '2022-04-03 08:45:10', '2022-04-05 16:32:18', 
    'de9fb414-ead9-418d-93a5-1f8eabf65a58', -- sarah.williams (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Data Binding'),
    
    ('Issues with dependency injection in Blazor', 
    'We''re trying to inject a service into our Blazor component but getting errors. The service is registered in Program.cs but still throws NullReferenceException.', 
    4, 2, '2022-05-22 11:30:05', '2022-05-24 09:12:38', 
    'cfd3d070-23b2-46e9-b0ea-3b6a6a40a6c6', -- david.miller (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Dependency Injection'),
    
    ('CSS isolation not working properly', 
    'We''ve implemented CSS isolation for our components but the styles are bleeding into other components on the page.', 
    4, 1, '2022-06-14 13:24:56', '2022-06-16 15:40:12', 
    '85a83a8a-6b75-4f24-9b08-ddcbf9b4d0a3', -- jessica.davis (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'CSS Isolation'),
    
    -- Q3 2022
    ('Routing issues with nested components', 
    'Our application has nested routing but the child routes are not working properly. Getting "page not found" errors.', 
    4, 2, '2022-07-08 09:15:30', '2022-07-10 14:25:40', 
    'e16d09c8-5cd9-4f2c-9aa0-0c9b7070cee7', -- thomas.anderson (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Routing'),
    
    ('Component lifecycle methods not firing', 
    'The OnInitializedAsync method in our components doesn''t seem to be executing. We need to load data when the component initializes.', 
    4, 1, '2022-08-19 10:45:22', '2022-08-21 11:30:15', 
    '3d7736a3-2a7f-40c1-a96d-513b505a91c9', -- elizabeth.taylor (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Component Lifecycle'),
    
    ('HTTP client not working with API calls', 
    'We''re trying to make API calls using HttpClient in our Blazor WebAssembly app but getting CORS errors.', 
    4, 2, '2022-09-05 14:20:33', '2022-09-07 16:45:19', 
    'c53c2d7e-ce46-4b0e-a3f5-afdcd7f1be3a', -- richard.white (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'HTTP Client'),
    
    -- Q4 2022
    ('Form validation not displaying error messages', 
    'We''ve implemented form validation in our Blazor app but the validation error messages are not displaying to the user.', 
    4, 1, '2022-10-12 08:30:45', '2022-10-14 10:15:22', 
    '90e7a40f-1925-4b50-94e1-e32da19d8df1', -- patricia.moore (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Form Validation'),
    
    ('Event handling not working in child components', 
    'We have a parent component that should respond to events from child components, but the event callbacks are not triggering.', 
    4, 2, '2022-11-24 11:10:05', '2022-11-26 13:40:18', 
    'ed042b7f-64a7-4a0e-8ba2-7aa24c318ad5', -- james.wilson (customer)
    '13ed5b02-9857-4496-8be3-5409b95d2a1c', -- daniel.rodriguez (agent)
    'Event Handling'),
    
    ('File upload component not working', 
    'Our file upload component is not processing files correctly. The files are not being sent to the server properly.', 
    4, 1, '2022-12-07 15:25:38', '2022-12-09 09:50:15', 
    'b51b0cfd-d2b6-43b8-9363-ea4ea2c31f26', -- linda.jackson (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'File Upload'),

-- ===================================================
-- Group 2: Mid-age Tickets (2023) - Mix of Closed and Resolved
-- ===================================================
    
    -- Q1 2023
    ('Issues with globalization in Blazor', 
    'Our application needs to support multiple languages, but the globalization features in Blazor are not working as expected.', 
    4, 2, '2023-01-15 10:20:30', '2023-01-18 14:15:45', 
    'e0e9b2a3-3d20-4f45-93d4-23b4f4d6726c', -- william.johnson (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Globalization'),
    
    ('Error boundary component not catching errors', 
    'We''ve implemented an error boundary component but it''s not catching exceptions from child components as expected.', 
    4, 1, '2023-02-08 09:30:15', '2023-02-10 11:45:22', 
    '4d47b35e-b2d1-4c45-89bd-d9a3d7e7482b', -- barbara.taylor (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Error Boundary'),
    
    ('Authentication state not persisting after refresh', 
    'Users are getting logged out whenever they refresh the page, even though we''re using the built-in authentication state provider.', 
    4, 2, '2023-03-19 13:40:25', '2023-03-22 15:20:10', 
    '7ee22f7d-5d8a-4e61-9e14-b65b5174a59b', -- steven.harris (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Authentication'),
    
    -- Q2 2023
    ('Slow performance with large data sets', 
    'Our application is experiencing significant slowdowns when rendering components with large data sets. Need optimization guidance.', 
    4, 3, '2023-04-04 11:15:40', '2023-04-07 16:30:25', 
    'f9a7e3a1-7c68-4d25-bd9a-00dfd8c2abcf', -- donna.martinez (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Performance'),
    
    ('Authorization policies not being enforced', 
    'We''ve defined authorization policies but they''re not being enforced correctly. Users can access pages they shouldn''t be able to.', 
    4, 2, '2023-05-16 08:45:20', '2023-05-19 10:20:15', 
    'd8c6b42e-9c5a-4d61-a29c-0186cf8b1b1d', -- charles.thompson (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Authorization'),
    
    ('Issues with input validation in forms', 
    'The input validation in our forms is too aggressive, preventing users from entering valid data in some cases.', 
    4, 1, '2023-06-28 14:30:55', '2023-06-30 09:15:40', 
    '2f7a41d3-5b0e-4b42-bf69-9c5aa9c28ddb', -- margaret.lewis (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Input Validation'),
    
    -- Q3 2023
    ('Blazor WebAssembly app crashing on mobile devices', 
    'Our Blazor WebAssembly application works fine on desktop browsers but crashes frequently on mobile devices, especially iOS.', 
    3, 2, '2023-07-10 10:10:25', '2023-07-13 14:45:30', 
    '80a4d5cc-a39b-4f4d-89c6-f0b3b2e5d0d1', -- joseph.clark (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Mobile Compatibility'),
    
    ('SignalR connection issues in Blazor', 
    'Our real-time features using SignalR are not working properly. Connections are being dropped unexpectedly.', 
    3, 2, '2023-08-22 09:25:15', '2023-08-25 11:40:20', 
    '1e6b2c3d-4a5b-6c7d-8e9f-0a1b2c3d4e5f', -- nancy.rodriguez (customer)
    '13ed5b02-9857-4496-8be3-5409b95d2a1c', -- daniel.rodriguez (agent)
    'SignalR'),
    
    ('Memory leaks in Blazor WebAssembly application', 
    'Our application is consuming more and more memory the longer it runs, eventually causing the browser tab to crash.', 
    3, 3, '2023-09-14 13:20:35', '2023-09-17 15:50:40', 
    '3a2b1c0d-9e8f-7d6c-5b4a-3d2e1f0c9b8a', -- george.lee (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Performance'),
    
    -- Q4 2023
    ('Custom authentication failing with JWT tokens', 
    'We''ve implemented JWT authentication but tokens are not being properly validated, causing security issues.', 
    3, 3, '2023-10-05 08:15:25', '2023-10-08 10:30:15', 
    '9b8a7c6d-5e4f-3d2e-1f0c-9b8a7c6d5e4f', -- carol.garcia (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Authentication'),
    
    ('Blazor Server app disconnecting frequently', 
    'Our Blazor Server application is disconnecting frequently, especially for users with slower internet connections.', 
    3, 2, '2023-11-17 11:40:30', '2023-11-20 14:15:25', 
    '5f4e3d2c-1b0a-9f8e-7d6c-5b4a3d2e1f0c', -- edward.martin (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Connectivity'),
    
    ('Problems with localization in Blazor application', 
    'Our localization setup is not working correctly. Some strings are not being translated properly.', 
    3, 1, '2023-12-09 15:25:40', '2023-12-12 09:50:35', 
    '1f0e9d8c-7b6a-5e4d-3c2b-1a0f9e8d7c6b', -- helen.walker (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Globalization'),

-- ===================================================
-- Group 3: Recent Tickets (2024) - Mix of Statuses
-- ===================================================
    
    -- Q1 2024
    ('State management issues in complex forms', 
    'We have a multi-step form with complex state management that''s not working properly. State is being lost between steps.', 
    3, 2, '2024-01-22 10:30:15', '2024-01-25 14:45:20', 
    '7c6b5a4d-3e2f-1d0c-9b8a-7c6b5a4d3e2f', -- kevin.roberts (customer)
    '13ed5b02-9857-4496-8be3-5409b95d2a1c', -- daniel.rodriguez (agent)
    'State Management'),
    
    ('Performance issues with virtualized lists', 
    'Our virtualized lists are not performing well with large data sets. Scrolling is jerky and CPU usage spikes.', 
    3, 2, '2024-02-14 09:15:30', '2024-02-17 11:20:25', 
    '5a4d3e2f-1c0b-9a8d-7c6b-5a4d3e2f1c0b', -- mary.adams (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Performance'),
    
    ('Integration issues with third-party JavaScript libraries', 
    'We''re having trouble integrating a complex third-party JavaScript library with our Blazor components.', 
    3, 1, '2024-03-08 13:40:25', '2024-03-11 15:50:30', 
    '3e2f1c0b-9a8d-7c6b-5a4d-3e2f1c0b9a8d', -- paul.wright (customer)
    '2af3bd42-1c6a-4cb1-a9f2-90bd2e258f1d', -- olivia.washington (agent)
    'JavaScript Interop'),
    
    -- Q2 2024
    ('Problems with server-side rendering', 
    'Our Blazor application has issues with server-side rendering. Initial page load shows incorrect or missing content.', 
    2, 2, '2024-04-19 11:25:40', '2024-04-22 14:30:35', 
    '1c0b9a8d-7c6b-5a4d-3e2f-1c0b9a8d7c6b', -- susan.lopez (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Rendering'),
    
    ('Authentication issues with federated identity', 
    'Our federated identity setup with Azure AD is not working properly. Users are experiencing authentication failures.', 
    2, 3, '2024-05-11 08:45:20', '2024-05-14 10:15:30', 
    '9a8d7c6b-5a4d-3e2f-1c0b-9a8d7c6b5a4d', -- brian.nelson (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Authentication'),
    
    ('CSS isolation breaking after upgrade', 
    'After upgrading to the latest version of .NET, our CSS isolation is no longer working correctly.', 
    2, 1, '2024-06-23 14:10:35', '2024-06-26 16:20:40', 
    '7c6b5a4d-3e2f-1c0b-9a8d-7c6b5a4d3e2f', -- karen.hill (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'CSS Isolation'),
    
    -- Q3 2024
    ('Problems with lazy loading in Blazor', 
    'Our lazy loading implementation for Blazor components is not working properly. Components are loading too slowly or not at all.', 
    1, 2, '2024-07-05 10:20:15', '2024-07-08 13:30:25', 
    '5a4d3e2f-1c0b-9a8d-7c6b-5a4d3e2f1c0b', -- mark.baker (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Performance'),
    
    ('Security vulnerabilities in authentication flow', 
    'Our security audit found potential vulnerabilities in our authentication flow that need to be addressed.', 
    1, 3, '2024-08-17 09:45:30', '2024-08-20 11:50:35', 
    '3e2f1c0b-9a8d-7c6b-5a4d-3e2f1c0b9a8d', -- lisa.gonzalez (customer)
    '13ed5b02-9857-4496-8be3-5409b95d2a1c', -- daniel.rodriguez (agent)
    'Security'),
    
    ('Issues with progressive web app functionality', 
    'Our Blazor WebAssembly PWA is not working properly offline. Cached resources are not being served correctly.', 
    1, 2, '2024-09-29 13:15:40', '2024-10-02 15:25:45', 
    '1c0b9a8d-7c6b-5a4d-3e2f-1c0b9a8d7c6b', -- robert.ross (customer)
    '2af3bd42-1c6a-4cb1-a9f2-90bd2e258f1d', -- olivia.washington (agent)
    'Progressive Web App'),
    
    -- Q4 2024
    ('Performance degradation after recent update', 
    'After our recent update, the application performance has degraded significantly. Pages are loading much slower.', 
    1, 3, '2024-10-12 11:30:20', '2024-10-15 14:40:25', 
    '9a8d7c6b-5a4d-3e2f-1c0b-9a8d7c6b5a4d', -- michelle.rivera (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Performance'),
    
    ('Inconsistent behavior with two-way binding', 
    'Our two-way binding is behaving inconsistently across different components and browsers.', 
    1, 2, '2024-11-24 08:50:35', '2024-11-27 10:15:40', 
    '7c6b5a4d-3e2f-1c0b-9a8d-7c6b5a4d3e2f', -- donald.cook (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Data Binding'),
    
    ('Accessibility issues with custom components', 
    'Our custom components are not meeting accessibility standards. Screen readers are not properly announcing content.', 
    1, 2, '2024-12-07 14:25:45', '2024-12-10 16:35:50', 
    '5a4d3e2f-1c0b-9a8d-7c6b-5a4d3e2f1c0b', -- sandra.price (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Accessibility'),

-- ===================================================
-- Group 4: Current Tickets (2025) - Mostly Open
-- ===================================================
    
    -- Q1 2025
    ('Issues with component parameter binding', 
    'Our component parameter binding is not working correctly. Changes to parameters are not triggering component updates.', 
    1, 2, '2025-01-19 10:15:25', '2025-01-22 13:20:30', 
    '3e2f1c0b-9a8d-7c6b-5a4d-3e2f1c0b9a8d', -- timothy.watson (customer)
    '5d1c40b8-58a5-4d67-82b3-f7a6f3a68438', -- sophia.patel (agent)
    'Data Binding'),
    
    ('Problems with authentication in PWA mode', 
    'Our authentication flow breaks when the application is installed as a PWA. Users can''t log in properly.', 
    1, 3, '2025-02-11 09:40:35', '2025-02-14 11:45:40', 
    '1c0b9a8d-7c6b-5a4d-3e2f-1c0b9a8d7c6b', -- nancy.collins (customer)
    '13ed5b02-9857-4496-8be3-5409b95d2a1c', -- daniel.rodriguez (agent)
    'Authentication'),
    
    ('Security audit findings need addressing', 
    'Our recent security audit found several issues in our Blazor application that need to be addressed urgently.', 
    0, 3, '2025-03-04 13:05:45', '2025-03-07 15:10:50', 
    '9a8d7c6b-5a4d-3e2f-1c0b-9a8d7c6b5a4d', -- gary.murphy (customer)
    '70f2af46-88df-4025-adbd-e5382a5910e7', -- john.thompson (agent)
    'Security'),
    
    -- Q2 2025 (Current Quarter)
    ('Unexpected behavior with component rendering', 
    'Our components are rendering in an unexpected order, causing visual glitches and functional issues.', 
    0, 2, '2025-04-16 11:20:30', '2025-04-19 14:25:35', 
    '7c6b5a4d-3e2f-1c0b-9a8d-7c6b5a4d3e2f', -- sharon.torres (customer)
    'd57f79f4-5cc2-4a26-b2e6-0d4c65b0a844', -- emily.reynolds (agent)
    'Rendering'),
    
    ('Critical performance issues in production', 
    'Our production environment is experiencing critical performance issues that are not reproducible in development.', 
    0, 3, '2025-05-08 08:35:40', '2025-05-11 10:40:45', 
    '5a4d3e2f-1c0b-9a8d-7c6b-5a4d3e2f1c0b', -- larry.simmons (customer)
    'eb15cb97-395e-4c5e-9112-a67bc324e8a3', -- alexander.chen (agent)
    'Performance'),
    
    ('JavaScript interop failures after browser update', 
    'After recent Chrome and Firefox updates, our JavaScript interop is failing in certain scenarios.', 
    0, 2, '2025-05-21 14:50:50', '2025-05-24 16:55:55', 
    '3e2f1c0b-9a8d-7c6b-5a4d-3e2f1c0b9a8d', -- betty.cooper (customer)
    '2af3bd42-1c6a-4cb1-a9f2-90bd2e258f1d', -- olivia.washington (agent)
    'JavaScript Interop'),
    
    ('Authentication token expiration issues', 
    'Our authentication tokens are expiring too quickly, causing users to be logged out unexpectedly.', 
    0, 3, '2025-06-02 10:05:15', NULL, 
    '1c0b9a8d-7c6b-5a4d-3e2f-1c0b9a8d7c6b', -- jeffrey.reed (customer)
    '84bf359e-f99d-46c3-8dbc-4c35cf0d6306', -- benjamin.nguyen (agent)
    'Authentication'),
    
    ('Form validation not working after .NET update', 
    'After updating to the latest .NET version, our form validation has stopped working correctly.', 
    0, 2, '2025-06-05 13:30:25', NULL, 
    '9a8d7c6b-5a4d-3e2f-1c0b-9a8d7c6b5a4d', -- kimberly.hughes (customer)
    NULL, -- Not yet assigned
    'Form Validation'),
    
    ('Component state lost during page navigation', 
    'Our component state is being lost during page navigation, even though we''re using state containers.', 
    0, 2, '2025-06-07 09:45:35', NULL, 
    '7c6b5a4d-3e2f-1c0b-9a8d-7c6b5a4d3e2f', -- ronald.kelly (customer)
    NULL, -- Not yet assigned
    'State Management'),
    
    ('CSS isolation conflicts with third-party libraries', 
    'Our CSS isolation is conflicting with styles from third-party libraries, causing visual issues.', 
    0, 1, '2025-06-08 15:10:45', NULL, 
    '5a4d3e2f-1c0b-9a8d-7c6b-5a4d3e2f1c0b', -- deborah.sullivan (customer)
    NULL, -- Not yet assigned
    'CSS Isolation');