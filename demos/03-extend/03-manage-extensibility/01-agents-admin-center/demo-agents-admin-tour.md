# Hands-On Demo: Tour the Agents workload in the admin center

Goal: read the Agents Overview, work the Registry and Requests queue, and take a lifecycle action on a single agent.

Prerequisite: a licensed tenant with the Agents workload (Microsoft 365 Copilot or Microsoft Agent 365) and the AI Administrator or Global Administrator role. Microsoft Agent 365 is generally available; some registry-sync and runtime-protection capabilities are still preview.

[Manage agents in the Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-365-overview)

[Agent actions an admin can take](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-actions)

## Steps

1. As admin, open the Microsoft 365 admin center and select [**Agents**](https://admin.cloud.microsoft/#/agents) > **Overview**. Expected: the Overview dashboard renders.

2. Read the three hero metrics: **Agent registry** (total agents in the catalog), **Active users** (unique users in the last 30 days), and **Agent run-time** (total agent hours in the last 30 days). Expected: each tile shows a count for your tenant.

3. Select **Explore All agents** > **Registry**. Expected: the full agent inventory lists with **Total agents**, **Agents without owners**, and **Unmanaged agents** summary tiles.

4. Select **All agents** > **Requests**. Expected: the tab lists Copilot Studio agent requests awaiting admin approval, newest first.

5. Open one pending request and select **Publish to store** to approve it, or **Reject submission** to deny it. Expected: the request clears from the queue and the agent status updates.

6. Back in **Registry**, select any agent to open its details pane and choose **Block** or **Unblock** under the agent name, then confirm in the pane and select **Save**. Expected: the agent's availability changes tenant-wide.

7. On an Agent Builder or Copilot Studio agent, select **Assign new owner**, enter a user, and select **Assign**. Expected: the new owner gets full edit and delete rights; the previous owner loses access.
