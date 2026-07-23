# Manage Microsoft 365 Copilot administration

Administering Microsoft 365 Copilot looks like a feature job and is not one. There is no meaningful "Copilot switch" that decides what a user can see; what a user can see is decided by Microsoft Entra ID conditional access, by per-item permissions in SharePoint, OneDrive, Exchange and Teams, and by Microsoft Purview classification, data loss prevention and auditing. The handful of genuinely Copilot-specific controls (web search, pinning, agent availability, metering) sit on top of that stack and change the shape of an answer, not who is entitled to it.

That split is why this module is organized around three separate consoles rather than one. Zero Trust decides whether the session is allowed to exist at all, the Microsoft Copilot and Copilot Chat controls decide which surface a user lands on and under which data protection terms, and the Copilot Control System plus Microsoft Purview decide what the answer may contain and what evidence is left behind. Each of the three is owned by a different administrator in most organizations, and none of them can see the other two settings.

The demos are built to make that visible. Every one of them takes a single identical prompt or a single identical user and changes exactly one policy, then shows the outcome differ: a device that is not compliant, a site marked for Restricted Content Discovery, a group excluded from a billing policy, a document carrying a Highly Confidential label. What changes in each case is discoverability, entitlement or evidence, never the model, which is the point to land with the class.

## Topics

| Topic | Description |
| --- | --- |
| [Apply principles of Zero Trust to Microsoft Copilots](01-zero-trust/readme.md) | Verify explicitly with Conditional Access, remediate oversharing without touching permissions, and monitor AI usage with auditing, Data Security Posture Management for AI and collection policies. |
| [Manage Microsoft Copilot](02-copilot/readme.md) | Control Microsoft 365 Copilot Chat and its enterprise data protection boundary, govern Copilot on mobile and in Microsoft Edge, and meter agent consumption with pay-as-you-go billing policies. |
| [Manage Microsoft 365 Copilot](03-m365-copilot/readme.md) | Use the Copilot Control System for scoped policy, add Microsoft Purview data loss prevention guardrails, and measure adoption and supervise interactions with usage reports and communication compliance. |

## Demos

| Demo | What it shows |
| --- | --- |
| [Block Copilot on a non-compliant device with Conditional Access](01-zero-trust/01-identity-access/demo-conditional-access-for-copilot.md) | The same test user gets a working Copilot Chat response on a compliant device and a Conditional Access block page on a non-compliant one, with both attempts side by side in the Microsoft Entra sign-in log. |
| [Make a labeled document disappear from Copilot without changing a permission](01-zero-trust/02-oversharing-remediation/demo-remediate-oversharing.md) | Restricted Content Discovery plus a data loss prevention rule on a sensitivity label removes a document from the answer while the same user can still open the file, separating discoverability from permissions. |
| [Build a collection policy and surface a specific prompt and response](01-zero-trust/03-monitor-ai-usage/demo-capture-and-find-a-prompt.md) | Content capture and the Data Security AI Content Viewer role turn an AI interaction into readable evidence, shown in activity explorer next to the matching unified audit log record. |
| [Scope Copilot Chat to one pilot group](02-copilot/01-chat-with-edp/demo-prove-enterprise-data-protection.md) | Integrated Apps blocks the Copilot app for a pilot group; a work account shows Copilot Chat with the enterprise data protection shield, a personal Microsoft account in the same browser shows consumer Copilot with none. |
| [Ship an Intune app configuration policy for Microsoft Edge mobile](02-copilot/02-mobile-and-edge-controls/demo-govern-copilot-on-mobile-and-edge.md) | A managed-app configuration policy greys out the Copilot page context toggle on an enrolled device, while the retired BingChatEnterprise key is deployed alongside and shown to do nothing. |
| [Meter a Copilot Chat agent](02-copilot/03-agents-and-metering/demo-meter-and-govern-chat-agents.md) | A scoped pay-as-you-go billing policy turns a metered agent from unavailable to usable for one group, and consumption appears in the Microsoft 365 Copilot Credits report while the agent stays blocked outside the scope. |
| [Turn off Copilot web search for one group and watch the user toggle go dark](03-m365-copilot/01-copilot-control-system/demo-turn-off-web-search-for-a-pilot-group.md) | A scoped Cloud Policy in the Microsoft 365 Apps admin center dims the user's own Web content toggle, and a Microsoft Teams meeting policy enforces Copilot with a saved transcript required. |
| [Build a DLP policy that makes Copilot refuse to summarize a Highly Confidential document](03-m365-copilot/02-dspm-and-dlp-guardrails/demo-dlp-blocks-copilot-processing.md) | A policy on the Microsoft 365 Copilot and Copilot Chat location, run in simulation and then enforced, blocks processing while the file still appears as a citation, with the match found in activity explorer. |
| [Catch a risky Copilot prompt with a communication compliance policy](03-m365-copilot/03-measure-and-supervise/demo-supervise-copilot-interactions.md) | The Detect Microsoft Copilot interactions template produces a pending match on a seeded prompt, which is read, tagged, escalated and resolved, then contrasted with the adoption reports. |

## Labs

[Copilot Simulation](https://app.highlights.guide/start/972f02d3-0e9e-4fe7-8943-b63def2b7ef1?token=bc8c76f4-3ce6-495a-bf30-a3dea84b3013)

[Microsoft Purview Communication Compliance interactive tour](https://mslearn.cloudguides.com/guides/Get%20started%20with%20Microsoft%20Purview%20Communication%20Compliance)

## Sources

[Microsoft Purview service / licensing description](https://learn.microsoft.com/en-us/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-purview-service-description)

[Apply principles of Zero Trust to Microsoft 365 Copilot](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-365-copilot)

[Copilot Control System overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-control-system/overview)

[Manage Microsoft 365 Copilot scenarios in the Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-page)

[Manage Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/copilot/manage)

[Enterprise data protection in Microsoft 365 Copilot and Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/microsoft-365/copilot/enterprise-data-protection)

[Use Microsoft Purview to manage data security and compliance for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/purview/ai-m365-copilot)

[Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/en-us/sharepoint/restricted-content-discovery)

[Microsoft 365 Copilot pay-as-you-go overview for IT admins](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/overview)
