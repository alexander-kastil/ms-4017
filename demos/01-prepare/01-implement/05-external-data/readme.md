# Work with external data

[Microsoft 365 Copilot connectors overview](https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/overview-copilot-connector)

[Copilot connectors gallery](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/connectors-gallery)

[Federated connectors overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/connectors/federated-connectors-overview)

Hands-On Demo: [Ground Copilot in outside content with a gallery connector](demo-gallery-connector.md)

Copilot only reasons over what it can reach. Connectors are how line-of-business content that lives outside Microsoft 365 becomes grounding data, so it can be searched, summarized and cited alongside SharePoint and Exchange content.

## Two connector models

The platform now supports two, and choosing between them is the design decision to make before writing any code.

| | Synced connector | Federated connector (MCP-based) |
|---|---|---|
| Data movement | Content is ingested and indexed into Microsoft Graph | None; content is fetched at query time |
| Semantic indexing | Supported | Not applicable |
| Schema | **externalItem** schema | Defined by the MCP server's tools |
| Authentication | Microsoft Entra ID app registration | MCP-supported methods, OAuth 2.0 or service-specific |
| Retrieval | Indexed search and synthesis | Real-time API calls |
| Best for | Knowledge repositories, document stores, LOB systems | Dynamic data, or regulated content that must stay in the source system |
| Availability | Global, GCC, GCCH, DoD | Varies by connector |

Federated connectors are the answer when a customer's compliance team refuses to let content be copied into Microsoft Graph at all. The trade-off is no semantic index, so retrieval quality depends on what the MCP server's tools return.

## Where the content shows up

Connector content powers Microsoft 365 Copilot and the other Microsoft 365 intelligent experiences, including Microsoft Search, Copilot in Excel, and the Researcher agent. Synced content appears as citations users can preview inline; federated content is cited directly from the source, with nothing stored in Graph.

The gallery holds over 100 Microsoft and partner connectors covering Azure services, Box, Confluence, Google services, MediaWiki, Salesforce, ServiceNow and more. Check it before proposing a custom build.

## Building your own synced connector

An AI administrator registers an application and grants admin consent for the required Microsoft Graph permissions in the Microsoft Entra admin center. Deployed connectors are tenant-wide unless external item security restricts them. There are three build paths:

- Microsoft 365 Agents Toolkit
- The connector SDK
- The Copilot connector APIs

To get good grounding quality, apply semantic labels that match the schema (including `iconUrl`, `title` and `url`), put content-rich text in the **content** property, add a `urlToItemResolver` so shared URLs resolve, and add user activities to improve ranking.

Semantic indexing helps topic and keyword searches, approximate matches, and queries needing contextual interpretation. It does not help queries without topics or keywords ("find bugs assigned to"), multi-parameter queries, or requests for counts.

This course builds a working connector later: see [03-extend/03-manage-extensibility](../../../03-extend/03-manage-extensibility/readme.md).
