# Hands-On Demo: Set the update channel and swap security defaults for Conditional Access

Goal: prepare the tenant in two separate consoles, the update channel in Microsoft 365 admin center and the baseline protection swap in Microsoft Entra ID, and show the gap the swap leaves if you stop halfway.

[Set up the standard or targeted release options](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/release-options-in-office-365)
[Security defaults in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/security-defaults)

## Steps

1. In the Microsoft 365 admin center open **Settings** > [**Org settings**](https://admin.cloud.microsoft/#/Settings/Services). Expected: the **Services** tab lists the org services with a **Search all settings** box.

2. Search `installation`, open **Microsoft 365 installation options**, set the channel to **Current Channel (Monthly)** and save. Expected: the channel change is saved; Copilot features ship to Current Channel first.

3. In the Microsoft Entra admin center open [**Entra ID** > **Overview** > **Properties**](https://entra.microsoft.com), then **Manage security defaults**. Expected: a panel shows the current state with **Enabled** / **Disabled (not recommended)**.

4. Set **Security defaults** to **Disabled (not recommended)** and save. Expected: Properties shows security defaults disabled; the tenant now has no baseline protection.

5. Go to **Entra ID** > **Protection** > **Conditional Access** and create the replacement policies, or enable the Microsoft-managed equivalents. Expected: at least one enabled policy requires multifactor authentication for administrators.

6. Return to **Manage security defaults** and try to re-enable it. Expected: Microsoft Entra ID refuses while Conditional Access policies are enabled (the two are mutually exclusive).
