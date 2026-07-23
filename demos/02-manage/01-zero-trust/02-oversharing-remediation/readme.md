# Find what Copilot can see, then take it away

[Configure a secure and governed foundation for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/configure-secure-governed-data-foundation-microsoft-365-copilot)

[Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)

[Learn about using Microsoft Purview Data Loss Prevention to protect interactions with Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about)

[Prevent oversharing with data risk assessments from Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-oversharing)

Hands-On Demo: [Make a labeled document disappear from Copilot without changing a permission](demo-remediate-oversharing.md)

## The loop, in the order Microsoft now sequences it

Module 01 taught why oversharing surfaces through Microsoft 365 Copilot: the retrieval step honours existing permissions, so a permission nobody remembers granting becomes an answer somebody reads. This subtopic is the remediation shift, and the sequence matters more than any single control. Microsoft's foundational deployment guidance splits it into three phases that must run in order: identify high-risk sites and content, apply interim Copilot protections, then fix access and permissions.

The reason for that order is operational, not academic. Permission remediation on a large tenant takes weeks of site-owner conversations, and Copilot is answering questions the whole time. The interim controls buy that time by cutting exposure on day one without waiting for a single access decision, and the guidance is explicit that you remove them once access and permissions are remediated. An organization that skips straight to fixing permissions is running an uncontrolled Copilot for the duration of the project.

## Phase 1: finding the sites, from two consoles

The Microsoft Purview side is data risk assessments, reached from the Microsoft Purview portal at **DSPM** > [**Discover**](https://purview.microsoft.com) > **Data risk assessments**. A default assessment runs weekly against the top 100 SharePoint sites by usage, with a four-day delay the first time it is created. Choosing **View details** on that assessment lists the sites, and selecting one opens a flyout with **Overview**, **Identify**, **Protect**, and **Monitor** tabs; **Monitor** is the one that counts items shared with anyone, shared with everyone in the organization, shared with specific people, and shared externally. Custom assessments add item-level scanning for up to 10 SharePoint sites, which requires a one-time authentication with a registered Microsoft Entra ID application.

The SharePoint side is SharePoint Advanced Management, which is included with Microsoft 365 Copilot licences. The **Content management assessment** in the SharePoint admin center under **Advanced Management** surfaces oversized audiences, Everyone Except External Users (EEEU) usage, broken permission inheritance, inappropriate sharing, and sites that are inactive or ownerless. Underneath it the **Reports** > **Data access governance** reports break the same picture into pieces: the site permissions baseline report for overall exposure, the EEEU activity report for the top 100 sites shared organization-wide in the past 28 days, and the sharing links activity reports for sites generating the most "Anyone" links. Rerun the content management assessment every 30 days so the class understands this is a recurring measurement, not a one-off audit.

A site is high risk when several of those signals overlap, not when one fires. Sensitive data plus an "Anyone" link, a public site with no owner, a large audience on top of broken inheritance: those are the combinations the guidance names. A single EEEU grant on a genuinely company-wide policy library is not a finding.

## Phase 2: the two interim controls, and why confusing them is expensive

Restricted Content Discovery (RCD) is a SharePoint site-level setting that changes discoverability and touches no permission at all. Turn it on at **Sites** > **Active sites** > the site > **Settings** > **Restrict content from Microsoft 365 Copilot**, or run `Set-SPOSite -Identity <site-url> -RestrictContentOrgWideSearch $true`. Content from that site stops appearing in organization-wide search and Microsoft 365 Copilot experiences, but users who already had access keep it, users can still find content they own or recently interacted with, and the content is never removed from the search index (so eDiscovery and auto-labeling keep working). The visible signal is a **Restricted** tag on the site in the admin center.

The trade-off is real and worth stating to a class that will over-apply it. Microsoft's own caution is that excessive use reduces the content available to search and Copilot, which degrades answer completeness. RCD also disables the AI entry points inside the site itself: no Copilot button, no AI actions menu, no **Create pages with AI**. Propagation is not instant, and for sites above 500,000 items an update can take more than a week to fully reflect.

Data Loss Prevention for the **Microsoft 365 Copilot and Copilot Chat** policy location works on a completely different axis: it is per-item and label-driven, not per-site. A rule with the **Content contains** > **Sensitivity labels** condition and the **Prevent Copilot from processing content** action stops Copilot using that item's content in a response, while the item can still appear in the citations of that response. That last clause is the sentence students misremember, so say it twice: the citation survives, the content does not. The location lives only in the **Custom** policy template, selecting it disables every other location in that policy, it does not support administrative units, and changes take up to four hours to reach the Copilot experience.

One rule-authoring constraint catches everyone: you cannot combine the **Content contains** > **Sensitive information types** and **Content contains** > **Sensitivity labels** conditions in the same rule. Use one rule per condition inside the same policy. Note also that DLP cannot scan files a user uploads directly into a prompt; only typed prompt text is evaluated.

## Delegation, roles, and who is actually allowed to do this

By default only SharePoint administrators manage RCD. Running `Set-SPOTenant -DelegateRestrictedContentDiscoverabilityManagement $true` hands the setting to site administrators for their own sites, and when they change it they must supply a justification. Enable, disable, and justification events all land in the Microsoft Purview audit log, which is what turns delegation from a risk into a control.

On the Microsoft Purview side, resist the reflex to reach for Compliance Administrator. A DLP policy for the Copilot location can be created or edited by the **Microsoft Entra AI Admin** role, the **Purview Data Security AI Admin** role, the **Purview Data Security AI Admins** role group, Purview Compliance Administrator, Purview Compliance Data Administrator, Purview Information Protection, Purview Information Protection Admin, Purview Security Administrator, or Microsoft Entra Global Admin. Microsoft states plainly that you should use the role with the fewest permissions and minimize Global Administrator assignments. The AI Admin path is the right answer for a Copilot administrator who should not hold broad compliance write rights, and note that Data Security AI Admin explicitly cannot read the prompt and response text of AI interactions.

## Restricted SharePoint Search is on its way out

Restricted SharePoint Search was the 2024 answer: a tenant switch plus an allow list of at most 100 sites, sold openly as a short-term measure that was never scalable. It is retiring. Starting **31 July 2026**, new enablement is blocked, and Microsoft directs customers to Restricted Content Discovery instead.

That has a direct consequence for this course. The demo in [01-prepare/01-implement/04-restricted-search](../../../01-prepare/01-implement/04-restricted-search/readme.md) still teaches the old control, and it should be treated as historical context, not as guidance for a 2026 deployment. The conceptual replacement is not one-for-one: Restricted SharePoint Search was an allow list (deny everything, permit 100 sites), while Restricted Content Discovery is a deny list applied per site. A customer migrating between them is inverting their model, which usually means their 100-site allow list was hiding how many sites actually needed remediation.

## Discussion questions

- A site holds genuinely sensitive HR content that 4,000 people can technically open through an EEEU grant. You can apply Restricted Content Discovery today or start a site access review that will take six weeks. Which do you do first, and what do you tell the HR director about what changed for their users?
- Your DLP policy blocks Copilot from processing Highly Confidential items, but the file names still appear as citations in responses. A security reviewer calls that a leak. Is it, and would switching to Restricted Content Discovery on that site actually close it?
- Delegating Restricted Content Discovery to site administrators scales the remediation but hands a Copilot-visibility switch to hundreds of people whose only guardrail is a justification box. At what tenant size does that trade become worth making, and what would you monitor to know it went wrong?
