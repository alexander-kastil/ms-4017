# Hands-On Demo: Cap Copilot credit spend with a targeted spending policy

Goal: show that metered Copilot spend is governed by spending policies whose precedence rule is the opposite of what most administrators assume, and that the new Cost management page does not yet cover every pay-as-you-go service.

Budget 20 minutes. You need a Global Administrator, Billing Administrator or AI Administrator, an Azure subscription available to the tenant, and a security group holding two or three pilot users.

## Steps

1. Sign in to the [Microsoft 365 admin center](https://admin.cloud.microsoft/) and open **Copilot** > [**Cost management**](https://admin.cloud.microsoft/#/copilot/costmanagement/overview). Expected result: the page opens on the **Overview** tab with four cards, **Total Copilot Credits used**, **Prepaid capacity pack credits used**, **Pay-as-you-go credits used** and **Active users of Copilot Credits**, each showing a month-to-date figure.

2. Read the banner at the top of the page out loud. Expected result: it states that Cost management applies to **Copilot Cowork** and **Work IQ API** right now, and directs you to **classic Billing & usage** for other pay-as-you-go services. This is the fact that decides where the rest of your billing work happens today.

3. Scroll to the **Monitor** section and open **Groups spending the most credits (month to date)**. Expected result: a table of groups with a Credits column and a **Manage group spending** button. In a tenant with no targeted policies, the only row is the default all-users policy.

4. Switch to the **Configuration** tab. Expected result: an existing **All Users Policy** row appears with columns Policy name, Status, Applies to, Agents and services, Policy limit, User limit and Billing method. Note the on-page precedence rule above the table before continuing.

5. Ask the room which policy wins when a user is in both an all-users policy with a low limit and a targeted policy with a higher limit. Expected result: most of the room answers "the lower limit". The page states the opposite: the most targeted policy takes precedence, so the higher budget applies.

6. Select **Add spending policy** and create a policy scoped to your pilot group, with a credit limit lower than the all-users policy. Expected result: the new policy appears in the table with Status **Active**, Applies to naming your group, and its own Policy limit, sitting alongside the untouched **All Users Policy**.

7. Open the **Consumption** tab. Expected result: consumption is broken out so you can attribute credits to a policy and a service, which is the evidence a finance owner asks for when the invoice arrives.

8. Follow the **classic Billing & usage** link from the banner and locate the pay-as-you-go services that are not yet in Cost management. Expected result: the classic experience opens and shows the billing policies for the other metered services, confirming that two surfaces are in play during the transition.

9. Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) and go to **Licensing** > **Copilot Studio** > **Manage billing plans**. Expected result: Copilot Studio billing is configured here, on a different meter and in a different console, which is the trap when a customer says "we already set up pay-as-you-go".

## Talking points

Step 5 is the moment worth pausing on. The precedence rule is written on the page and is still the most commonly misread control in Copilot billing, because administrators reason about spending limits as ceilings that stack rather than as the most specific policy winning outright.

Step 2 matters more than it looks. A demo built on the assumption that Cost management governs all metered Copilot services will not match a customer tenant, because most services are still administered from classic Billing & usage while Microsoft migrates them.

Step 9 closes the loop that catches teams a quarter later. Microsoft 365 Copilot metering and Copilot Studio metering are separate systems with separate budgets, separate consoles and separate owners, and neither one tells you about the other.

## Variation

If the tenant has prepaid capacity, open the **Buy prepaid credits** flow on the Configuration tab instead of creating a policy, and read the prepurchase panel: annual prepurchase unlocks a discounted rate against standard pay-as-you-go pricing, and overage still falls back to pay-as-you-go automatically. Do not complete the purchase. The point is that the discount changes the arithmetic in a budget conversation, not the governance model.
