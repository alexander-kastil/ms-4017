# Hands-On Demo: Ground Copilot in outside content with a gallery connector

Goal: ground Copilot in content outside Microsoft 365 without building a connector, and make the synced vs federated distinction visible in the connection list.

[Microsoft 365 Copilot connectors overview](https://learn.microsoft.com/en-us/microsoftsearch/connectors-overview)

## Steps

1. As the licensed user, ask Microsoft 365 Copilot a question only the external source can answer. Expected: Copilot cannot answer from tenant content; keep the response on screen as the baseline.

2. In the Microsoft 365 admin center open **Copilot** > [**Connectors**](https://admin.cloud.microsoft/#/copilot/connectors). Expected: the page opens with **Gallery** and **Your Connections** tabs.

3. Open **Your Connections** and read the **State** column. Expected: connections show states such as **Ready** and **Admin Preview** (Admin Preview is admin-visible only and never cited in user answers).

4. Apply the **Type** filter. Expected: the filter separates connection types (synced ingests and indexes into Microsoft Graph; federated fetches at query time and stores nothing).

5. Switch to the **Gallery** tab and browse. Expected: a catalog of over 100 Microsoft and partner connectors, so the first question is whether a build is needed at all.

6. Deploy a connector that needs no external account: give it a name and identifier, a source and authentication method, and the users or groups who may see the content. Expected: the connection appears in **Your Connections** and its **State** moves toward **Ready** (a synced connector must crawl first).

7. Once the state reads **Ready**, repeat the prompt from step 1 as the licensed user. Expected: Copilot answers and cites the external content (synced previews the citation inline; federated points back to the source system).
