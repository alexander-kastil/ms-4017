# Hands-On Demo: Ship an Intune app configuration policy that strips Copilot page context from Edge mobile

Goal: prove that Copilot on a phone is governed by Microsoft Intune app configuration, not the Microsoft 365 admin center, and that a key many admins still deploy has been retired.

[Manage Microsoft Edge on iOS and Android with Intune](https://learn.microsoft.com/intune/app-management/configuration/configure-edge-ios-android)

Prerequisite: an Intune app protection policy already targeting Edge and the Microsoft 365 Copilot app, plus a test device signed in with the work account.

## Steps

1. In the [Microsoft Intune admin center](https://intune.microsoft.com), open **Apps** > [**App configuration policies**](https://intune.microsoft.com/#view/Microsoft_Intune_Apps/AppConfigMenu) > **Add** > **Managed apps** and name it `Edge mobile - Copilot page context off`. Expected: the Managed apps wizard opens with the Public apps selector available (App Protection Policy channel, not MDM).

2. On **Basics**, select **Select public apps** and pick **Edge for iOS and Android** on both platform entries, then **Next**. Expected: the Targeted apps list shows two Edge entries and the wizard advances to Settings.

3. On **Settings**, in the general configuration key/value grid enter these four pairs exactly (casing included). The first three are live keys; the fourth is the retired Microsoft 365 app key, added so the class can watch it fail:

   ```text
   com.microsoft.intune.mam.managedbrowser.Chat                     true
   com.microsoft.intune.mam.managedbrowser.ChatPageContext          false
   com.microsoft.intune.mam.managedbrowser.CopilotMode              false
   com.microsoft.office.officemobile.BingChatEnterprise.IsAllowed   false
   ```

   Expected: four rows with keys spelled exactly as typed, no validation error, no strikethrough or warning on the retired fourth row.

4. Select **Next** to **Assignments**, **Add groups**, select your pilot group, then **Create**. Expected: a success notification and the new policy listed with Managed apps in the type column.

5. On the test device, close and reopen Microsoft Edge, then open **Settings** and find the Copilot section. Expected: **Show Copilot** is still on (because `.Chat` is `true`), while **Allow access to any web page or PDF** and **Quick access on text selection** are greyed off and cannot be enabled.

6. In Edge on the device, open any intranet page or PDF, tap the Copilot button, and submit this prompt:

   ```text
   Summarize this page.
   ```

   Expected: Copilot answers from its own knowledge or asks for more, not from the content on screen (the button works; page context is gone).

7. In Edge, type `about:intunehelp` in the address bar, select **Get Started** > **Share Logs**, mail the log to yourself, and search `IntuneMAMDiagnostics.txt` for `ApplicationConfiguration`. Expected: the log lists `com.microsoft.intune.mam.managedbrowser.ChatPageContext` with value `false`. On an enrolled device, cross-check in the [Microsoft Intune admin center](https://intune.microsoft.com) under **Devices** > **All devices** > (device) > **App configuration**.

8. Open the Microsoft 365 Copilot app on the same device and send any prompt. Expected: Chat still works and no policy-blocked message appears, proving the retired `BingChatEnterprise.IsAllowed` value changed nothing.
