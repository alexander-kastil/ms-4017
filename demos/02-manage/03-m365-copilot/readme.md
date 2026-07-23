# Manage Microsoft 365 Copilot

Managing Microsoft 365 Copilot is not one console. It is a small set of tenant switches in the Microsoft 365 admin center, a much larger set of data controls in Microsoft Purview, a handful of shortcuts into the Microsoft Teams, Microsoft Edge and Microsoft 365 Apps admin centers, and two separate reporting surfaces. The Microsoft 365 admin center groups its own part of that under the **Copilot Control System**, but the Control System is a front door, not the whole building.

The tension an administrator has to resolve is that the loudest requests point at the wrong console. A sponsor asks to "turn off web search", and the answer is a Cloud Policy in the Microsoft 365 Apps admin center. Someone asks to "hide Copilot Chat", and the answer is an Integrated Apps control, because the pin setting no longer applies. Someone asks to "stop Copilot reading the board deck", and the answer is a data loss prevention policy, not a sensitivity label on its own.

The second tension is proof. Configuring a control is cheap; showing a compliance officer that the control fired is the part that takes work, and it happens in a different portal from the one where the control was created. Each topic below therefore pairs a control with the place you go to prove it.

## Topics

- [Drive the Copilot Control System, and the two settings that are not there](01-copilot-control-system/readme.md)
- [Stop Copilot answering from your most sensitive files](02-dspm-and-dlp-guardrails/readme.md)
- [Is anyone using Copilot, and is anyone misusing it](03-measure-and-supervise/readme.md)

## The Copilot Control System in the Microsoft 365 admin center

