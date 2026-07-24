# Hands-On Demo: Cap Copilot credit spend with a targeted spending policy

Goal: govern metered Copilot spend with a targeted spending policy, and show that the most targeted policy wins (not the lowest limit) and that Cost management does not yet cover every pay-as-you-go service.

[Manage Copilot Credit spending](https://learn.microsoft.com/en-us/copilot/microsoft-365/manage-copilot-credits)

## Steps

1. In the Microsoft 365 admin center open **Copilot** > [**Cost management**](https://admin.cloud.microsoft/#/copilot/costmanagement/overview). Expected: the **Overview** tab shows month-to-date credit cards.

2. Read the top banner. Expected: it states Cost management applies to **Copilot Cowork** and **Work IQ API**, and points to **classic Billing & usage** for other pay-as-you-go services.

3. Switch to the **Configuration** tab. Expected: an **All Users Policy** row appears with the on-page precedence rule above the table (most targeted policy wins).

4. Select **Add spending policy** and scope one to your pilot group with a credit limit lower than the all-users policy. Expected: the new policy appears with Status **Active**, alongside the untouched **All Users Policy**.

5. Open the **Consumption** tab. Expected: consumption is broken out by policy and service.

6. Follow the **classic Billing & usage** link from the banner. Expected: the classic experience shows the billing policies for the metered services not yet in Cost management.

7. In the Power Platform admin center open [**Licensing** > **Copilot Studio** > **Manage billing plans**](https://admin.powerplatform.microsoft.com/). Expected: Copilot Studio billing lives here, on a separate meter in a different console.
