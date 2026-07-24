# Hands-On Demo: Take one site out of Copilot discovery and report on it tenant-wide

Goal: show that Restricted Content Discovery removes a site from Copilot discovery without changing any permission, and that the report is the only tenant-wide answer to "which sites are restricted?".

[Restricted Content Discovery for SharePoint sites](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)

## Steps

1. As the licensed test user, open Microsoft 365 Copilot and ask a question only the test site can answer. Expected: Copilot answers with a citation pointing at the file in that site; keep the transcript on screen.

2. In the [SharePoint admin center](https://admin.microsoft.com/sharepoint) (`https://<tenant>-admin.sharepoint.com`) go to **Sites** > **Active sites** and open the test site's **Settings** tab. Expected: the panel shows **Restrict content discovery** with a **PRO** badge.

3. Set **Restrict content discovery** to **On** and select **Save**. Expected: the panel saves and **Active sites** shows a **Restricted** indicator on the site.

4. Have the test user open the same document directly by URL. Expected: the file opens normally; permissions are untouched.

5. Repeat the prompt from step 1 as the same user. Expected: the citation to that site is gone (propagation is slow; a site over 500,000 items can take more than a week).

6. Delegate the control to site owners and generate the tenant-wide report:

```powershell
Set-SPOTenant -DelegateRestrictedContentDiscoverabilityManagement $true
Get-SPOTenant | Select-Object DelegateRestrictedContentDiscoverabilityManagement

Start-SPORestrictedContentDiscoverabilityReport
Get-SPORestrictedContentDiscoverabilityReport
```

   Expected: the tenant property returns `True` and the report cmdlet returns a job with a report ID; download it with `Get-SPORestrictedContentDiscoverabilityReport -Action Download -ReportId <ReportGUID>`.

7. Turn **Restrict content discovery** back **Off** for the test site and save. Expected: the setting reverts and the **Restricted** indicator clears.
