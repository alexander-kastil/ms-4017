# Hands-On Demo: Meter a Copilot Chat agent

Goal: prove that a tenant-grounded agent in Microsoft 365 Copilot Chat is gated by a billing arrangement rather than by a feature switch, by making the same agent work for a user inside a billing policy's scope and stay blocked for a user outside it.

Budget 15 minutes. You need an account holding **AI Administrator** plus **Billing Administrator** (Global Administrator also works but is more than required), **Owner** or **Contributor** on an Azure subscription and resource group in the same tenant as Microsoft 365, and two test users without a Microsoft 365 Copilot license: one in a pilot security group, one outside it.

## Steps

1. Sign in as the pilot user and open [Microsoft 365 Copilot Chat](https://m365copilot.com/). Open the agent side panel and start the **Learning Coach** agent, then submit the prompt `What can you do?`. Expected result: the agent does not respond with an answer, it refuses or reports that it is unavailable, because metered agents are off by default for unlicensed Copilot Chat users.

2. As administrator, go to the [Microsoft 365 admin center](https://admin.cloud.microsoft/) and open **Copilot** > [**Billing & usage**](https://go.microsoft.com/fwlink/p/?linkid=2330674). On the **Billing policies** tab, select **Add a billing policy** and name it `MS4017-Pilot-Chat-Agents`. Select an existing Azure subscription and resource group, or select **Create a new subscription** and supply a subscription name, a resource group name, and a **Region**. Expected result: the wizard advances to the user assignment step with the chosen subscription and resource group shown as the billing target.

3. Still in the wizard, on the user assignment step add only the pilot security group (for example `MS4017-Copilot-Pilot`), then on the budget step set a budget amount such as `100` and select notification milestones. On **Review and finish**, select **Create policy**. Expected result: the policy is listed on the **Billing policies** tab with the pilot group as its scope and the budget shown, and the page states that the budget triggers email notifications but does not stop usage.

4. On the same page open the **Pay-as-you-go services** tab and select **Microsoft 365 Copilot Chat**. In the **Manage billing policy connections** side panel, find `MS4017-Pilot-Chat-Agents`, set its **Connection status** toggle to **Connected**, and select **Save**. Expected result: the **Microsoft 365 Copilot Chat** row lists `MS4017-Pilot-Chat-Agents` with a **Connected** status, replacing the empty billing policy column it showed before.

5. Open the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) and go to **Licensing** > [**Copilot Studio**](https://go.microsoft.com/fwlink/p/?linkid=2330570), then the **Environments** tab. Expected result: the environment picker offers an environment named **Microsoft 365 Copilot Chat**, and selecting it opens a **Copilot credits capacity** tab with a **Copilot credit consumption details** grid. The system provisions that environment when Copilot Chat billing is configured; nobody creates it by hand.

6. Return to the pilot user's session in [Microsoft 365 Copilot Chat](https://m365copilot.com/), refresh, and re-run the exact prompt from step 1: `What can you do?` against **Learning Coach**. Expected result: the agent now answers normally. Nothing about the agent, its instructions, or the user's licenses changed between step 1 and now; only the billing connection did.

7. Sign in as the second test user, the one outside the pilot group, and repeat the same agent and prompt. Expected result: the agent is still unavailable for this user, which demonstrates that the billing policy scope, not a per-agent setting, is the access boundary.

8. As administrator, go to **Reports** > [**Usage**](https://go.microsoft.com/fwlink/p/?linkid=2074756), select **Microsoft 365 Copilot**, then **Credits**. Expected result: once the report refreshes, **Total credits used** is no longer zero and the per-agent and per-user breakdowns list **Learning Coach** against the pilot user at roughly 12 credits, attributed to the `MS4017-Pilot-Chat-Agents` policy. The out-of-scope user appears nowhere in the report. Usernames, display names, and the billing policy ID are anonymized by default, so expect masked identifiers rather than the real account names.

## Talking points

Steps 1 and 6 are the pair the room should remember. The agent was never disabled and no policy was toggled; the only change was that an Azure subscription became reachable for the meter. Access to tenant-grounded agents in Copilot Chat is an accounting state, which is a very different mental model from the app-enablement controls people arrive with.

Step 3 is the moment to be blunt about the budget. It sends email at milestones and nothing else: usage continues uninterrupted after the amount is passed, by design, so that a finance threshold never breaks a business process. If the class wants a real ceiling, point at per-agent monthly consumption limits under **Manage Agents** in the Power Platform admin center, and at the 125 percent prepaid enforcement that disables custom agents outright with the message `This agent is currently unavailable. It has reached its usage limit.`

Step 8 is worth dwelling on because of what it excludes. The Copilot Credits report counts only users who do not hold a Microsoft 365 Copilot license, since licensed users consume agents at no extra charge. That makes the report a measure of unlicensed demand, and a very good input to the licence-versus-meter argument, but a poor measure of total agent adoption.

## Variation

Run the same lesson from the prepaid side and skip Azure entirely. Buy one Microsoft Copilot Studio capacity pack (25,000 Copilot Credits per month) from **Marketplace** in the [Microsoft 365 admin center](https://admin.cloud.microsoft/), then under **Copilot** > [**Billing & usage**](https://go.microsoft.com/fwlink/p/?linkid=2330674) > **Pay-as-you-go services** > **Microsoft 365 Copilot Chat**, select **Create a Copilot credit policy**, name it `MS4017-Pilot-Credits`, and scope it to the same pilot group. Allocate the credits to the **Microsoft 365 Copilot Chat** environment in the Power Platform admin center and repeat steps 6 to 8. The user experience is identical, the tenant limit is 10 credit policies rather than 50 billing policies, no Azure subscription is involved, and the failure mode inverts: when the prepaid pool empties, Copilot Chat goes dark for that scope until the next monthly replenishment unless you also pair a pay-as-you-go policy for overage.
