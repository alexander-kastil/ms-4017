# Work with external data

Microsoft 365 Copilot grounds its responses in the **Microsoft Graph** (your mail, files, chats, and SharePoint content). Data that lives *outside* Microsoft 365, for example in ServiceNow, Salesforce, Confluence, or a file share, isn't visible to Copilot by default. **Microsoft 365 Copilot connectors** (formerly Microsoft Graph connectors) bring that external content into the Graph so it becomes discoverable in Copilot and Microsoft Search, while honoring the source system's permissions.

[Microsoft 365 Copilot connectors overview](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/overview-copilot-connector)

[Copilot connectors overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/overview)

## Connector types

- **Synced (indexed) connectors** - crawl and index external content into Microsoft Graph on a schedule. The indexed items are ranked and returned in Copilot and Microsoft Search. Best when you want the content fully searchable and reasoned over.
- **Federated connectors** - read-only; they search and fetch results from the external system at query time without indexing (no copy is stored in the Graph). Some are provided by Microsoft and appear as **Ready** in your connections list.

## Prebuilt connectors

Microsoft and its partners ship **100+ prebuilt connectors** (Azure services, Box, Confluence, Google, MediaWiki, Salesforce, ServiceNow, and many more). For a prebuilt connector you select it, provide credentials and configuration, and the Microsoft connector service handles crawling, indexing, and refresh.

[Connectors gallery](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/connectors-gallery)

## Set up a connector

You need the **AI Administrator** (or Global Administrator) role.

- Sign in to the [**Microsoft 365 admin center**](https://admin.microsoft.com) and go to **Copilot** > **Connectors**
- Choose a connector from the gallery, then provide the source URL, authentication, and the content to index
- Configure the **search schema** (which properties are searchable / retrievable / queryable), **access permissions** (map source ACLs so results respect who can see what), and the **refresh schedule**

[Deploy connectors in the Microsoft 365 admin center](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/deployment-overview)

## Build a custom connector

When no prebuilt connector fits, build your own against the **Microsoft Graph connectors API** (create the connection, register the schema, and push external items with their ACLs), or surface an external system through a **connector/agent in Copilot Studio**.

[Microsoft 365 Copilot connector experiences](https://learn.microsoft.com/en-us/graph/connecting-external-content-experiences)

[Microsoft Graph connectors (Graph API)](https://learn.microsoft.com/en-us/graph/connecting-external-content-connectors-api-overview)
