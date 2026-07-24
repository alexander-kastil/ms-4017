# Microsoft 365 Copilot Chat and enterprise data protection

[Manage Microsoft 365 Copilot Chat](https://learn.microsoft.com/copilot/manage)

[Enterprise data protection in Microsoft 365 Copilot and Microsoft 365 Copilot Chat](https://learn.microsoft.com/microsoft-365/copilot/enterprise-data-protection)

[Privacy and protections in Copilot Chat](https://learn.microsoft.com/copilot/privacy-and-protections)

[Considerations for Microsoft 365 Copilot Chat admins](https://learn.microsoft.com/microsoft-365/copilot/microsoft-365-copilot-chat-considerations)

Hands-On Demo: [Scope Copilot Chat to one pilot group](demo-prove-enterprise-data-protection.md)

## Two products, one word

Since January 2025 the work and education experience and the consumer experience no longer share a name. **Microsoft 365 Copilot Chat** is the work and education chat: it is web-grounded, it requires a Microsoft Entra account, and its entry points are the Microsoft 365 Copilot app (web, desktop, mobile), copilot.cloud.microsoft, Copilot Chat in Edge, and Copilot Chat in Outlook and Teams. **Microsoft Copilot** now means the consumer product only: a personal Microsoft account signing in at copilot.microsoft.com, bing.com/chat, copilot.com or copilot.ai.

The rename matters because the difference is not branding, it is which contract covers the prompt. The same person, on the same laptop, in the same browser window, gets a different legal and technical treatment depending on which account authenticated. That makes "which Copilot am I in?" an access-control question, and the honest answer for an administrator is that they can only govern one of the two.

## Who already has it, and what the shield asserts

Copilot Chat is included at no extra cost for Microsoft Entra ID users holding Microsoft 365 A1/A3/A5, Business Basic, Business Standard or Business Premium, E3 or E5, F1 or F3, G3 or G5; Microsoft Teams (including Teams Enterprise, Teams Essentials and Teams Rooms); and Office 365 A1, A1 Plus, A3, A5, E1, E1 Plus, E3, E5, F3, G1, G3 and G5. The "(no Teams)" and "EEA (no Teams)" versions of those SKUs are included too. In practice this means most tenants already have an AI surface live whether or not anyone signed off on it, which is why "we have not bought Copilot yet" is rarely a true statement about exposure.

What those users get is enterprise data protection (EDP), and Copilot Chat advertises it with a green shield along the top of the interface next to the New Chat button. EDP is not a feature toggle: it is the set of controls and commitments under the Microsoft Products and Services Data Protection Addendum (DPA) and the Product Terms that apply to customer data, with Microsoft acting as data processor. Concretely it asserts encryption at rest and in transit, tenant isolation, that your access controls and policies apply, protection against harmful content and prompt injection, and that prompts, responses and Microsoft Graph data are not used to train foundation models. EDP replaced the older commercial data protection (CDP) promise and is the stronger of the two.

Be precise about what EDP is not. There is no behavioural profile being built of the user, and no model is learning from their habits over time; relevance comes from grounding data retrieved per request against the permissions that user already holds. Copilot Chat itself grounds only in public web data from the Bing search index, so organizational content enters a chat only when the user uploads a file, uses Copilot Chat in Outlook, or invokes an agent that has been given access.

## What you can still control

Four levers matter. The first is the **Copilot** app in **Settings** > [**Integrated apps**](https://admin.microsoft.com/#/Settings/IntegratedApps) in the Microsoft 365 admin center: it delivers Copilot Chat in the Microsoft 365 Copilot app, Outlook and on the web, and it is the only control that actually removes access across web, desktop and mobile.

Read the availability options as an allow list rather than a block list: *All users in the organization can install* is the default, and *Specific users/group in the organization can install* grants the app to the named users or groups and takes it away from everyone else. The control is blunt in two ways: it also blocks Copilot in Teams and it hits licensed Microsoft 365 Copilot users unless you scope the group carefully. It is unaffected by the *Let users access Microsoft apps in your tenant* setting, and changes take up to 24 hours to reach clients.

The second is the courtesy that makes the block survivable. Microsoft Learn documents **Copilot** > **Settings** > **View all** > **Custom link for blocked Microsoft 365 Copilot app**, where you enter a URL to your own AI policy page; blocked users then see a **View info from your organization** link on the *Copilot Chat was turned off for your organization* page instead of a dead end. Check before you promise it in a design session: the entry was not present in **Copilot settings** > **View all** in a tenant checked in July 2026 where the Copilot app was not blocked, so it appears to be conditional on the block being in place. The third is the **Allow web search in Copilot** policy, configurable in the [Cloud Policy service for Microsoft 365](https://config.office.com/officeSettings) and mirrored in the settings section of the Copilot Control System page in the Microsoft 365 admin center. Leave it unconfigured and web search is on by default, unless *Allow the use of additional optional connected experiences in Office* is disabled, which is a much wider hammer.

The fourth is identity, not Copilot at all. To stop the personal-account half of the story you use tenant restrictions v2 in the [Microsoft Entra admin center](https://entra.microsoft.com) under **Entra ID** > **External Identities** > **Cross-tenant access settings**, blocking Microsoft account sign-in on managed devices. The least-privileged role for the Copilot surface itself is the Microsoft Entra **AI Administrator** role; Global Administrator is not required and should not be the default answer.

## What you have lost, and the trade-off

Two former assumptions are now dead. The **Pin Microsoft 365 Copilot Chat in Microsoft 365 apps** setting stopped governing the Microsoft 365 Copilot app for European Economic Area and Switzerland tenants on July 25, 2025, and for all remaining tenants worldwide on January 28, 2026: Chat is permanently visible in that app's navigation, and unpinning is no longer a removal strategy. Separately, Copilot in Windows was removed and the consumer Microsoft Copilot app no longer accepts Microsoft Entra accounts at all, so managed organizations should remap the Copilot key to launch the Microsoft 365 Copilot app.

The operational trade-off is therefore uncomfortable and worth stating to a customer plainly. If you block the Copilot app, the navigation entry still appears and every click produces a policy message, which generates helpdesk traffic and looks like a bug to users. If you do not block it, an AI surface is live for nearly every licensed user in the tenant. There is no quiet middle setting, which is exactly why the company policy URL is not decoration: it is the only place you get to explain the decision.

Do not try to solve this at the network layer. Microsoft explicitly does not support managing Copilot Chat through domain, URL or IP blocking, because the service is woven into the applications themselves and selective blocking produces failures in unrelated features.

## Discussion questions

- Your customer wants Copilot Chat off for 8,000 unlicensed users but on for a 200-person licensed pilot. Blocking the Copilot app in Integrated apps is tenant-wide unless scoped by group. Which group do you build, and what do you tell the 8,000 when Chat stays visible in their navigation?
- Legal asks you to guarantee that no employee prompt ever leaves the enterprise data protection commitment. You can block the Copilot app and configure tenant restrictions v2, but the personal Microsoft Copilot is reachable from any unmanaged phone. Is that guarantee achievable, and what do you sign up to instead?
- Web search is on by default and gives users current information; turning it off keeps generated search queries away from the Bing search service but leaves Copilot Chat relying on the model alone. For a regulated customer, which default do you recommend, and who owns that decision, the AI Administrator or the compliance officer?
