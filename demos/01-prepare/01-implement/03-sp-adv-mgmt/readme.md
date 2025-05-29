# SharePoint Advanced Management

[SharePoint Advanced Management](https://learn.microsoft.com/en-us/sharepoint/advanced-management?WT.mc_id=365AdminCSH_spo)

## Key Features of SAM

### Block Download Policy for SharePoint and OneDrive

Blocks downloading, printing, or syncing of files from targeted sites
Configured via PowerShell for individual sites or organization-wide
Users can still work on files using Office online applications
Can target specific sensitivity labels or mark entire sites as read-only

### Change History Report

Creates detailed CSV reports of site actions and organization setting changes
Covers the last 180 days of changes by Global, SharePoint, and Site Administrators
Helps monitor configuration changes and maintain desired organizational state

### Conditional Access Policies for SharePoint and OneDrive

Works with Microsoft Entra Authentication Context
Enforces stricter access controls for specific SharePoint sites
Can require additional authentication, corporate-managed devices, or Terms of Use acceptance
Has limitations with certain apps (Viva Engage, Teams web app, OneDrive sync, etc.)

### Data Access Governance Reports

Helps identify potential oversharing of SharePoint sites
Provides three types of reports:

Sharing Links Report (external sharing analysis)
Sensitivity Labels Applied to Files Report
Shared with 'Everyone except external users' Report

Limited to 100 sites in admin center view, up to 10,000 in CSV downloads

### Default Sensitivity Labels for Document Libraries

Automatically applies labels to new files uploaded to specific libraries
Provides location-based labeling without content inspection
Only affects new documents, not existing ones
Now requires Microsoft 365 E5/A5/G5 licenses

### OneDrive Access Restriction Policy

Restricts OneDrive access to members of specific security groups
Prevents unauthorized access even if files were previously shared
Configured through SharePoint Admin Center or PowerShell

### Recent SharePoint Admin Actions

Shows the last 30 changes made by the logged-in admin
Extended history (beyond current session) requires SAM license
Only displays changes by the current admin, not organization-wide changes

### Site Lifecycle Management

Automated, rule-based policies to manage inactive sites
Identifies sites based on inactivity criteria
Sends automated notifications to site owners for certification
Includes AI Insights for cleanup recommendations

### Site-Level Access Restriction

Restricts site access to specific group members only
Helps minimize oversharing risks, especially important for Copilot deployments
Works with Microsoft 365 groups, Teams-connected, and non-group connected sites
Must be configured at organization level before applying to individual sites
