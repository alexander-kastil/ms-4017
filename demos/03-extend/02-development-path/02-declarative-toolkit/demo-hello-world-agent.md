# Hands-On Demo: Provision and run HelloWorldAgent

Goal: open the `HelloWorldAgent` app package in the Microsoft 365 Agents Toolkit, provision it, and run it in Microsoft 365 Copilot.

Prerequisite: a Microsoft 365 Copilot licensed tenant with custom app upload enabled, Visual Studio Code, and Node.js v20. The project `HelloWorldAgent` sits next to this file.

[Tutorial: Create declarative agents by using Microsoft 365 Agents Toolkit](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/build-declarative-agents)

[Declarative agents overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/overview-declarative-agent)

[Microsoft 365 Agents Toolkit for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=TeamsDevApp.ms-teams-vscode-extension)

## Steps

1. In Visual Studio Code, open the `HelloWorldAgent` folder, then open the **Microsoft 365 Agents Toolkit** sidebar and sign in under **Accounts** with your Microsoft 365 developer account. Expected: the account shows a valid Copilot license and sideloading enabled.

2. Review `appPackage/declarativeAgent.json` and `appPackage/instruction.txt` to see the agent name and instructions. Expected: the agent is named `HelloWorldAgent` with instructions loaded from the instruction file.

3. In the toolkit **Lifecycle** pane, select **Provision**. Expected: the toolkit zips the app package, validates it, and registers the agent in your tenant.

4. Open [Microsoft 365 Copilot chat](https://m365.cloud.microsoft/chat), select the conversation drawer icon next to **New Chat**, and choose **HelloWorldAgent**. Expected: the agent opens in the side panel.

5. Send any prompt to the agent. Expected: it replies confirming it was created with the Microsoft 365 Agents Toolkit.
