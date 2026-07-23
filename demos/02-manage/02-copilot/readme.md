# Manage Microsoft Copilot

Managing this surface starts with accepting that the name on the button no longer tells you who owns the conversation. Since January 2025 the work and education experience is **Microsoft 365 Copilot Chat**: web-grounded, reached with a Microsoft Entra ID sign-in, and covered by enterprise data protection. **Microsoft Copilot** now means the consumer product only, signed into with a personal Microsoft account at copilot.microsoft.com, bing.com/chat, copilot.com or copilot.ai. The same person, on the same laptop, in the same browser, gets a different contract depending on which account authenticated, and you can only govern one of the two.

The second thing to accept is that Copilot Chat is already switched on. It is included at no extra cost with the Microsoft 365 and Office 365 subscriptions most tenants already hold, so there is no rollout decision to make and no procurement gate to hide behind. The administrator's job is therefore not enablement, it is boundary work: deciding where grounding may reach, which agents may cost money, and which surfaces are governed from a console you do not personally own.

That is the tension this module keeps returning to. Every control here trades reach against risk, and several of the controls an administrator reaches for first have quietly stopped working: the mobile app setting is retired, the pin setting no longer governs the Microsoft 365 Copilot app, and Copilot in Windows is gone. Knowing which lever still moves something is most of the skill.

## Topics

- [Microsoft 365 Copilot Chat and enterprise data protection](01-chat-with-edp/readme.md)
- [Govern Copilot on mobile and in Microsoft Edge](02-mobile-and-edge-controls/readme.md)
- [Meter and govern agents in Copilot Chat](03-agents-and-metering/readme.md)

## Where this is administered

The primary administration surface is the Copilot Control System page in the [Microsoft 365 admin center](https://admin.microsoft.com/), under **Copilot** > [**Settings**](https://admin.microsoft.com/Adminportal/Home#/copilot/settings), with sibling nodes for **Agents** and for billing and usage. Data access controls, including agents and other large language model providers, sit under **Copilot** > **Settings** > **Data access**.

The least-privileged role for this work is Microsoft Entra **AI Administrator**, not Global Administrator. Billing method changes are the exception: adding or changing a billing method requires Global Administrator or Billing Administrator, while AI Administrator and License Administrator can create spending policies, set limits and alerts, and read the cost management dashboard.

Two surfaces are administered elsewhere. Copilot Chat in Microsoft Teams is managed as a Teams app in the [Microsoft Teams admin center](https://admin.teams.microsoft.com/), and mobile browser behavior is managed with app configuration policies in the [Microsoft Intune admin center](https://intune.microsoft.com/).

## Who is entitled to Copilot Chat

Copilot Chat with enterprise data protection is included at no extra cost for Microsoft Entra ID users holding any of the following:

- Microsoft 365 A1, A3, A5, Business Basic, Business Standard, Business Premium, E3, E5, F1, F3, G3, G5
- Office 365 A1, A1 Plus, A3, A5, E1, E1 Plus, E3, E5, F3, G1, G3, G5
- Microsoft Teams, including Essentials, Enterprise and Rooms
- The "(no Teams)" and "EEA (no Teams)" variants of the above

Enterprise data protection (EDP) is the current promise, and it replaced the older commercial data protection (CDP) wording. Under EDP, prompts, responses and data accessed through Microsoft Graph are not used to train foundation models and are not used to build a per-user behavioural profile. Personalization comes from grounding data retrieved per request against the signed-in user's existing permissions, which is why a Copilot answer is only ever as broad as the permissions behind it.

## What Copilot Chat does for a user

Copilot Chat answers from the model plus the public web, and it surfaces in the flow of work rather than as a separate destination. Typical use is drafting and rewriting text, explaining or summarizing a document the user opens, reasoning over data a user pastes in, and preparing replies or agendas from content the user supplies.

The paid Microsoft 365 Copilot license is the line where work grounding starts. Licensed users can toggle between **web** and **work** in the Microsoft 365 Copilot app, and only the work mode reaches mail, chats, meetings and files through Microsoft Graph. Everything a licensed user sees in work mode is filtered by that user's existing permissions, evaluated per request.

## Mobile and browser app configuration keys

Copilot in Microsoft Edge for iOS and Android is governed by three Intune app configuration keys, not one. All three default to `true`, and all three are case sensitive.

```text
com.microsoft.intune.mam.managedbrowser.Chat
com.microsoft.intune.mam.managedbrowser.ChatPageContext
com.microsoft.intune.mam.managedbrowser.CopilotMode
```

`Chat` controls whether the Copilot button appears, `ChatPageContext` controls whether Copilot may read the open web page or PDF, and `CopilotMode` controls the newer Microsoft 365 Copilot Mode experience. Delivered through the MDM channel to enrolled devices, the equivalent policy names are `EdgeCopilotEnabled`, `EdgeChatPageContext` and `CopilotMode`.

The Microsoft 365 mobile app key that used to appear in this list is retired:

```text
com.microsoft.office.officemobile.BingChatEnterprise.IsAllowed
```

Intune documentation now strikes it through and states that administrators can no longer enable or disable Copilot in the Microsoft 365 app by configuring it. The Microsoft 365 app has become the Microsoft 365 Copilot app, where Copilot is the core workflow and cannot be switched off independently on mobile. To restrict Copilot there, block the Copilot app through Integrated Apps in the Microsoft 365 admin center, which covers web, desktop and mobile, or block the Microsoft 365 Copilot mobile app itself.

## Controls that no longer do what they used to

The **Pin Microsoft 365 Copilot Chat in Microsoft 365 apps** setting stopped governing the Microsoft 365 Copilot app for European Economic Area and Switzerland tenants on July 25, 2025, and for all remaining tenants worldwide on January 28, 2026. Chat is permanently visible in that app's navigation. The setting still affects Outlook and Teams, but if the goal is to remove access rather than tidy a navigation bar, the only working lever is blocking the Copilot app in Integrated Apps.

Copilot in Windows was removed, and the standalone Microsoft Copilot app now works only with personal Microsoft accounts. It does not work for commercial users signing in with a Microsoft Entra ID account, so it is not an enterprise surface to manage. Managed organizations should remap the Copilot key on the keyboard to launch the Microsoft 365 Copilot app instead.

## Sources

[Manage Microsoft 365 Copilot Chat](https://learn.microsoft.com/copilot/manage)

[Copilot Control System overview](https://learn.microsoft.com/microsoft-365/copilot/copilot-control-system/overview)

[Enterprise data protection in Microsoft 365 Copilot and Microsoft 365 Copilot Chat](https://learn.microsoft.com/microsoft-365/copilot/enterprise-data-protection)

[Pin Microsoft 365 Copilot Chat in the Microsoft 365 apps](https://learn.microsoft.com/microsoft-365/copilot/pin-copilot-chat-navbar)

[Manage Microsoft Edge on iOS and Android with Intune](https://learn.microsoft.com/intune/app-management/configuration/configure-edge-ios-android)

[Manage collaboration experiences in Microsoft 365 for iOS and Android with Intune](https://learn.microsoft.com/intune/app-management/configuration/configure-microsoft-365-mobile)

[Updated Windows and Microsoft 365 Copilot Chat experience](https://learn.microsoft.com/windows/client-management/manage-windows-copilot)

[Agents admin guide for Microsoft 365](https://learn.microsoft.com/microsoft-365/copilot/agent-essentials/m365-agents-admin-guide)
