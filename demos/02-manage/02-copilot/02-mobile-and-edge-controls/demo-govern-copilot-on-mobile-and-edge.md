# Hands-On Demo: Ship an Intune app configuration policy that strips Copilot page context from Edge mobile

Goal: prove that Copilot on a phone is governed by Microsoft Intune app configuration and not by the Microsoft 365 admin center, and that one of the keys everybody still deploys has been retired.

Budget 15 minutes. You need an account with the Intune **Policy and Profile Manager** role (or Intune Administrator), a Microsoft Entra pilot group, a test user with a Microsoft 365 license that includes Microsoft 365 Copilot Chat, and one iOS or Android device with Microsoft Edge and the Microsoft 365 Copilot app installed and signed in with the work account. An Intune app protection policy targeting those apps must already exist, otherwise the managed apps channel has nothing to ride on.

## Steps

1. In the [Microsoft Intune admin center](https://intune.microsoft.com/), go to **Apps** > **App configuration policies** > **Add** > **Managed apps**. On **Basics**, enter the name `Edge mobile - Copilot page context off` and the description `Blocks Copilot page and PDF context on managed and unmanaged phones`. Expected result: the **Managed apps** wizard opens and the **Public apps** selector is available, confirming you are on the App Protection Policy channel rather than the MDM channel.

2. Still on **Basics**, select **Select public apps** and pick **Edge for iOS and Android** on both the iOS/iPadOS and Android platform entries, then **Select** and **Next**. Expected result: the **Targeted apps** list shows two Edge entries, one per platform, and the wizard advances to **Settings**.

3. On **Settings**, scroll past the built-in **Edge configuration settings** to the general configuration key/value grid and enter these four pairs exactly, casing included. The first three are live keys; the fourth is the retired Microsoft 365 app key, added so the class can watch it fail later:

   ```text
   com.microsoft.intune.mam.managedbrowser.Chat                     true
   com.microsoft.intune.mam.managedbrowser.ChatPageContext          false
   com.microsoft.intune.mam.managedbrowser.CopilotMode              false
   com.microsoft.office.officemobile.BingChatEnterprise.IsAllowed   false
   ```

   Expected result: four rows appear in the configuration key list with the key text spelled exactly as typed, no red validation message under any field, and **Next** stays enabled. The retired fourth row renders in the same black text as the three live keys, with no strikethrough, no warning banner, and no tooltip. There is no portal-side signal that the setting is dead, which is the whole point of adding it.

4. Select **Next** to **Assignments**, choose **Add groups**, and select your pilot group. Select **Next**, review, then **Create**. Expected result: a green notification confirms the policy was created, and the new policy appears in the **App configuration policies** list with **Managed apps** in the type column.

5. On the test device, close and reopen Microsoft Edge, then open **Settings** and find the Copilot section. Expected result: **Show Copilot** is still on and the Copilot button is still visible in the bottom bar (because `.Chat` was left `true`), while **Allow access to any web page or PDF** and **Quick access on text selection** are greyed out, off, and cannot be turned on by the user.

6. In Edge on the device, open any intranet page or a PDF, tap the Copilot button and submit this prompt:

   ```text
   Summarize this page.
   ```

   Expected result: Copilot Chat answers, but from its own knowledge or a request for more information, not from the content on screen. The button works; the eyes are gone.

7. Prove delivery from the device itself. In Microsoft Edge, type `about:intunehelp` in the address bar, select **Get Started**, select **Share Logs**, mail the log to yourself and search `IntuneMAMDiagnostics.txt` for `ApplicationConfiguration`. Expected result: the log block lists `com.microsoft.intune.mam.managedbrowser.ChatPageContext` with the value `false`, which is delivery evidence that also works on a phone that never enrolled. On an enrolled test device you can cross-check in the [Microsoft Intune admin center](https://intune.microsoft.com/) under **Devices** > **All devices** > select the test device > **App configuration**, where the policy is listed with its state.

8. Open the Microsoft 365 Copilot app on the same device and send any prompt. Expected result: Chat is still in the navigation bar, the prompt returns a normal answer, and no policy-blocked message appears, so the `BingChatEnterprise.IsAllowed` value you deployed in step 3 changed nothing on the device.

## Talking points

Step 3 is the moment to slow down. The three keys are three different decisions: `.Chat` hides an entry point, `.ChatPageContext` removes access to data, `.CopilotMode` opts out of an experience shift that will otherwise arrive by default. Most customers reach for the first one when what their risk register actually describes is the second.

Step 5 and step 6 together are the demo. Nothing was blocked at the network, no license changed, and Copilot still works. A single app configuration value moved the boundary of what Copilot may look at, and the toggle is greyed out rather than merely defaulted off, so the user cannot undo it.

Step 8 is the uncomfortable one. Intune accepted a retired key, reported success, and changed nothing, because the Microsoft 365 app is now the Microsoft 365 Copilot app where Copilot is the core workflow. If a customer's answer to "how do you control Copilot on mobile" is that key, they have had no control for some time. The supported route is **Integrated Apps** in the Microsoft 365 admin center, or blocking the Microsoft 365 Copilot mobile app.

## Variation

Run the same lesson from the desktop side. On a managed Windows client, set the Microsoft Edge policy `EdgeEntraCopilotPageContext` to disabled through Group Policy or an Intune settings catalog profile, then repeat the `Summarize this page.` prompt in the Edge side pane. The outcome matches step 6, from a completely different console and with a completely different identifier, which is the cleanest way to show that mobile and desktop are two policy surfaces for one product decision. If the tenant is in the EU, check the unconfigured state first: page context is already disabled by default there, so the policy proves its point only once you explicitly enable it and watch summarization start working.
