# Apply principles of Zero Trust to Microsoft Copilots

Zero Trust for Microsoft 365 Copilot is not a Copilot feature set. It is the ordinary Microsoft Entra ID, Microsoft Purview and SharePoint control plane, applied to a consumer of tenant data that asks questions faster than any human ever did. Almost nothing in this module has the word "Copilot" in the product blade you configure, which is exactly the lesson: you verify the identity explicitly, you assume breach on the content Copilot can reach, and you grant the least privilege that still answers the business question.

The tension an administrator has to resolve is that every control here trades answer quality for exposure. Conditional Access that demands a compliant device keeps Copilot off an unmanaged laptop and also keeps a legitimate user from working on it. Restricted Content Discovery removes a site from Copilot grounding and thereby removes its knowledge from every answer. Turning on prompt content capture buys regulatory evidence and simultaneously makes employees' scratch text retained, discoverable and subject to legal hold.

The second tension is who gets to hold which key. Microsoft has deliberately split configuring AI monitoring from reading what people typed, so the role that builds the collection policy cannot see the prompt, and the roles guidance now pushes hard away from Global Administrator toward narrow roles such as Microsoft Entra AI Administrator. Managing this surface means placing each control on the right axis (identity, discoverability, per-item protection, observability) and being able to say out loud what each one costs.

## Topics

- [Stop Copilot at the front door with Conditional Access](01-identity-access/readme.md)
- [Find what Copilot can see, then take it away](02-oversharing-remediation/readme.md)
- [Read every prompt your tenant sent this week](03-monitor-ai-usage/readme.md)

## The Zero Trust guidance, and which article is which

