# Hands-On Demo: Publish a Foundry agent to Teams and Microsoft 365 Copilot

Goal: publish a tested Microsoft Foundry agent to Teams and Microsoft 365 Copilot for yourself, and note the alternative publish paths.

Needs a tested Foundry agent and permission to create an Azure Bot Service resource (the Azure Bot Service Contributor role on the resource group).

[Publish a Microsoft Foundry agent to Teams and Microsoft 365 Copilot](https://learn.microsoft.com/en-us/azure/foundry/agents/how-to/publish-copilot)

[Publish a Copilot Studio agent to the Teams and Microsoft 365 Copilot channel](https://learn.microsoft.com/en-us/microsoft-copilot-studio/publication-add-bot-to-microsoft-teams)

[Publish an agent with the Microsoft Agent 365 CLI](https://learn.microsoft.com/en-us/microsoft-agent-365/developer/publish)

[Distribute a custom agent to Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/publish)

## Steps

1. In the [Microsoft Foundry portal](https://ai.azure.com/?cid=learnDocs) open your tested agent, select **Publish**, and next to **Active version** choose `Always use latest` or a specific version. Expected: the version consumers will receive is set.

2. Select **Publish** > **Teams and Microsoft 365 Copilot**. Expected: the Publish to Teams and Microsoft 365 dialog opens and an Azure Bot Service resource is created or shown as read-only.

3. Complete the metadata (**Name**, **Publish version**, **Short description**, **Description**, **Developer**), then select **Next: Publish options**. Expected: the Publish options step appears.

4. On the **Direct publish** tab, under **Choose who can use this agent** select **Just you**, then select **Publish**. Expected: a Publish successful dialog appears and the agent shows under **Your agents** in the Microsoft 365 Copilot agent store, available immediately with no admin approval.

5. Alternative, Copilot Studio channel: publish the agent, then open **Channels** > **Teams and Microsoft 365 Copilot**, keep **Make agent available in Microsoft 365 Copilot** selected, and select **Add channel**. Expected: the agent becomes available in Teams and Microsoft 365 Copilot.

6. Alternative, Agent 365 CLI: package the agent, then upload the manifest in the admin center.

   ```powershell
   a365 publish
   ```

   In the [Microsoft 365 admin center](https://admin.microsoft.com) go to **Agents** > **All agents** > **Upload custom agent** and upload `manifest.zip`. Expected: after 5 to 10 minutes the agent appears under All agents.
