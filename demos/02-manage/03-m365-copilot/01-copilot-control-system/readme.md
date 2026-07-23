# Drive the Copilot Control System, and the two settings that are not there

[Manage Microsoft 365 Copilot scenarios in the Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-page)

[Copilot Control System management controls](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-control-system/management-controls)

[Data, privacy, and security for web search in Microsoft 365 Copilot and Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/microsoft-365/copilot/manage-public-web-access)

[Manage Teams meeting transcription](https://learn.microsoft.com/en-us/microsoftteams/copilot-teams-transcription)

Hands-On Demo: [Turn off Copilot web search for one group and watch the user toggle go dark](demo-turn-off-web-search-for-a-pilot-group.md)

## What the Copilot Control System is, and where the settings actually live

The Copilot surface in the Microsoft 365 admin center is documented as the **Copilot Control System** (CCS), a framework with three pillars: security and governance, management controls, and measurement and reporting. The **Copilot** entry lands on [**Copilot Control System**](https://admin.cloud.microsoft/#/copilot/overview), whose five tabs are **Overview**, **Security**, **Usage**, **Health** and **About**. What an administrator drives day 2 is one level down, at [**Copilot settings**](https://admin.cloud.microsoft/#/copilot/settings), and that page has two tabs: **Optimize**, a prioritized table of Name, Status and Impact filtered by Required, Recommended and Optional, and **View all**, a single searchable list of every setting with a Name, Description and **Applies to** column. Microsoft Learn still describes the older **User access**, **Data access**, **Copilot actions** and **Other settings** grouping, but those are no longer tabs in the portal, so teach the search box rather than a tab path.

Two facts about this page decide how much of it you will actually see. First, the admin center only renders scenarios that are licensed in the tenant, so a tenant with Microsoft Viva or Power Platform shows tiles that a bare Microsoft 365 E5 tenant does not. Second, the role split is narrow: **AI Administrator** to view and change Copilot scenarios, **Global Reader** to view them only. Global Administrator works but is the wrong answer in a design review, and several tiles hand you off to a console where a completely different role applies.

## Configure here, or somewhere else: how to read a tile

The single most useful skill on this page is telling a control apart from a hyperlink. Learn marks each scenario as either "Configure in the Microsoft 365 admin center" or "Shortcut to" some other console, and about a quarter of them are shortcuts.

**Data access** > **Copilot in Power Platform and Dynamics 365** opens the Power Platform admin center. **Data access** > **Data security and compliance** is a page of links into the Microsoft Purview portal. **Copilot actions** > **Copilot in Teams meetings** opens the Microsoft Teams admin center in a new tab.

That distinction matters operationally because the shortcut tiles carry no permission of their own. An AI Administrator can open the Teams tile and then be refused by the Teams admin center, because that console wants the Teams Administrator role. When a change request says "turn this off in the Copilot settings page", the first question is which console the value really lives in and who holds the role there.

The scenario Learn still calls "Copilot in Bing, Edge, and Windows" no longer appears under that name. **View all** lists **Copilot in Edge**, described as AI-powered chat for work with enterprise data protection, and it is a shortcut rather than a switch. The old ConfigureM365Copilot.ps1 download that used to enable or disable Copilot in Bing is gone, and no current Learn article references it. If an attendee brings a copy of that script to class, it no longer does anything.

Copilot Chat behavior in the browser is now governed by Microsoft Edge configuration policies instead: `EdgeEntraCopilotPageContext` to stop Copilot Chat reading page and PDF content in the work profile, `HubsSidebarEnabled` to disable the Edge sidebar (and with it Copilot Chat in Edge) entirely, and `CopilotPageContext` for the personal-account case. The separate **User access** > **Copilot in Edge** tile is the shortcut that creates those policies, at **Settings** > **Microsoft Edge** > **Configuration policies**.

## Web search: the tile is in Copilot, the setting is in Cloud Policy

**Data access** > **Web search for Microsoft 365 Copilot and Microsoft 365 Copilot Chat** is a shortcut, not a toggle. The real control is the **Allow web search in Copilot** policy in the Cloud Policy service for Microsoft 365, created in the [Microsoft 365 Apps admin center](https://config.office.com/officeSettings/officePolicies) under **Customization** > **Policy Management**. Creating it needs the **Office Apps Administrator** role, and because Cloud Policy configurations are scoped to Microsoft Entra groups of user objects, this is the one Copilot control that is naturally piloted on a subset of the tenant.

The policy has three values, and the third is the one worth teaching. **Enabled in Microsoft 365 Copilot and Microsoft 365 Copilot Chat**, **Disabled in both**, and **Disabled in Microsoft 365 Copilot Work mode; Enabled in Microsoft 365 Copilot Web mode and Microsoft 365 Copilot Chat**. That third value is what an organization reaches for when it wants "no web grounding while Copilot is looking at our content, but keep the open-web assistant", and it carries a side effect Learn calls out: choosing it also disables web search in Researcher and Analyst.

Leaving the policy unconfigured is not neutral. Web search is on by default for commercial tenants, unless **Allow the use of additional optional connected experiences in Office** is set to Disabled, which is a blunter instrument that restricts many experiences beyond Copilot. Government tenants invert this: in GCC and DoD web search is off unless the policy explicitly enables it.

On top of the admin policy sits a user preference, the **Web content** toggle at **Settings** > **Personalization** > **Advanced** in the Microsoft 365 Copilot app. When the admin policy allows web search the toggle is on and the user may turn it off; when the admin disables it the toggle is off and dimmed, which is the visible proof that the policy landed.

## Copilot in Teams meetings: a three-way negotiation

The Copilot control for meetings is not in the Microsoft 365 admin center either. It is the **Copilot** setting in **Meetings** > **Meeting policies** > **Recording & transcription** in the [Microsoft Teams admin center](https://admin.teams.microsoft.com). Its four values map one to one onto `Set-CsTeamsMeetingPolicy -Copilot`:

```powershell
Set-CsTeamsMeetingPolicy -Identity "Copilot Pilot" -Copilot EnabledWithTranscript
```

**On** (`Enabled`) defaults organizers to "Only during the meeting" and lets them change it. **On with saved transcript required** (`EnabledWithTranscript`) is the default value, forces "During and after the meeting", and is the only one of the four that organizers cannot override. **On with transcript saved by default** (`EnabledWithTranscriptDefaultOn`) sets the same default but leaves the organizer free to change it. **Off** (`Disabled`) defaults to Off, and the organizer can still turn Copilot back on for their own meeting.

Read that list again with the enforcement question in mind. Three of the four values only set an organizer default, so a policy named "Copilot off for Legal" that uses **Off** does not stop anyone in Legal from using Copilot in a meeting they organize. Whether Copilot works at all is decided by a triangle: the admin transcription policy (`-AllowTranscription`), the admin Copilot meeting-policy value, and the organizer's per-meeting choice.

If the organizer sets Copilot to Off for a meeting, recording and transcription go off with it, for everyone, regardless of policy. If transcription is off but the organizer chose "During and after the meeting", licensed users get nothing until some participant with permission starts a transcript.

## Removing access: pinning is not a block

The last thing administrators ask for is usually "take Copilot away from this group", and the instinct is to unpin it. **User access** > **Pin Copilot Chat** does unpin Copilot Chat from the navigation bar in Outlook and Teams, but it never blocked anything: an unpinned user can still reach Copilot Chat from the app store or directly at `https://m365.cloud.microsoft/chat`. As of January 28, 2026 for all tenants worldwide, the **Pin Copilot Chat in Microsoft 365 apps** setting no longer governs the Microsoft 365 Copilot app at all. Chat is visible in that app's navigation and cannot be unpinned.

Actually removing access means the **Integrated Apps** control on the Copilot app in the Microsoft 365 admin center, scoped with *Specific users/group in the organization can install*. Note the blast radius before you use it: that control is tenant-wide across the Microsoft 365 Copilot app, Outlook, Teams, and Copilot Chat on the web, and it applies to licensed users too if they fall inside the scope. The usual pattern is therefore inverted, scoping the app to a group that contains only the Microsoft 365 Copilot licensed users. Blocked users still see Chat in the navigation and get an in-product message that Copilot Chat is unavailable because of organizational policy, and Microsoft Learn documents pointing that message at your own guidance with **Copilot** > **Settings** > **View all** > **Custom link for blocked Microsoft 365 Copilot app**, an entry that did not appear in a tenant checked in July 2026 where the app was not blocked.

## Discussion questions

- A regulated customer wants "no web grounding when Copilot touches our documents, but keep the open-web assistant for research". The third value of **Allow web search in Copilot** does exactly that and also kills web search in Researcher and Analyst. Do you take the setting, or push them to disable web search entirely and buy back Researcher another way?
- Compliance asks you to guarantee that no meeting in the Legal department runs Copilot. Given that only **On with saved transcript required** is enforceable and **Off** is merely a default, what do you actually commit to in writing?
- Security wants Copilot Chat gone for all unlicensed users by Friday. Integrated Apps is tenant-wide and can strip licensed users too. Do you build the licensed-users group and scope the app, or do you accept the visible-but-blocked experience and document it instead?
