# Hands-On Demo: Ground Copilot in outside content with a gallery connector

Goal: show that grounding Copilot in content outside Microsoft 365 does not require writing a connector, and make the difference between a synced connector and a federated one visible in the connection list rather than on a slide.

Budget 20 minutes. You need a Global Administrator or Search Administrator, and one licensed Copilot user for the verification step.

## Steps

1. As the licensed user, ask Microsoft 365 Copilot a question that only the external source can answer. Expected result: Copilot cannot answer it from tenant content, which establishes the baseline the connector is about to change. Keep the response on screen.

2. Sign in to the [Microsoft 365 admin center](https://admin.cloud.microsoft/) and open **Copilot** > [**Connectors**](https://admin.cloud.microsoft/#/copilot/connectors). Expected result: the **Connectors** page opens with two tabs, **Gallery** and **Your Connections**, above the line "Connect your organization's data to improve insights and information provided by Copilot, agents, and Microsoft Search."

3. Open **Your Connections**. Expected result: a table with Connection name, Display name and State columns, an **Add Connection** command, a **Refresh** command, a **Choose columns** command, a **Search** box, and three filters: **Connection state**, **Type** and **Connector**.

4. Read the **State** column across the existing rows. Expected result: connections show states such as **Ready** and **Admin Preview**. Explain the difference before deploying anything: a connector in Admin Preview is visible to administrators only and will not appear in user-facing Copilot answers.

5. Apply the **Type** filter. Expected result: the filter separates connection types, which is where the synced versus federated distinction becomes concrete. A synced connector ingests and indexes content into Microsoft Graph; a federated connector fetches at query time and stores nothing.

6. Switch to the **Gallery** tab and browse the available connectors. Expected result: a catalog of Microsoft and partner connectors. Say the number out loud: the gallery holds over 100, so the first design question for any customer is whether a build is needed at all.

7. Pick a connector that needs no external account, select it, and walk the configuration without completing it. Expected result: the wizard asks for a connection name and identifier, a source and authentication method, and the users or groups who may see the content. Stop before the final step unless you intend to leave the connection in the tenant.

8. Complete the deployment for a connector you do want, then return to **Your Connections** and watch the **State** column. Expected result: the connection moves toward **Ready**. Point out that a synced connector is not usable the moment it is created; it has to crawl first, and the wait is real.

9. Once the state reads **Ready**, repeat the prompt from step 1 as the licensed user. Expected result: Copilot now answers and cites the external content. For a synced connector the citation previews inline; for a federated connector the citation points back to the source system with nothing stored in Microsoft Graph.

## Talking points

Step 5 carries the design decision for the whole topic. Federated connectors are the answer when a compliance team refuses to let content be copied into Microsoft Graph at all, and the price is that there is no semantic index, so retrieval quality depends entirely on what the source's tools return.

Step 8 is the expectation to set before a customer pilot. Teams deploy a connector, ask a question ten seconds later, get nothing, and conclude the connector is broken. It is crawling.

Step 6 is the commercial point. Most connector projects that reach a developer should have stopped at the gallery. Check it before scoping a custom build, and reserve custom work for line-of-business systems nobody else has covered.

Grounding quality is not automatic even after the state reads Ready. Semantic labels that match the schema, content-rich text in the content property, a resolver so shared URLs resolve, and user activity signals are what move a connector from "returns something" to "returns the right thing".

## Variation

If the tenant already has connections in the list, skip the deployment entirely and run this as a reading exercise. Filter **Your Connections** by state, open one **Ready** connection and one in **Admin Preview**, and have the class predict which one a user would see cited. Then verify with a prompt. It takes five minutes and changes nothing in the tenant.