The page most people link is the series hub, [Use Zero Trust security to prepare for AI companions](https://learn.microsoft.com/en-us/security/zero-trust/copilots/apply-zero-trust-copilots-overview). It contains no steps of its own. The seven-step article is [Apply principles of Zero Trust to Microsoft 365 Copilot](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-365-copilot): data protection, identity and access, App Protection, device management, threat protection, secure Teams collaboration, and user permissions to data. The equivalent for Copilot Chat is [Apply principles of Zero Trust to Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-copilot).

## DSPM and DSPM for AI (classic)

The posture surface moved. Microsoft Learn now labels both the Data Security Posture Management for AI articles and the considerations article with "- (classic)" and states that improvements will not be added to them. The current product is the unified [Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-learn-about), reached in the Microsoft Purview portal at **Solutions** > [**DSPM**](https://purview.microsoft.com); the previous entries now read **Data Security Posture Management (classic)** and **DSPM for AI (classic)**.

Its key pages are **Posture**, **Objectives**, and **AI observability**, the last being an inventory of AI apps and agents with 30 days of activity, including Microsoft Agent 365. Where a task lived in the classic experience and where it lives now is mapped at [DSPM task mapping](https://learn.microsoft.com/en-us/purview/dspm-task-mapping).

## Collection policies for AI interactions

Microsoft 365 Copilot and Microsoft 365 Copilot Chat interactions need no collection policy at all. They are captured because Microsoft Purview auditing is turned on, which is the default. The frequently repeated claim that the policy **DSPM for AI - Capture interactions for Copilot experiences** covers Microsoft 365 Copilot is wrong: that policy captures Copilot in Microsoft Fabric and Microsoft Security Copilot.

There are four DSPM for AI collection policies:

- **DSPM for AI - Capture interactions for Copilot experiences** (Copilot in Fabric and Security Copilot)
- **DSPM for AI - Detect sensitive info shared with AI via network**
- **DSPM for AI - Capture interactions for enterprise AI apps**
- **DSPM for AI - Detect sensitive info shared in AI prompts in Edge**

Two caveats belong next to the network policy. It does nothing until a Secure Access Service Edge (SASE) or Security Service Edge (SSE) integration is added under **Data Loss Prevention** > [**Security Store**](https://purview.microsoft.com/datalossprevention), because the visibility comes from the partner. It is also created with content capture off, so it records detected sensitive information but no prompt or response text until you edit the policy and select the content-capture option.

## Data Loss Prevention for Copilot

Data Loss Prevention for Copilot is its own policy location, **Microsoft 365 Copilot and Copilot Chat**, documented at [Learn about using Microsoft Purview Data Loss Prevention to protect interactions with Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about). A rule matching a sensitivity label with the **Prevent Copilot from processing content** action stops the item's content being used in a response, while the item can still appear in that response's citations.

## Restricted Content Discovery replaces Restricted SharePoint Search

[Restricted SharePoint Search is retiring](https://learn.microsoft.com/en-us/sharepoint/restricted-sharepoint-search): new enablement is blocked starting July 31, 2026, and Microsoft directs customers to [Restricted Content Discovery](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery) instead. The [restricted search demo in module 01](../../01-prepare/01-implement/04-restricted-search/readme.md) therefore covers a retiring control and should be presented as history, with this module teaching the replacement.

Restricted Content Discovery is a per-site setting in the SharePoint admin center at **Sites** > **Active sites** > the site > **Settings** tab > **Restrict content discovery**, set to **On**. The control carries a **PRO** badge, and the portal label differs from the "Restrict content from Microsoft 365 Copilot" wording used on Microsoft Learn. In PowerShell:

```powershell
Set-SPOSite -Identity <site-url> -RestrictContentOrgWideSearch $true
Set-SPOTenant -DelegateRestrictedContentDiscoverabilityManagement $true
```

The second command delegates the setting to site administrators for their own sites, who must then supply a justification that lands in the Microsoft Purview audit log.

## Roles and permissions

Microsoft's own guidance leads here: use roles with the fewest permissions, and minimizing the number of users holding Global Administrator improves security. The ranking below is the working one for this module.

### Microsoft Entra ID roles

- Global Administrator (works, but is the wrong answer in a design discussion)
- Compliance Administrator (preferred over Global Administrator)
- [AI Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#ai-administrator), which grants view-only access to AI-related data in DSPM and is the correct role for a Copilot administrator who should not hold compliance write rights

With administrative units in play, a restricted administrator cannot create the one-click policies at all; an unrestricted administrator is required.

### Data Security Posture Management

Per [Permissions for Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-permissions) (the classic equivalent is [Permissions for DSPM for AI](https://learn.microsoft.com/en-us/purview/ai-microsoft-purview-permissions)):

- Create, view and edit: Microsoft Entra Compliance Administrator role, Microsoft Entra Global Administrator role, or the Microsoft Purview Compliance Administrator role group
- View only: Microsoft Purview Security Reader role group, Microsoft Purview Data Security AI Viewer role, Data Security Viewers role group or Data Security Viewer role, and the Microsoft Entra AI Administrator role
- Data Security Management is a role group (DSPM insights plus Security Copilot plus Data Loss Prevention, Information Protection and Insider Risk management), not a role name

None of the roles above can read prompt and response text in activity explorer. That requires the **Content Explorer Content Viewer** role group or the **Microsoft Purview Data Security AI Content Viewer** role, and it is the permission a live demo fails on.

### Data Loss Prevention

Compliance Administrator still works but is no longer the least-privilege guidance. Per [Microsoft Purview role groups](https://learn.microsoft.com/en-us/defender-office-365/scc-permissions):

- Information Protection Admins: create, edit and delete DLP policies, sensitivity labels and classifiers, manage endpoint DLP settings and auto-labeling simulation
- Information Protection Analysts: DLP alerts and activity explorer, view-only on policies
- Information Protection Investigators: as Analysts, plus content explorer

### Information Protection

- Information Protection role group
- Information Protection Admins role group
- Compliance Administrator

## Sources

[Use Zero Trust security to prepare for AI companions](https://learn.microsoft.com/en-us/security/zero-trust/copilots/apply-zero-trust-copilots-overview)

[Apply principles of Zero Trust to Microsoft 365 Copilot](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-365-copilot)

[Apply principles of Zero Trust to Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-copilot)

[Learn about Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-learn-about)

[DSPM task mapping](https://learn.microsoft.com/en-us/purview/dspm-task-mapping)

[Microsoft Purview data security and compliance protections for generative AI apps](https://learn.microsoft.com/en-us/purview/ai-microsoft-purview)

[Considerations for DSPM for AI to manage data security and compliance protections for AI interactions - (classic)](https://learn.microsoft.com/en-us/purview/dspm-for-ai-considerations)

[Permissions for Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-permissions)

[Learn about using Microsoft Purview Data Loss Prevention to protect interactions with Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about)

[Microsoft Purview role groups](https://learn.microsoft.com/en-us/defender-office-365/scc-permissions)

[Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)

[Restricted SharePoint Search](https://learn.microsoft.com/en-us/sharepoint/restricted-sharepoint-search)

[Learn about Microsoft Purview Data Lifecycle Management](https://learn.microsoft.com/en-us/purview/data-lifecycle-management)
