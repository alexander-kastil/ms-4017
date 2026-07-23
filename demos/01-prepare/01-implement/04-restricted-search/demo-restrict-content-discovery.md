# Hands-On Demo: Take one site out of Copilot discovery and report on it tenant-wide

Goal: show that Restricted Content Discovery removes a site from discovery without touching a single permission, and that the report is the only way to answer "which sites are restricted?" once more than a handful are flagged.

Budget 20 minutes. You need a SharePoint Administrator, an active SharePoint Advanced Management subscription, a Microsoft 365 Copilot license for the test user, and one test site the user can reach.

## Steps

1. As the licensed test user, open Microsoft 365 Copilot and ask a question that only the test site can answer, for example a summary of a document stored there. Expected result: Copilot answers and the response carries a citation pointing at the file in that site. Keep this transcript on screen.

2. Sign in to the SharePoint admin center at `https://<tenant>-admin.sharepoint.com` and go to **Sites** > **Active sites**. Expected result: the site list opens with Site name, URL, Teams, Channel sites, Storage used (GB) and Primary admin columns, plus **Create**, **Export**, **Track view** and **Recent actions** commands.

3. Select the test site by name to open its details panel, then choose the **Settings** tab. Expected result: the panel shows Email, Privacy, External file sharing, Sensitivity label, **Restrict content discovery** with a **PRO** badge, **Restricted site access** with a **PRO** badge, Custom scripts, Version history limit and a **Save** button.

4. Point at the label before changing it. Expected result: the control is named **Restrict content discovery** with **On** and **Off** radio buttons. Older course material and some documentation call this "Restrict content from Microsoft 365 Copilot"; the portal does not.

5. Set **Restrict content discovery** to **On** and select **Save**. Expected result: the panel saves and the site is flagged. In **Active sites** the site now carries a **Restricted** indicator.

6. Confirm nothing was taken away. Have the test user open the same document directly by URL. Expected result: the file opens normally. Permissions are untouched, which is the single most important claim in this topic.

7. Repeat the prompt from step 1 as the same user. Expected result: the citation to that site is gone, and Copilot either answers from other sources or states it cannot find the information. If the site content still appears, say why out loud rather than reloading: propagation is slow, and a site over 500,000 items can take more than a week to fully reflect.

8. Delegate the control so site owners can set it themselves, then report on it tenant-wide:

```powershell
Set-SPOTenant -DelegateRestrictedContentDiscoverabilityManagement $true
Get-SPOTenant | Select-Object DelegateRestrictedContentDiscoverabilityManagement

Start-SPORestrictedContentDiscoverabilityReport
Get-SPORestrictedContentDiscoverabilityReport
```

Expected result: the tenant property returns `True`, and the report cmdlet returns a job with a report ID once generation completes. Download it with `Get-SPORestrictedContentDiscoverabilityReport -Action Download -ReportId <ReportGUID>`.

9. Turn **Restrict content discovery** back **Off** for the test site and save. Expected result: the setting reverts and the **Restricted** indicator clears. Tell the class that in a real rollout this step happens only after the site's permissions have actually been fixed, and that agent owners should be warned because their answers will change.

## Talking points

Step 6 is the step to slow down on. Every customer hears "restricted" and assumes a permission changed. Nothing did. The site was removed from organization-wide search and from Copilot grounding, and a user who already had access still has it.

Step 7 is where demos fail in front of a room, so set the expectation before you run it rather than after. Propagation is asynchronous and large sites are slow, and a demo tenant with a small test site is the only reliable way to show the change inside a class.

Step 8 explains why this scales where Restricted SharePoint Search did not. Delegation moves the decision to site owners with a recorded justification, and the report is the only tenant-wide answer to "what have we restricted", because the setting itself lives per site.

The retirement date belongs in this demo. Restricted SharePoint Search blocks new enablement from July 31, 2026. A tenant that still has it turned on should validate permissions and turn it off rather than treat it as a long-term control.

## Variation

If the tenant still has Restricted SharePoint Search enabled, run the migration version instead. Show the existing allow list and its 100-site limit, name which content the allow list never covered (the user's own OneDrive files, chats, mail and calendar, frequently visited sites, files shared directly with them, and the most recent 2,000 items they viewed, edited or created), then flag the equivalent high-risk sites with Restricted Content Discovery and turn the allow list off. This is the conversation most existing customers actually need.
