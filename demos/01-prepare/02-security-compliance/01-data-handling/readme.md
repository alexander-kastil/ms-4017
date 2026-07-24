# How Copilot handles your data

[Data, Privacy, and Security for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-privacy)

[Data, privacy, and security for web queries](https://learn.microsoft.com/en-us/microsoft-365-copilot/manage-public-web-access)

Hands-On Demo: [Trace the compliance boundary](demo-compliance-boundary.md)

## The orchestration engine

Copilot sits between a large language model, the content in Microsoft Graph that the signed-in user may access, and the Microsoft 365 apps the user works in. A prompt is combined with grounding data retrieved through Graph and with working context, such as the meeting the user is in now, the mail exchanges on a topic, or last week's chat conversations. That combination is what makes a response specific to the organization rather than generic.

The retrieval step is the one that matters for security. Copilot only surfaces organizational data to which the individual user has **at least View permissions**, and it evaluates those permissions per request, per user. It does not search other tenants where the user is a B2B guest, and it does not search tenants reachable through cross-tenant access or cross-tenant sync.

## The four guarantees

State these verbatim to a customer, because they are the four that get asked. Prompts, responses, and data accessed through Microsoft Graph:

- Are NOT available to other customers.
- Are NOT used to train foundation LLMs, including the ones Copilot itself uses.
- Are NOT used to train or improve Microsoft AI models, unless the tenant administrator opts in to sharing data with Microsoft.
- Are NOT used to train or improve any non-Microsoft product or service.

Copilot does not call OpenAI's public consumer services. All inference runs on Azure OpenAI Service instances operated by Microsoft, and Microsoft 365 Copilot has opted out of the Azure OpenAI abuse monitoring that would otherwise involve human review of content. Microsoft also offers third-party models from Anthropic and OpenAI as subprocessors inside Copilot experiences, which the administrator opts into and which carry additional terms.

Customer feedback is the one optional data flow. It is used to improve Copilot the same way feedback improves other Microsoft 365 services, it is never used to train the foundation LLMs, and administrators can turn it off.

## The compliance boundary

Prompt, retrieved grounding data, and generated response all stay inside the Microsoft 365 service boundary. The important exception is deliberate: an administrator can allow data out of that boundary, most commonly by leaving web search enabled, which sends a Copilot-generated search query to the Bing Search service.

Treat "is web search on?" as a compliance question, not a feature question. It is the single setting that changes the answer to "does any of our content leave the boundary?", and it is controlled both by a dedicated admin control and by the Microsoft 365 Apps privacy control for optional connected experiences.

## What is stored about interactions

Every interaction is retained. Microsoft stores the user's prompt and Copilot's response together with citations to the grounding sources, and calls this the content of interactions; the record over time is the user's Copilot activity history. It is encrypted at rest, stored under the same contractual commitments as the organization's other Microsoft 365 content, and not used to train foundation LLMs.

Because it lands in the user's mailbox, the entire Microsoft Purview toolchain applies to it, which is the subject of [03-compliance-governance](../03-compliance-governance/readme.md). Users delete their own activity history from the [My Account portal](https://myaccount.microsoft.com/).

## Data residency

Copilot was added as a covered workload in the Microsoft Product Terms data residency commitments on March 1, 2024. Advanced Data Residency and Multi-Geo include Copilot from that same date. Calls to the LLM are routed to the closest data centers in the region, and can spill into other regions during high utilization.

For EU customers Copilot is an EU Data Boundary service: EU traffic stays inside the boundary, while worldwide traffic may be processed in the EU or other regions. Models supplied by Anthropic as a subprocessor are currently excluded from the EU Data Boundary, which is the detail to raise with an EU customer before they enable them.

## Discussion questions

- Web search is on. Which of the four guarantees still hold, and which commitment changes?
- The customer is in the EU and wants the Anthropic models. What do you tell them about the EU Data Boundary?
- If prompts and responses land in the user's mailbox, what does that imply for a mailbox retention policy that predates Copilot?
