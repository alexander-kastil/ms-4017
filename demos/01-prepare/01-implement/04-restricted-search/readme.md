# Limit what Copilot can discover

> **Restricted SharePoint Search is retiring.** Starting **July 31, 2026**, new enablement is blocked. Use **Restricted Content Discovery (RCD)** instead. Tenants that already have Restricted SharePoint Search enabled should validate permissions and turn it off.

[Restricted SharePoint Search](https://learn.microsoft.com/en-us/sharepoint/restricted-sharepoint-search)

[Restricted Content Discovery](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)

[Secure and govern Microsoft 365 Copilot: foundational deployment guidance](https://learn.microsoft.com/en-us/microsoft-365/copilot/secure-govern-copilot-foundational-deployment-guidance)

Hands-On Demo: [Take one site out of Copilot discovery and report on it tenant-wide](demo-restrict-content-discovery.md)

Both features answer the same customer question: "we are not confident our SharePoint permissions are clean, and we want Copilot rolled out anyway." Both are explicitly temporary. Neither is a security boundary, and neither changes a single permission.

## Restricted SharePoint Search (the outgoing approach)

An allow list of up to 100 SharePoint sites, applied tenant-wide. Only sites on the list appear in organization-wide search and Copilot responses. Hub sites count as one entry, and their associated sites are covered without counting against the limit.

The allow list is not the whole story, which is the point students most often miss. Even with it enabled, users still see their own OneDrive files, chats, mail and calendar, files from frequently visited sites, files shared directly with them, and anything they viewed, edited or created. Those last three categories are capped at the most recent 2,000 items.

Why Microsoft is retiring it:

- 100 sites does not scale once an organization runs Copilot and agents broadly.
- It degrades search for everyone, including users who never touch Copilot.
- It starves Copilot of grounding data, which shows up as vague or incomplete answers.

## Restricted Content Discovery (the current approach)

RCD inverts the model. Instead of an allow list of the few sites permitted, you flag the individual sites that must not be discovered, and everything else behaves normally. A flagged site shows a **Restricted** tag in the SharePoint admin center.

RCD requires SharePoint Advanced Management and a Microsoft 365 Copilot license. It applies to SharePoint sites only, not OneDrive.

Enable it per site in the SharePoint admin center:

- **Sites** > **Active sites** > select the site > **Settings** tab
- Set **Restrict content discovery** (carrying a **PRO** badge) to **On**, then **Save**

The portal names this control **Restrict content discovery**. Microsoft Learn and older course material call it "Restrict content from Microsoft 365 Copilot", which is not the label on screen.

Or with PowerShell:

```powershell
Set-SPOSite -Identity <site-url> -RestrictContentOrgWideSearch $true
Get-SPOSite -Identity <site-url> | Select RestrictContentOrgWideSearch
```

Delegate the setting to site administrators, who then have to supply a justification for each change:

```powershell
Set-SPOTenant -DelegateRestrictedContentDiscoverabilityManagement $true
Get-SPOTenant | Select-Object DelegateRestrictedContentDiscoverabilityManagement
```

Report on which sites are restricted across the tenant:

```powershell
Start-SPORestrictedContentDiscoverabilityReport
Get-SPORestrictedContentDiscoverabilityReport
Get-SPORestrictedContentDiscoverabilityReport -Action Download -ReportId <ReportGUID>
```

### What RCD does and does not do

| | Effect |
|---|---|
| Permissions | Unchanged. Users who had access keep it and can still open content directly. |
| Organization-wide search | Site content is removed from SharePoint home, Office.com and Bing results. |
| Copilot discovery | Site content is not used for grounding, unless the user recently interacted with it. |
| SharePoint AI entry points | Hidden on the site: the Copilot button, AI actions menus, agent creation, **Create pages with AI**. |
| Search index | Content stays indexed. Purview eDiscovery and auto-labeling keep working. |
| Site-scoped search | Unaffected. |
| Propagation | Slow on large sites. Over 500,000 items can take more than a week to fully reflect. |

## Recommended sequence

1. Identify candidate sites with the SharePoint Admin Agent, the content management assessment, or Data Access Governance reports.
2. Apply RCD to the high-risk sites while owners review permissions.
3. Fix the permissions with SharePoint Advanced Management, and apply Purview labels and DLP.
4. Remove RCD once each site is validated, and tell agent owners that responses will change.

Use RCD selectively. Over-applying it shrinks the grounding corpus and degrades the quality of every Copilot answer in the tenant, which is the exact failure mode that made Restricted SharePoint Search unsustainable.
