# Govern Copilot on mobile and in Microsoft Edge

[Manage Microsoft Edge on iOS and Android with Intune](https://learn.microsoft.com/intune/app-management/configuration/configure-edge-ios-android)

[Manage collaboration experiences in Microsoft 365 (Office) for iOS and Android with Intune](https://learn.microsoft.com/intune/app-management/configuration/configure-microsoft-365-mobile)

[Microsoft 365 Copilot Chat in Edge and access to page content](https://learn.microsoft.com/deployedge/edge-learnmore-copilot-page-summary-results)

[Manage Microsoft 365 Copilot Chat](https://learn.microsoft.com/copilot/manage)

Hands-On Demo: [Ship an Intune app configuration policy that strips Copilot page context from Edge mobile](demo-govern-copilot-on-mobile-and-edge.md)

## Why mobile is a different console

Everything else in this module is administered from the Copilot Control System page in the Microsoft 365 admin center, under **Copilot** > [**Settings**](https://admin.microsoft.com/), with Microsoft Entra **AI Administrator** as the least-privileged role. Mobile is the exception. The browser surface on a phone is governed by Microsoft Intune app configuration policies, authored in the [Microsoft Intune admin center](https://intune.microsoft.com/) under **Apps** > **App configuration policies**, by someone holding the Intune **Policy and Profile Manager** role.

That split matters operationally, because the two consoles are usually staffed by two different teams. A Copilot administrator can turn web grounding off tenant-wide and still have no idea that Copilot Chat in Edge on an unenrolled phone is reading the intranet page the user has open. The mobile control is not a Copilot control at all; it is a browser control that happens to constrain Copilot.

Intune delivers app configuration through two channels. A **Managed devices** policy rides the MDM OS channel and only reaches enrolled devices. A **Managed apps** policy rides the Intune App Protection Policy channel and reaches both enrolled and unenrolled devices, which is why the Edge documentation recommends the **Managed apps** model whenever an app protection policy is already targeted at the user. On a bring-your-own phone that never enrolls, **Managed apps** is the only channel that works.

## The three Edge mobile keys

Microsoft Edge for iOS and Android exposes exactly three Copilot-related MAM keys, and they are case sensitive. Getting the casing wrong is the single most common reason a policy appears assigned but changes nothing on the device.

```text
com.microsoft.intune.mam.managedbrowser.Chat
com.microsoft.intune.mam.managedbrowser.ChatPageContext
com.microsoft.intune.mam.managedbrowser.CopilotMode
```

`.Chat` controls whether the Copilot button appears in the bottom bar. Set to `false`, the in-app setting **Show Copilot** is disabled and the user cannot turn it back on. `.ChatPageContext` controls whether Copilot may read what is on screen: set to `false`, the toggles **Allow access to any web page or PDF** and **Quick access on text selection** are disabled and unchangeable.

`.CopilotMode` opts the tenant out of the newer Microsoft 365 Copilot Mode experience in Edge mobile, which currently surfaces Copilot suggestion prompts on the new tab page and is slated to become default-enabled. All three default to `true`, and on enrolled devices the same three settings appear under their MDM names `EdgeCopilotEnabled`, `EdgeChatPageContext` and `CopilotMode`.

The teaching point is that these are three separate decisions, not one dial. Hiding the button with `.Chat=false` removes an entry point but says nothing about data. Leaving the button visible while setting `.ChatPageContext=false` keeps Copilot Chat usable and cuts it off from the page and PDF content in front of the user, which is the configuration most regulated customers actually want. Without the second key, a user on an unmanaged phone can point Copilot at an internal SharePoint page or a downloaded PDF and get it summarized, and no Copilot Chat setting in the Microsoft 365 admin center will stop that.

## The key that died, and what replaced it

The Microsoft 365 mobile app used to honor `com.microsoft.office.officemobile.BingChatEnterprise.IsAllowed`, and a great deal of older guidance still tells you to deploy it. Microsoft's current Intune documentation renders that key struck through and states plainly that admins can no longer enable or disable Copilot in the Microsoft 365 app by configuring it.

The reason is a product change, not a policy change. The Microsoft 365 app became the Microsoft 365 Copilot app, an AI-forward app in which Copilot is the core workflow and cannot be disabled independently on mobile; the remaining Office workflows are being redirected to the OneDrive, Word, Excel and PowerPoint apps. The same logic retired the pinning lever. The **Pin Microsoft 365 Copilot Chat** setting stopped governing the Microsoft 365 Copilot app for tenants whose primary location is in the European Economic Area or Switzerland on July 25, 2025, and for all remaining tenants on January 28, 2026, so Chat cannot be unpinned from that app's navigation.

If you genuinely need to remove access, there are only two supported moves. Block the Copilot app in **Integrated Apps** in the Microsoft 365 admin center, which is a tenant-wide control that can be scoped to users or groups and removes Copilot Chat in the Microsoft 365 Copilot app, Teams, Outlook and the web at once. Or block the Microsoft 365 Copilot mobile app itself if you only care about phones. Deploying the retired key alongside either of those costs nothing and teaches nothing, which is precisely why the demo deploys it: to watch it do nothing.

## The desktop browser equivalents

The mobile keys have no effect on Edge for Windows or macOS, where the same three concerns are handled by browser policies. `EdgeEntraCopilotPageContext` controls whether Copilot in the Edge side pane may access page content and browsing history for Microsoft Entra signed-in users, and it explicitly covers Microsoft 365 Copilot Chat and Copilot with enterprise data protection. It is supported on Windows and macOS from version 130 and is not supported on Android or iOS, which is exactly why the mobile story needs its own keys.

Its default is region-dependent and worth stating out loud in class: unconfigured, page-content access is enabled in non-EU regions and disabled in EU regions, with the user able to toggle it in **Microsoft Edge** > **Settings** > **Appearance** > **Copilot and Sidebar** > **Copilot**. Two blunter policies sit alongside it. `HubsSidebarEnabled` disables Copilot Chat in Edge entirely, at the cost of blocking every Edge sidebar app. `Microsoft365CopilotChatIconEnabled`, supported on Windows and macOS from version 139, only controls whether the Microsoft 365 Copilot Chat icon is shown in the Microsoft Edge for Business toolbar, so it removes the entry point without disabling the sidebar.

## Data loss prevention blocks it sideways

Copilot cannot read page content on pages protected by data loss prevention policies, even when `EdgeEntraCopilotPageContext` is enabled. Edge for Business is integrated with Microsoft Purview and Intune MAM, and several policies that were never written with Copilot in mind will block page access as a side effect.

For Intune MAM, blocking **Clipboard**, **Print**, **Upload** or **Download** blocks Copilot from page content. For Microsoft Purview Endpoint DLP, sensitive service domain groups set to block or override on **Copy**, **Print** or **Save Webpage As** do the same, as do Purview DLP policies for managed app interactions on **Download**, **Copy**, **Print** or **Dev tools**. Microsoft Purview Information Protection blocking **Extract** covers Office documents.

The trade-off is that this protection is invisible in the Copilot console and unattributable from the user's side. A user whose summarization silently stops working on one intranet domain has no way to tell whether an admin flipped a Copilot policy or a DLP rule fired, and neither does a first-line support agent looking only at Copilot settings. Document which DLP rules you are relying on for Copilot containment, or you will re-litigate this every quarter.

## Why you cannot solve this at the network layer

The instinct of most network teams is to block the endpoints. Microsoft does not recommend and cannot support managing Microsoft 365 Copilot Chat through network-level restrictions such as selective domain, URL or IP blocking, or network-protocol filtering. Copilot Chat is integrated deeply enough into the applications that these restrictions produce unpredictable results and can fail or block the applications themselves.

The same warning applies inside the browser. Blocking internal `edge://` or `chrome-untrusted://` URLs such as `edge://commercial-copilot-chat` is explicitly not recommended, because Edge relies on those container pages; the supported answer is the policy, not the URL block. The one narrow exception the Edge mobile documentation does allow is using `AllowListURLs` or `BlockListURLs` against the consumer web endpoint `copilot.microsoft.com`, which is a different product for a different account type.

## Discussion questions

- A regulated customer wants Copilot Chat available on unenrolled phones but forbidden from reading intranet pages. You can set `.Chat=false`, `.ChatPageContext=false`, or block the app in Integrated Apps. Which do you ship, and what do you tell the user population you took away?
- Your EU tenant never configured `EdgeEntraCopilotPageContext`, so desktop page context is off by default, while `.ChatPageContext` on mobile defaults to on. Is that inconsistency a bug you fix, or a default you document, and who owns the decision?
- The retired `BingChatEnterprise.IsAllowed` key is still in your baseline and still deploys cleanly with no error. What is the operational cost of leaving a dead key in a policy set, and how would you have caught it before the class did?
