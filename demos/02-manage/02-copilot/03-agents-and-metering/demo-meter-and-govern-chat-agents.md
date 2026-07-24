# Hands-On Demo: Meter a Copilot Chat agent

Goal: prove that a tenant-grounded agent in Microsoft 365 Copilot Chat is gated by a billing arrangement, not a feature switch, by making the same agent work inside a billing policy's scope and stay blocked outside it.

[Set up pay-as-you-go for Microsoft 365 Copilot services](https://learn.microsoft.com/microsoft-365/copilot/pay-as-you-go/setup)
[Microsoft 365 Copilot Credits report](https://learn.microsoft.com/microsoft-365/admin/activity-reports/microsoft-365-copilot-credits)

Prerequisite: **AI Administrator** plus **Billing Administrator**, **Owner** or **Contributor** on an Azure subscription in the same tenant, and two users without a Microsoft 365 Copilot license (one in a pilot group, one outside).

## Steps

1. Sign in as the pilot user at [Microsoft 365 Copilot Chat](https://m365copilot.com), start the **Learning Coach** agent, and submit `What can you do?`. Expected: the agent refuses or reports unavailable (metered agents are off by default for unlicensed users).

2. As admin, in the [Microsoft 365 admin center](https://admin.cloud.microsoft) open **Copilot** > [**Billing & usage**](https://go.microsoft.com/fwlink/p/?linkid=2330674). On **Billing policies**, select **Add a billing policy**, name it `MS4017-Pilot-Chat-Agents`, and select or create an Azure subscription, resource group, and region. Expected: the wizard advances to user assignment showing the billing target.

3. On the assignment step add only the pilot security group (for example `MS4017-Copilot-Pilot`), set a budget such as `100` with notification milestones, then **Create policy**. Expected: the policy is listed with the pilot group as scope and the budget shown (budget notifies only, it does not stop usage).

4. Open the **Pay-as-you-go services** tab, select **Microsoft 365 Copilot Chat**, find `MS4017-Pilot-Chat-Agents`, set **Connection status** to **Connected**, and **Save**. Expected: the Microsoft 365 Copilot Chat row lists the policy as Connected.

5. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com), open **Licensing** > [**Copilot Studio**](https://go.microsoft.com/fwlink/p/?linkid=2330570) > **Environments**. Expected: an auto-provisioned **Microsoft 365 Copilot Chat** environment exists, and selecting it opens the **Copilot credits capacity** tab with a consumption grid.

6. Back in the pilot user's [Microsoft 365 Copilot Chat](https://m365copilot.com) session, refresh and re-run `What can you do?` against **Learning Coach**. Expected: the agent now answers; only the billing connection changed.

7. Sign in as the second test user (outside the pilot group) and repeat the same agent and prompt. Expected: the agent is still unavailable, showing the billing policy scope is the access boundary.

8. As admin, open **Reports** > [**Usage**](https://go.microsoft.com/fwlink/p/?linkid=2074756), select **Microsoft 365 Copilot**, then **Credits**. Expected: Total credits used is non-zero and lists **Learning Coach** against the pilot user at roughly 12 credits; the out-of-scope user appears nowhere (identifiers are masked by default).