The Copilot area of the [Microsoft 365 admin center](https://admin.cloud.microsoft/) is documented as the **Copilot Control System (CCS)**. **Copilot** lands on [**Copilot Control System**](https://admin.cloud.microsoft/#/copilot/overview) with five tabs: **Overview**, **Security**, **Usage**, **Health** and **About**. Overview carries the Copilot analytics cards (active users, adoption score, assisted hours, satisfaction rate) and a **Top actions** list split into Configuration and Adoption.

The settings themselves live one level down at [**Copilot settings**](https://admin.cloud.microsoft/#/copilot/settings), which has two tabs, not the four that older material describes:

- **Optimize**: the settings Microsoft thinks you should change, in a table of Name, Status and Impact, filtered by **Required**, **Recommended** and **Optional**.
- **View all**: every Copilot setting in one flat, searchable list with Name, Description and **Applies to** columns, plus a **Search all Copilot settings** box.

The older grouping into **User access**, **Data access**, **Copilot actions** and **Other settings** no longer exists as tabs in the portal, though Microsoft Learn still describes the page that way. Teach the search box instead of a tab path: setting names are stable, their grouping is not.

Two things about this page trip people up. The admin center only shows scenarios for services licensed in the tenant, so a screenshot from another tenant will not match. And several entries are only shortcuts: **Copilot in Teams meetings**, **Copilot in Power Platform and Dynamics 365**, **Copilot in Edge** and **Microsoft Copilot for Security** open another console, and the setting is made there.

Changes need the **AI Administrator** role; **Global Reader** can view.

## Copilot in Microsoft Edge

The scenario older material calls "Copilot in Bing, Edge, and Windows" is not in the portal under that name. **Copilot settings** > **View all** lists **Copilot in Edge**, described as AI-powered chat for work with enterprise data protection, and it is a shortcut rather than a toggle.

Copilot in Microsoft Edge is governed by Microsoft Edge configuration policies (**Settings** > **Microsoft Edge** > **Configuration policies**), using keys such as `EdgeEntraCopilotPageContext`, `HubsSidebarEnabled` and `CopilotPageContext`.

Copilot Chat pinning is the related trap. The live setting is named **Pin Microsoft 365 Copilot Chat**, and since January 28, 2026 it no longer applies to the Microsoft 365 Copilot app: Copilot Chat cannot be unpinned from that app's navigation for any tenant worldwide. Removing access requires the **Integrated Apps** control on the Copilot app.

## Settings the older course material predates

**View all** now carries a set of entries worth naming in class, because none of them existed when most Copilot administration training was written:

- **Cowork**, **People Skills in Microsoft 365 Copilot**, **Opal (Frontier)** and **Copilot Frontier**: new experiences and early-access programs, each with its own access scope.
- **Flex routing during peak load periods**: whether Microsoft 365 Copilot may process some requests outside the EU during peak load. This is a data residency decision, not a performance one, and it belongs in the same conversation as the EU Data Boundary.
- **Copilot image generation** and **Copilot video generation**: whether users may generate images and generative AI video.
- **AI providers operating as Microsoft subprocessors**, **AI providers for other large language models** and **AI models in preview**: three separate controls over which non-Microsoft models are reachable from Copilot Studio, Microsoft 365 Copilot and Microsoft 365.
- **Copilot AI disclaimer**, **Copilot Release preferences: General Availability**, **Screen and camera sharing**, **Agents** and **Copilot pay-as-you-go billing**.

The diagnostics entry is named **Copilot feedback and diagnostic logs**, and it covers sending feedback as well as logs.

## Web search

Web search is not configured in the Microsoft 365 admin center. **Copilot settings** > **View all** > **Web search for Microsoft 365 Copilot and Microsoft 365 Copilot Chat** is a shortcut to the [Microsoft 365 Apps admin center](https://config.office.com/officeSettings/officePolicies), where you create the **Allow web search in Copilot** Cloud Policy. It has three options:

- Enabled in Microsoft 365 Copilot and Copilot Chat.
- Disabled in Microsoft 365 Copilot and Copilot Chat.
- Disabled in Copilot Work mode, enabled in Web mode and Copilot Chat (this option also disables web search in Researcher and Analyst).

Users have their own **Web content** toggle under **Settings** > **Personalization** > **Advanced**, so the admin policy and the user preference both matter when explaining behavior.

## Teams meetings: Copilot and transcription

The control is the **Copilot** setting in **Meetings** > [**Meeting policies**](https://admin.teams.microsoft.com/policies/meetings) > **Recording & transcription** in the Microsoft Teams admin center. Its four values map to `Set-CsTeamsMeetingPolicy -Copilot`:

```powershell
Set-CsTeamsMeetingPolicy -Identity Global -Copilot Enabled
Set-CsTeamsMeetingPolicy -Identity Global -Copilot EnabledWithTranscript
Set-CsTeamsMeetingPolicy -Identity Global -Copilot EnabledWithTranscriptDefaultOn
Set-CsTeamsMeetingPolicy -Identity Global -Copilot Disabled
```

- **On** = `Enabled`
- **On with saved transcript required** = `EnabledWithTranscript` (the default; the older label was "On only with retained transcript")
- **On with transcript saved by default** = `EnabledWithTranscriptDefaultOn`
- **Off** = `Disabled`

Transcription itself is controlled separately with `-AllowTranscription`. Only **On with saved transcript required** is a value an administrator actually enforces; the other values just set an organizer default that the organizer can change.

## Information protection and DLP

Sensitivity labels classify content, they do not by themselves decide what Copilot may read. Labels are created at Microsoft Purview portal > **Solutions** > **Information Protection** > **Labels**.

The control that changes Copilot behavior is Microsoft Purview data loss prevention using the **Microsoft 365 Copilot and Copilot Chat** policy location. Supported combinations:

- **Content contains** > **Sensitivity labels**, action **Prevent Copilot from processing content**. The item can still appear as a citation, but its content is not used.
- **Content contains** > **Sensitive information types**, action **Prevent Copilot from processing content** > **Processing prompts**. Copilot does not answer the prompt at all.
- **Content contains** > **Sensitive information types**, action **Prevent Copilot from processing content** > **Performing Web Searches**. The prompt is blocked from web grounding only.
- **Email is received from** > **External users**, action **Prevent Copilot from processing content**. Externally received mail is excluded from grounding, summarization and citation.

## Data Security Posture Management

Microsoft Purview now ships a single unified **Data Security Posture Management** solution at Microsoft Purview portal > **Solutions** > **DSPM**. The pages most people were trained on are now **Data Security Posture Management (classic)** and **DSPM for AI (classic)**, and Microsoft Learn is explicit that most new capability lands only in the current version.

The current solution is organized around **Posture**, **Objectives** (for example "Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions"), **AI observability**, **Discover**, **Tasks and actions** and **Reports**, which is the navigation the portal actually renders.

Microsoft Security Copilot in this area is no longer a DSPM-specific article. It is covered by the Microsoft Purview AI agents documentation, with a DSPM application card and separate prompt guidance.

## Measuring adoption

Two surfaces answer "is anyone using Copilot", and they are for different audiences.

The Microsoft 365 admin center covers the administrator view at **Reports** > **Usage** > **Microsoft 365 Copilot**, which carries the Readiness, Usage, Copilot Chat usage, Agent usage and Copilot Search usage (public preview) reports. Viewing needs the **AI Administrator** role, and data lands with roughly 48 to 72 hours of latency.

The business view is **Copilot Analytics**, six surfaces inside the Microsoft Viva Insights web app, including the [Copilot Dashboard](https://insights.cloud.microsoft/#/CopilotDashboard/), the **Agent Dashboard**, and the **Consumption Dashboard** for Copilot Credits and GitHub AI Credits. Enablement and delegation are done by the **AI Administrator** role. The old Copilot Dashboard-specific feature access control is superseded by a single **Viva Insights web app** control, which turns off the entire app when disabled.

## Supervising interactions

Communication compliance is where "is anyone misusing it" gets answered. Go to Microsoft Purview portal > **Communication Compliance** > **Policies** > **Create policy** > **Detect Microsoft Copilot interactions**.

Policy locations are **Microsoft Copilot experiences**, **Enterprise AI apps** and **Other AI apps**. There is no charge for Microsoft 365 Copilot data, but detecting non-Microsoft 365 AI data (Copilot in Microsoft Fabric, Microsoft Security Copilot, Microsoft Copilot Studio, connected and cloud AI apps) requires **pay-as-you-go billing** to be enabled. Reviewers need membership in the Communication Compliance, Communication Compliance Investigators, or Communication Compliance Analysts role groups.

## Sources

[Manage Microsoft 365 Copilot scenarios in the Microsoft 365 admin center](https://learn.microsoft.com/microsoft-365/copilot/microsoft-365-copilot-page)

[Copilot Control System management controls](https://learn.microsoft.com/microsoft-365/copilot/copilot-control-system/management-controls)

[Manage Microsoft 365 Copilot Chat](https://learn.microsoft.com/copilot/manage)

[Data, privacy, and security for web search in Microsoft 365 Copilot and Microsoft 365 Copilot Chat](https://learn.microsoft.com/microsoft-365/copilot/manage-public-web-access)

[Microsoft 365 Copilot in Teams meetings and events](https://learn.microsoft.com/microsoftteams/copilot-teams-transcription)

[Learn about sensitivity labels](https://learn.microsoft.com/purview/sensitivity-labels)

[Learn about DLP for Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/purview/dlp-microsoft365-copilot-location-learn-about)

[Learn about Data Security Posture Management](https://learn.microsoft.com/purview/data-security-posture-management-learn-about)

[Microsoft Security Copilot and the Microsoft Purview AI agents](https://learn.microsoft.com/purview/copilot-in-purview-agents-overview)

[Data Security Posture Management application card in Security Copilot](https://learn.microsoft.com/purview/data-security-posture-management-application-card)

[Considerations for using Security Copilot with Data Security Posture Management](https://learn.microsoft.com/purview/data-security-posture-management-considerations)

[Microsoft 365 Copilot reporting options for admins](https://learn.microsoft.com/microsoft-365/copilot/microsoft-365-copilot-reports-for-admins)

[Microsoft 365 admin center activity reports](https://learn.microsoft.com/microsoft-365/admin/activity-reports/activity-reports)

[Introduction to Copilot Analytics](https://learn.microsoft.com/viva/insights/copilot-analytics-introduction)

[Manage settings for the Copilot Dashboard](https://learn.microsoft.com/viva/insights/advanced/admin/manage-settings-copilot-dashboard)

[Learn about Communication Compliance](https://learn.microsoft.com/purview/communication-compliance)

[Configure a communication compliance policy to detect Microsoft Copilot interactions](https://learn.microsoft.com/purview/communication-compliance-copilot)

[Interactive guide: Get started with Microsoft Purview Communication Compliance](https://mslearn.cloudguides.com/guides/Get%20started%20with%20Microsoft%20Purview%20Communication%20Compliance)
