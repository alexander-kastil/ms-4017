# Hands-On Demo: Build a prompt agent in Microsoft Foundry

Goal: create and test a prompt agent in the Microsoft Foundry portal, then note the hosted-agent code path.

Needs a Microsoft Foundry project and an Azure subscription, with the Foundry User role on the project.

[Microsoft Foundry Agent Service overview](https://learn.microsoft.com/en-us/azure/foundry/agents/overview)

[Create a prompt agent](https://learn.microsoft.com/en-us/azure/foundry/agents/quickstarts/prompt-agent)

[Hosted agents in Microsoft Foundry](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents)

[Microsoft Agent Framework overview](https://learn.microsoft.com/en-us/agent-framework/overview/)

## Steps

1. Sign in to the [Microsoft Foundry portal](https://ai.azure.com/?cid=learnDocs) and open a project that has a deployed model. Expected: you land in the project with a model available.

2. Create the agent: **Build** > **Agents** > **Create agent**, enter a name, and select your deployed model. Expected: the agent opens in the agents playground.

3. Set the instructions, for example `You are a helpful assistant that answers questions about company travel policy.`. Expected: the instructions are saved on the agent.

4. Add a tool: under **Tools** select **Add**, choose a tool (for example file search over an uploaded document, or an MCP tool), then select **Save**. Expected: the tool appears in the agent configuration.

5. Test in the playground: in the chat pane send a prompt that exercises the tool. Expected: the agent responds and shows the tool call.

6. Note the hosted-agent path: from the playground **Code** tab open the snippet in Visual Studio Code for the Web, build the agent with the Microsoft Agent Framework, and deploy it to Foundry as a [hosted agent](https://learn.microsoft.com/en-us/azure/foundry/agents/concepts/hosted-agents) (container image or source zip). Expected: your own code runs behind a managed Foundry endpoint.
