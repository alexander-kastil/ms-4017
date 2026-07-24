# Hands-On Demo: Block Copilot on a non-compliant device with Conditional Access

Goal: prove Copilot access is decided by identity and device posture, not a Copilot setting, with one Conditional Access policy that never names Copilot.

[Protect AI with a Conditional Access policy](https://learn.microsoft.com/entra/identity/conditional-access/policy-all-users-copilot-ai-security) | [Copilot honors Conditional Access and MFA](https://learn.microsoft.com/microsoft-365/copilot/microsoft-365-copilot-architecture#copilot-honors-conditional-access-and-mfa)

## Steps

1. In the Microsoft Intune admin center open **Devices** > [**Compliance**](https://intune.microsoft.com/#view/Microsoft_Intune_DeviceSettings/DevicesMenu/~/compliance) > **Create policy**, platform **Windows 10 and later**, name it `ZT-Compliance-Windows-Baseline`, set **Require BitLocker**, **Secure Boot**, and **Code integrity** to **Require**, set **Firewall**, **Antivirus**, and **Antispyware** to **Require**, and assign it to the test user's group. Expected: the policy lists with platform **Windows 10 and later** and the six settings and pilot group on its **Properties** page.

2. In Intune open **Devices** > **All devices** and check the enrolled test device. Expected: it shows **Compliant**, and the unenrolled device is absent from the list.

3. In the Microsoft Entra admin center open **Protection** > **Conditional Access** > [**Policies**](https://entra.microsoft.com/#view/Microsoft_AAD_ConditionalAccess/ConditionalAccessBlade/~/Policies) > **New policy** and name it:

   ```text
   CA05 - All resources: Require MFA and compliant device for Copilot pilot
   ```

   Under **Assignments** > **Users** > **Include** select the pilot group; under **Exclude** add your emergency access accounts, and with Entra Connect or Cloud Sync also add **Directory roles** > **Directory Synchronization Accounts**. Expected: the section summarizes Include and Exclude and **Create** is enabled (Conditional Access refuses to save with no excluded account).

4. Under **Target resources** > **Resources** > **Include** select **All resources** with no exclusions. Under **Access controls** > **Grant** select **Grant access**, tick **Require multifactor authentication** and **Require device to be marked as compliant**, leave **Require all the selected controls**, set **Enable policy** to **Report-only**, and select **Create**. Expected: the policy lists with state **Report-only** and no user sees a change.

5. On the **Policies** blade select **What If**, enter the test user, set **Target resources** by App ID, set **Device platform** to **Windows** and **Client app** to **Browser**, and run it. Expected: `CA05` is listed as applying, with both grant controls.

6. Have the test user sign in to Microsoft 365 Copilot Chat on the enrolled device and ask:

   ```text
   Summarize the documents I worked on last week and list who else has access to them.
   ```

   Then open **Entra ID** > **Monitoring & health** > [**Sign-in logs**](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/SignInEventsV3), open that sign-in, and select the **Report-only** tab. Expected: Copilot returns a grounded answer with citations, and the `CA05` row reads **Report-only: Success**.

7. Repeat the identical prompt as the same user on the unenrolled device, then open that sign-in's **Report-only** tab. Expected: Copilot still answers (not enforced yet) but the `CA05` row reads **Report-only: Failure**. Verify your own admin device is compliant before continuing.

8. Reopen `CA05`, move **Enable policy** from **Report-only** to **On**, save, and retry the prompt on both devices. Expected: the compliant device answers, the non-compliant device shows the Conditional Access block page, and **Sign-in logs** show the `CA05` rows on the **Conditional Access** tab as **Success** and **Failure**.
