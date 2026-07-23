# Read every prompt your tenant sent this week

[Collection policies solution overview](https://learn.microsoft.com/en-us/purview/collection-policies-solution-overview)

[Create and deploy collection policies](https://learn.microsoft.com/en-us/purview/collection-policies-create-deploy-policy)

[Permissions for Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-permissions)

[Audit logs for Copilot and AI applications](https://learn.microsoft.com/en-us/purview/audit-copilot)

Hands-On Demo: [Build a collection policy and surface a specific prompt and response](demo-capture-and-find-a-prompt.md)

## Two different roads to the same activity explorer row

Module 01 mapped compliance questions to Microsoft Purview solutions on paper. Here you operate the console, and the first thing the console teaches is that not all AI interactions arrive by the same route. For Microsoft 365 Copilot and Microsoft 365 Copilot Chat, the **AI interaction** event in activity explorer requires only that Microsoft Purview auditing is turned on, which is the default. No collection policy, no onboarding, no extra configuration.

Everything else is different. Copilot in Microsoft Fabric and Microsoft Security Copilot need a collection policy before their prompts and responses show up, and Fabric additionally needs the enterprise version of Microsoft Purview data governance to supply the required APIs. Enterprise AI apps (ChatGPT Enterprise, apps connected through Microsoft Entra ID or Microsoft Foundry) need their own collection policy. Prompts typed into generative AI sites in Microsoft Edge need a third one, plus an Edge configuration policy to activate the Purview integration in the browser.

This is why the common instructor claim "the policy named DSPM for AI - Capture interactions for Copilot experiences captures Microsoft 365 Copilot" is wrong, and worth correcting out loud. That policy captures Copilot in Fabric and Security Copilot. Microsoft 365 Copilot was already covered by auditing before the policy existed.

## What a collection policy actually is

A collection policy is an ingestion filter, not a protection control. It decides which events cross into Microsoft Purview so that activity explorer, Insider Risk Management, eDiscovery and Data Lifecycle Management can consume them. An event is a condition (**Content contains** classifiers, sensitivity labels, document size, file extension) combined with an activity (for example **Text sent to or shared with cloud or AI app**), matched against a data source.

Collection policies do not follow the priority ordering that DLP policies use. During evaluation, Microsoft Purview merges every collection policy targeting the same data source into one effective policy, so all conditions for that source apply together. That merge behavior is what makes a second, narrower policy for the same source behave as an addition rather than an override, and it is the detail most admins get wrong when they try to "tighten" collection by adding a policy.

You reach them in the Microsoft Purview portal at **Solutions** > [**Data Loss Prevention**](https://purview.microsoft.com/datalossprevention) > **Classifiers** > **Collection policies**, or at **Solutions** > **Information Protection** > **Classifiers** > **Collection policies**. Same policies, two doors.

## The content capture switch that decides whether you see any text

The single most expensive misunderstanding in this topic is that creating a collection policy makes prompts readable. It does not. On the policy wizard page after activities and data sources, the default is **Don't capture content**. With that default, only sensitive information detected inside prompts and responses is recorded, never the literal text.

The one-click policies created from a recommendation inherit that default. **DSPM for AI - Detect sensitive info shared with AI via network** is created with content capture off, and Microsoft documents explicitly that you must edit the policy afterwards and select the content-capture option if you want prompts and responses. That policy also does nothing at all until a Secure Access Service Edge (SASE) or Security Service Edge (SSE) integration is added under **Data Loss Prevention** > [**Security Store**](https://purview.microsoft.com/datalossprevention/securitystore), because the network visibility comes from the partner, not from Microsoft.

Two more constraints matter before the demo. Capturing AI content requires the **Content contains classifiers** condition to be set to **All**, and capture never includes the contents of files shared with a generative AI app, only prompts and responses. Turning capture on is a deliberate trade: you gain regulatory evidence and eDiscovery reach over prompt text, and you accept that prompt text (which users treat as scratch space) is now retained, discoverable and subject to the same holds as mail.

## The permission wall every admin hits

Assume the policy is right and the data is flowing. The demo account, holding Compliance Administrator, opens activity explorer, filters to **AI interaction**, and sees the event: who, when, which app, whether sensitive information types were detected. And no prompt text.

That is not a bug. Per [Permissions for Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-permissions), viewing the prompts and responses within **AI Interaction** events in activity explorer is unsupported for the Microsoft Entra Compliance Administrator role, the Microsoft Entra Global Administrator role, the Microsoft Purview Compliance Administrator role group, and every view-only role. It requires the **Content Explorer Content Viewer** role group or the **Microsoft Purview Data Security AI Content Viewer** role. Content reading is a separate grant from posture administration, on purpose: the person who configures monitoring is not automatically the person allowed to read what employees typed.

Use the rest of the ladder deliberately. Create, view and edit in DSPM needs Microsoft Entra Compliance Administrator, Microsoft Entra Global Administrator, or the Microsoft Purview Compliance Administrator role group, and Microsoft states plainly that you should minimize Global Administrator assignments. View-only is Microsoft Purview Security Reader, Purview Data Security AI Viewer, Data Security Viewers / Data Security Viewer, and the Microsoft Entra [AI Administrator](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#ai-administrator) role, which is the correct role for a Copilot admin who should see AI posture without holding compliance write rights. One more trap: with administrative units, a restricted administrator cannot create the one-click tenant-wide policies at all.

## DSPM, and DSPM for AI (classic)

Teach the console students will actually be given in 2026. The current product is the unified [Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-learn-about), reached at **Solutions** > **DSPM** in the Microsoft Purview portal. Its key pages are **Posture** (metrics, snapshot, 30-day trend), **Objectives** (goal-shaped workflows such as "Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions", each with a remediation plan and one-click policies), **AI observability** (inventory of AI apps and agents with activity in the last 30 days, including Microsoft Agent 365), **Discover** > **Activity explorer** with its **AI activities** tab, **Tasks and actions**, and **Reports**.

The entries labelled **Data Security Posture Management (classic)** and **DSPM for AI (classic)** are the previous generation. Microsoft Learn marks both article sets "- (classic)" and states that improvements will not be added to them. They still work, and most of the default AI policies originate there, which is why the current DSPM surfaces them under **Tasks and actions** > **Remediation actions**. Do not build a course narrative on the classic navigation; use [Find familiar tasks that you did in DSPM for AI or in DSPM](https://learn.microsoft.com/en-us/purview/dspm-task-mapping) to translate older runbooks.

## Two independent homes for the evidence

Evidence has two independent homes, and a mature answer to an auditor uses both. Activity explorer gives the security-shaped view with sensitive information types and DLP rule matches. The unified audit log gives the record-shaped view: `CopilotInteraction` operations carrying `AppIdentity` (for example `Copilot.MicrosoftCopilot.BizChat`, `Copilot.Security.SecurityCopilot`), `AppHost`, `AgentId`, `AccessedResources` with the sensitivity label of each grounding item, and `AISystemPlugin.Id` set to `BingWebSearch` when the answer used the public web. Audit records for non-Microsoft AI apps (`AIAppInteraction`, and some `ConnectedAiAppInteraction` scenarios) are pay-as-you-go billed and retained 180 days, while Microsoft Copilots stay inside Audit (Standard).

## Discussion questions

- Your legal team asks for the literal text of every prompt sent to Security Copilot last quarter. Content capture was never enabled. What can you produce, what is permanently unavailable, and what do you change today?
- Compliance wants prompt text readable by the SOC on demand, and the works council objects to retaining what employees type. Where do you put the boundary: content capture off, or capture on with **Data Security AI Content Viewer** granted to nobody until an approved investigation?
- A Copilot administrator asks for access to DSPM so they can report on adoption risk. Do you assign the Entra AI Administrator role, the Purview Security Reader role group, or the Compliance Administrator role group, and what does your choice say about who is accountable for the policies themselves?
