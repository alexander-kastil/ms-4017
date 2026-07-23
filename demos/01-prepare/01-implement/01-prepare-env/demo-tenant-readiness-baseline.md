# Hands-On Demo: Set the update channel and swap security defaults for Conditional Access

Goal: show that "preparing the tenant" is two unrelated jobs in two different consoles, and that the second one leaves the tenant briefly unprotected if you stop halfway.

Budget 20 minutes. You need a Global Administrator or Office Apps Administrator for the first half, a Conditional Access Administrator for the second half, and Microsoft Entra ID P1 in the tenant. Do this in a demo tenant, never in production.

## Steps

1. Sign in to the [Microsoft 365 admin center](https://admin.cloud.microsoft/) and open **Settings** > [**Org settings**](https://admin.cloud.microsoft/#/Settings/Services). Expected result: the **Org settings** page opens on the **Services** tab, showing an alphabetical list of roughly 40 services with a Name and Description column, plus a **Search all settings** box on the right.

2. Type `installation` into **Search all settings**, then open **Microsoft 365 installation options**. Expected result: the entry is described as "Choose how often users get feature updates and the Microsoft 365 apps that users can install", and a panel opens showing the current update channel.

3. Set the channel to **Current Channel (Monthly)** and save. Expected result: the panel closes and the Org settings list shows the change. Point out that Copilot features ship to Current Channel first, so a tenant on Semi-Annual Enterprise Channel will be missing features the class is about to demonstrate.

4. Open the [Microsoft Entra admin center](https://entra.microsoft.com) as a Conditional Access Administrator and go to **Entra ID** > **Overview** > **Properties**, then select **Manage security defaults** at the bottom. Expected result: a panel opens with the current state of security defaults and a dropdown offering **Enabled** and **Disabled (not recommended)**.

5. Before changing anything, ask the room what protection is about to be removed. Expected result: the class should name the four behaviors security defaults enforce, which are blocking legacy authentication, requiring multifactor authentication for Azure management, for administrators, and for all users. If nobody can name them, that is the point of the next step.

6. Set **Security defaults** to **Disabled (not recommended)** and save. Expected result: the panel confirms the change, and the Properties page shows security defaults as disabled. The tenant is now running with no baseline protection at all.

7. Go straight to **Entra ID** > **Protection** > **Conditional Access** and create the replacement policies, or enable the Microsoft-managed equivalents. Expected result: at least one enabled policy exists that requires multifactor authentication for administrators. Do not end the demo before this step completes.

8. Return to **Manage security defaults** and attempt to re-enable it. Expected result: Microsoft Entra ID refuses while Conditional Access policies are enabled, which demonstrates that the two are mutually exclusive rather than layered.

## Talking points

Step 3 looks like housekeeping and is the single most common cause of "Copilot does not have that feature in my tenant". The channel decides which build the Microsoft 365 apps run, and Copilot capability lands per build.

Steps 6 and 7 are deliberately uncomfortable. There is a real window between disabling security defaults and enabling Conditional Access where the tenant has neither, and in a customer engagement that window is measured in whatever time the change ticket takes to approve. Plan the replacement policies before you touch the toggle.

Two recent changes break demo tenants and are worth stating out loud. Security defaults now block device code flow, enforced for all new tenants created from July 1, 2026, so CLI and agent development sign-ins fail while security defaults are on. And the 14-day multifactor authentication registration grace period was removed on July 29, 2024; new tenants get 24 hours at creation only.

## Variation

If the tenant already runs Conditional Access, invert the demo. Open **Manage security defaults** first and show that it is already unavailable, then walk the existing policy list and map each policy back to the security-defaults behavior it replaced. This version makes the same point in five minutes and changes nothing.
