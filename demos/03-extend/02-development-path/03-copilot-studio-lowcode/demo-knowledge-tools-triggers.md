# Hands-On Demo: Add knowledge, a tool, and a trigger

Goal: in the full Copilot Studio canvas, extend an agent with a knowledge source, a tool, and an autonomous event trigger.

Prerequisite: a tenant with a Copilot Studio license and permission to create agents.

[What is Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio)

[Knowledge sources overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/agents-experience/knowledge-sources-overview)

[Add tools and connectors to an agent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-connectors)

[About triggers (autonomous event triggers)](https://learn.microsoft.com/en-us/microsoft-copilot-studio/authoring-triggers-about)

## Steps

1. In [Copilot Studio](https://copilotstudio.microsoft.com), open **Agents** and either select an existing agent or **Create** a new blank agent. Expected: the agent authoring canvas opens with the **Overview** tab.

2. On the **Knowledge** tab, select **Add knowledge** and connect a source (a public website, a SharePoint site, or an uploaded file). Expected: the source is listed and shows a ready or indexing status.

3. On the **Tools** tab, select **Add a tool** and choose a connector or prebuilt action, then complete its connection. Expected: the tool appears in the agent's tool list and can be invoked from the test panel.

4. On the **Triggers** tab, select **Add a trigger**, choose an event source (for example a new email or a record change), and bind it to the action the agent should run. Expected: the autonomous event trigger is listed and enabled.

5. Open **Test your agent** and exercise a request that uses the knowledge source and the tool. Expected: the agent answers from the knowledge source and the tool runs; the trigger fires when its event occurs.
