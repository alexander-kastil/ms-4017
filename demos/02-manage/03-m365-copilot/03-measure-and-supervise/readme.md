# Is anyone using Copilot, and is anyone misusing it

[Microsoft 365 Copilot reporting options for admins](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-reports-for-admins)

[Microsoft 365 Copilot usage report](https://learn.microsoft.com/en-us/microsoft-365/admin/activity-reports/microsoft-365-copilot-usage)

[Copilot Analytics introduction](https://learn.microsoft.com/en-us/viva/insights/copilot-analytics-introduction)

[Configure a Communication Compliance policy to detect generative AI interactions](https://learn.microsoft.com/en-us/purview/communication-compliance-copilot)

Hands-On Demo: [Catch a risky Copilot prompt with a communication compliance policy and remediate it](demo-supervise-copilot-interactions.md)

## Two questions, two different consoles

A renewal conversation contains exactly two questions, and they are not the same question. "Is anyone using this?" is an adoption question, answered by usage reporting. "Is anyone doing something with this that will end up in a regulator's letter?" is a supervision question, answered by Microsoft Purview. Students who blur the two end up trying to build an adoption chart out of the audit log, which Microsoft explicitly tells you not to do.

That warning is worth quoting to the class. Learn states that audit log data is built for data security and compliance purposes, that it is not intended as the basis for Copilot usage reporting, and that Microsoft can neither guide you on nor guarantee metrics you aggregate from it. Adoption numbers come from the Microsoft 365 admin center usage reports or the Copilot Dashboard, full stop.

## The admin center reports, and the latency that ruins live demos

The adoption surface is **Reports** > [**Usage**](https://admin.cloud.microsoft/#/reportsUsage) > **Microsoft 365 Copilot** > **Copilot** in the Microsoft 365 admin center, viewable with the **AI Administrator** role rather than Global Administrator. That page opens on the **Readiness** tab (license eligibility, eligible update channel, technical blockers, suggested candidates) and carries the **Usage** tab beside it (Enabled Users, Active Users, Active users rate, prompts submitted, adoption by app). Alongside the **Copilot** node sit the Copilot Chat usage report, the Agent usage report, and the Copilot Search usage report in public preview. Readiness and Usage are the two a sponsor actually reads.

Latency is the operational trade-off and the thing to warn a class about before a live demo, not after it fails. Copilot activity for a given day surfaces in the Usage report within 48 hours of the end of that day in UTC, and Learn's own overview quotes up to 72 hours for the Readiness and Agent reports. Seeding a prompt at 09:00 and expecting the chart to move at 09:05 is the single most common instructor mistake in this module. The exceptions are the newer preview reports: Agent usage and Copilot Search usage both reflect activity within about an hour, which is why they are the ones to demo live.

One more detail that surprises people: user-level information (usernames, display names, groups, sites) is anonymized by default in usage reports, and revealing it is a deliberate tenant setting. That default is a privacy control, not a bug, and it is worth naming before someone opens a ticket about it.

## Copilot Analytics: the Copilot Dashboard and its siblings

Copilot Analytics is the umbrella name, and the Copilot Dashboard is only one of six areas under it. Learn names the six as the readiness and adoption report in the Microsoft 365 admin center, the Microsoft Copilot Dashboard, the **Agent Dashboard** (adoption and usage of agents, public preview, needs at least 50 assigned Microsoft 365 Copilot licenses plus agent activity), the **Consumption Dashboard** (how Copilot Credits and GitHub AI Credits are burned across agents, services, and users), the out-of-the-box Copilot Analytics reports, and Advanced Reporting through the Analyst Workbench and its Power BI templates. The middle four all live in the Viva Insights web app, which is why a single web app control decides whether any of them render.

Access has been simplified in a way that catches people out. The old Copilot Dashboard specific feature access control and its PowerShell equivalent are gone: there is now a single **Viva Insights web app** control, and turning it off disables the entire app, dashboard included. The **AI Administrator** enables it and delegates access; senior leaders identified from Microsoft Entra ID data and enabled managers get access automatically, and anyone with access can delegate onward. Note the trap: the AI Administrator does not get web app access automatically and has to add themselves.

Two privacy mechanics decide whether the dashboard shows anything useful. Group-level metrics only render for groups that meet the minimum group size, which defaults to 10 employees and cannot be set below 5. And a tenant with Microsoft 365 Copilot licenses but no Viva Insights licenses can still enrich the dashboard by having a Microsoft 365 Global Administrator upload organizational data through the admin center, supplying `Microsoft_PersonEmail`, `Microsoft_ManagerEmail` and `Microsoft_Organization` as required attributes plus the optional `Microsoft_JobDiscipline` that unlocks the Job function filter. Without that upload the dashboard falls back to Microsoft Entra ID data alone, and the org-level slicing your sponsor wanted simply is not there.

## Supervision: communication compliance over generative AI

The misuse question is answered in the [Microsoft Purview portal](https://purview.microsoft.com) at **Communication Compliance** > **Policies** > **Create policy** > **Detect Microsoft Copilot interactions**. The template pre-selects a working set of settings; you can accept it or choose **Customize policy** to add conditions before creating. The three generative AI locations you can select are **Microsoft Copilot experiences**, **Enterprise AI apps**, and **Other AI apps**, and a policy can carry any combination of them.

The billing line runs straight through those three locations, and it is the detail that decides a customer's answer. Detecting Microsoft 365 Copilot data carries no pay-as-you-go requirement and no charge. Detecting anything else, meaning Copilot in Microsoft Fabric, Microsoft Security Copilot, Microsoft Copilot Studio agents, Microsoft Entra or Microsoft Purview Data Map connected AI applications, and browser or network observed cloud AI apps, requires pay-as-you-go billing to be enabled on the tenant. Say that out loud before a customer scopes a policy across all three locations and then queries the invoice.

Learn's own starting recommendation is to review all generative AI interactions at 100 percent with no conditions, so the organization can first see how these apps are actually used. The warning attached to that advice matters as much as the advice itself: depending on tenant size, a policy that detects everything can generate enough matches to reach the organization's storage limit, and the documented remedy is to narrow the policy so it detects less. Treat 100 percent as a time-boxed baseline, not a steady state.

Under the hood, Copilot detection works on message item classes of the form `IPM.SkypeTeams.Message.Copilot.*`, for example `IPM.SkypeTeams.Message.Copilot.Teams` and `IPM.SkypeTeams.Message.Copilot.Outlook`. On the **Policies** > **Pending** tab a match shows the Copilot icon and the value *[Copilot]* in the Subject column for Microsoft Copilots, or an email icon and *[AI app]* for everything else. Prompts and responses are separate entries: the Sender is *Copilot* when the match is a response and the user when it is a prompt, and the full text that triggered the match is rendered on the right of the screen. Everything you can do to a normal match (tag, escalate, resolve, download, export) applies unchanged.

## Which surface answers which question

Sequencing this in a delivery is easy once the split is explicit. Readiness answers "who could use it", Usage answers "who does", the Copilot Dashboard answers "does it change anything", the Consumption Dashboard answers "what is it costing", communication compliance answers "is anyone saying something we have to act on", and the audit log answers "prove exactly what happened in this one incident".

What breaks without the supervision half is not visibility, it is timeliness. Audit records exist either way, but nobody is reading them; a communication compliance policy is what turns a stored interaction into a queued item with a named reviewer and an escalation path. What breaks without the adoption half is the budget: a program that cannot show an active users rate loses its licenses at renewal regardless of how clean its compliance posture is.

The reviewer side needs roles too. To investigate Copilot interactions a person must hold *Communication Compliance*, *Communication Compliance Investigators*, or *Communication Compliance Analysts*, and must additionally be named in the **Reviewers** field of the policy itself. Role assignment alone is not enough, which is the most common reason a demo ends with an empty Pending tab.

## Discussion questions

- Your sponsor wants a weekly Copilot adoption number and you only have Purview audit access. Do you build it from the audit log anyway, request the AI Administrator role, or tell them the number cannot be produced weekly? Defend the choice.
- The customer wants one communication compliance policy covering Microsoft 365 Copilot, Microsoft Copilot Studio agents, and staff use of a consumer AI site. What do you tell them about pay-as-you-go billing, and would you still recommend a single policy over three?
- Legal wants every Copilot interaction reviewed at 100 percent with no conditions, as Learn suggests for an initial baseline. Given the storage limit warning, how long do you run that policy before you narrow it, and what would you measure to decide?
