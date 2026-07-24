# Hands-On Demo: Audit an agent's interactions

Goal: prove every agent prompt, response, and tool call is captured and searchable in Microsoft Purview.

Prerequisite: a licensed tenant with an Agent 365 instance active; the account needs the Compliance Administrator or Microsoft Purview Compliance Administrator role.

[Microsoft Purview for Microsoft Agent 365](https://learn.microsoft.com/en-us/purview/ai-agent-365)

[Agent 365 activities in the Purview audit log](https://learn.microsoft.com/en-us/purview/audit-log-activities)

[Security and governance in the Copilot Control System](https://learn.microsoft.com/en-us/microsoft-365/copilot/copilot-control-system/security-governance)

## Steps

1. As admin, in the [Microsoft Purview portal](https://purview.microsoft.com) open [**Audit**](https://purview.microsoft.com/audit) and start a new search. Expected: the audit search form opens.

2. Filter the **Activities** friendly name to the **Agent 365 activities** category and set a recent date range. Expected: only agent activity types are selectable.

3. Add the agent as a search subject and run the search. Expected: results list human-to-agent, agent-to-tool, and agent-to-agent interactions.

4. Open a result to inspect the captured prompt and response, including any referenced Microsoft 365 files and their sensitivity labels. Expected: the interaction detail shows the recorded content.

5. In the [Microsoft Purview portal](https://purview.microsoft.com) open [**DSPM for AI**](https://purview.microsoft.com/dspm/ai) and select the same agent. Expected: the agent detail shows Entra-enabled status, owner, and its interaction activity with risk levels.
