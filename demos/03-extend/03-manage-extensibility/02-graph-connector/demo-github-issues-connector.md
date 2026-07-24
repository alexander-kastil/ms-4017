# Hands-On Demo: Ingest GitHub issues with a Copilot connector

Goal: provision and run the GitHub Issues connector, ingest external items, and prove they surface in Microsoft 365 Copilot.

Prerequisite: a Microsoft 365 developer tenant with custom app upload enabled, the Microsoft 365 Agents Toolkit and Azure Functions extensions in VS Code, Node 18/20/22, and rights to grant tenant-wide admin consent. The runnable project is in `Github Issues`, next to this readme.

[Build your first custom Copilot connector using Microsoft 365 Agents Toolkit](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/build-your-first-connector)

[Copilot connectors deployment overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/deployment-overview)

## Steps

1. Open the `Github Issues` folder in VS Code and set the repositories to crawl in `env/.env.local` by updating `CONNECTOR_REPOS`. Expected: the value names one or more public GitHub repos.

2. Press <kbd>F5</kbd> to start the Agents Toolkit local run and follow the sign-in prompts. Expected: the toolkit provisions the connection and the Azure Functions host starts locally.

```text
Press F5 (Run and Debug) with the Microsoft 365 Agents Toolkit profile
```

3. When the console prints the admin-consent link, open it and grant tenant-wide admin consent. Expected: the connector app's permissions are consented.

4. Wait for the toolkit tasks to finish, so the schema is registered and the full crawl ingests items. Expected: the run completes without errors.

5. In the Microsoft 365 admin center, open [**Search & intelligence** > **Connectors**](https://admin.microsoft.com/#/MicrosoftSearch/Connectors) and find the **GitHub Issues** connection. In the **Required actions** column, select **Include Connector Results** and confirm. Expected: connector content is enabled for search and Copilot.

6. Open [Microsoft 365 Copilot](https://m365.cloud.microsoft/chat) and prompt: `Summarize the latest GitHub issues`. Expected: Copilot returns ingested issues with connector citations. Allow a few minutes for indexing, and turn off web results for cleaner isolation.

7. Back in **Search & intelligence** > **Connectors**, open the **GitHub Issues** connection to manage how its content displays (result types and availability). Expected: display settings save and apply to search and Copilot.
