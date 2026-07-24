# Hands-On Demo: Block Copilot on a non-compliant device with Conditional Access

Goal: prove that Microsoft 365 Copilot access is decided by identity and device posture and not by any Copilot setting, by building one Conditional Access policy that never names Copilot and watching the same user succeed on a compliant device and get blocked on a non-compliant one.

Budget 15 minutes. You need the **Conditional Access Administrator** role in Microsoft Entra ID, the **Intune Administrator** role to create the compliance policy, one test user (not an administrator) with a Microsoft 365 Copilot license, Microsoft Entra ID P1, an emergency access account already excluded from your policies, and two devices for that user: one Intune-enrolled Windows device and one device that is not enrolled.

## Steps

1. In the Microsoft Intune admin center, go to **Devices** > [**Compliance**](https://intune.microsoft.com/#view/Microsoft_Intune_DeviceSettings/DevicesMenu/~/compliance) > **Create policy**, choose platform **Windows 10 and later**, and name it `ZT-Compliance-Windows-Baseline`. Under **Device health** set **Require BitLocker**, **Require Secure Boot to be enabled on the device**, and **Require code integrity** to **Require**, and under **System security** set **Firewall**, **Antivirus**, and **Antispyware** to **Require**. Assign it to the group containing your test user. Expected result: `ZT-Compliance-Windows-Baseline` appears in the **Compliance policies** list with platform **Windows 10 and later**, and its **Properties** page shows all six settings set to **Require** and the pilot group listed under **Assignments**.

2. Still in Intune, open **Devices** > **All devices** and confirm the enrolled test device. Expected result: the enrolled device shows **Compliant** in the compliance column, and the unenrolled device does not appear in the list at all.

3. In the [Microsoft Entra admin center](https://entra.microsoft.com), go to **Entra ID** > **Conditional Access** > [**Policies**](https://entra.microsoft.com/#view/Microsoft_AAD_ConditionalAccess/ConditionalAccessBlade/~/Policies) > **New policy** and name it:

   ```text
   CA05 - All resources: Require MFA and compliant device for Copilot pilot
   ```

   Under **Assignments** > **Users or workload identities** > **Include**, select the pilot group holding your test user. Under **Exclude**, select **Users and groups** and add your emergency access accounts, and if you run Microsoft Entra Connect or Cloud Sync also select **Directory roles** > **Directory Synchronization Accounts**. Expected result: the **Users or workload identities** section collapses to a summary naming your pilot group under **Include** and your emergency access accounts under **Exclude**, and the **Create** button is no longer greyed out (Conditional Access refuses to save a policy with no excluded account).

4. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')** and add no exclusions. Under **Access controls** > **Grant**, select **Grant access**, tick both **Require multifactor authentication** and **Require device to be marked as compliant**, leave the multiple-controls option on **Require all the selected controls**, and select **Select**. Set **Enable policy** to **Report-only** and select **Create**. Expected result: the policy is listed on the Policies blade with state **Report-only**, and no user sees any change yet.

5. On the same **Policies** blade select **What If** from the toolbar, enter the test user, set **Target resources** by App ID (the picker note is explicit that app groupings such as **Office 365** do not produce a match), set **Device platform** to **Windows** and **Client app** to **Browser**, then run the evaluation. Expected result: the report lists `CA05` under the policies that would apply, together with the grant controls **Require multifactor authentication** and **Require device to be marked as compliant** that must be satisfied.

6. Have the test user sign in to Microsoft 365 Copilot Chat on the enrolled device and ask a grounded prompt such as:

   ```text
   Summarize the documents I worked on last week and list who else has access to them.
   ```

   Then go to **Entra ID** > **Monitoring & health** > [**Sign-in logs**](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/SignInEventsV3), open that sign-in, and select the **Report-only** tab. Expected result: Copilot returns a grounded answer with SharePoint or OneDrive citations, and the `CA05` row on the **Report-only** tab reads **Report-only: Success**.

7. Repeat the identical prompt as the same user on the unenrolled device, then open that sign-in event's **Report-only** tab. Expected result: Copilot still answers (the policy is not enforced yet) but the `CA05` row reads **Report-only: Failure**, which is the evidence that enforcement would have blocked it. Verify your own administrator device is compliant before continuing, because the next step can lock you out.

8. Reopen `CA05`, move **Enable policy** from **Report-only** to **On**, save, and have the user retry the prompt on both devices. Expected result: the compliant device returns the grounded answer, the non-compliant device shows the Conditional Access block page reading "You can't get there from here" with a **More details** link, and in **Sign-in logs** the two events now show the `CA05` row on the **Conditional Access** tab as **Success** and **Failure** respectively.

## Talking points

Step 4 is the moment the lesson lands. Nobody typed the word Copilot into this policy, and yet Copilot is now behind MFA and device compliance. That is the practical meaning of "Copilot inherits the platform's security model": the fastest Copilot hardening available is a control that was never Copilot-specific.

Step 7 is where report-only earns its keep. The class gets to see a **Failure** verdict with nobody actually locked out, on a real sign-in rather than a simulation. Contrast it with step 5: the What If tool is a simulation and, by Microsoft's own warning, does not evaluate Conditional Access service dependencies, so a Teams-scoped test will not account for the Exchange Online policy that Teams depends on. Report-only sees the real token requests; What If sees the ones you described.

Step 8 is worth slowing down for the block page itself. The user is not told "Copilot is unavailable", they are told they cannot get there from this device, which is the correct message and a very different helpdesk call. Ask the room what the sign-in log would show if you had only ticked **Require multifactor authentication**: the same user on the same unmanaged laptop would sail through, because a password plus a phone prompt says nothing about the machine.

## Variation

Run the device half from the Intune console instead. Break compliance on the enrolled device rather than switching machines: turn BitLocker off, or in Intune tighten `ZT-Compliance-Windows-Baseline` by adding **Microsoft Defender for Endpoint** > **Require the device to be at or under the machine-risk score** set to **Medium**, then wait for the device to re-evaluate and flip to **Not compliant** in **Devices** > **All devices**. The same user, on the same physical machine, with the same Conditional Access policy untouched, now gets the block page. It teaches the same lesson from the other end: compliance is a live signal, not a one-time enrollment stamp, and access follows it in both directions.
