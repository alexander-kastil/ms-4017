# Hands-On Demo: Triage the Agent 365 registry

Goal: inspect the unified agent inventory, isolate ownerless and at-risk agents, and remediate one.

Prerequisite: a licensed tenant with Microsoft Agent 365 and the AI Administrator or Global Administrator role. Microsoft Agent 365 is generally available; registry-sync discovery of non-Microsoft platforms is still preview.

[Manage the agent registry in the Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-registry)

[Agent actions an admin can take](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-actions)

## Steps

1. As admin, open the Microsoft 365 admin center and select [**Agents**](https://admin.cloud.microsoft/#/agents) > **All agents** > **Registry**. Expected: the inventory lists Microsoft, external partner-built, published-by-your-org, and shared agents.

2. Read the summary tiles: **Total agents**, **Agents without owners**, and **Unmanaged agents** (agents created outside Agent 365, without its risk protection and observability). Expected: each tile shows a count.

3. Use the **Platform** filter to reveal discovered non-Microsoft agents surfaced by registry sync (for example, platforms such as Manus or Genspark). Expected: the list narrows to non-Microsoft entries.

4. Select the **Agents without owners** tile. Expected: the list filters to shared agents whose creator left the organization.

5. Select the **Agents at risk** tile, then read the **Risks** column. Expected: the view prefilters to high-severity risks, including **Shadow agent** entries that have no registry entry, no owner, or no Microsoft Entra Agent ID.

6. Open one ownerless or at-risk agent and choose **Block** under the agent name, confirm, then **Save**. Expected: the agent is blocked tenant-wide.

7. On an Agent Builder or Copilot Studio agent, select **Assign new owner**, enter a user, and select **Assign**. Expected: ownership transfers and the ownerless count updates.
