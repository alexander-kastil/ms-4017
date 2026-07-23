# Protection and isolation

[Microsoft Purview data security and compliance protections for generative AI apps](https://learn.microsoft.com/en-us/purview/ai-microsoft-purview)

[Microsoft 365 isolation controls](https://learn.microsoft.com/en-us/compliance/assurance/assurance-microsoft-365-isolation-controls)

[Enable sensitivity labels for Office files in SharePoint and OneDrive](https://learn.microsoft.com/en-us/purview/sensitivity-labels-sharepoint-onedrive-files)

Hands-On Demo: [Watch a sensitivity label block Copilot](demo-label-blocks-copilot.md)

## Sensitivity labels do the real work

When Microsoft Purview Information Protection has encrypted an item, Copilot returns it only if the user holds the right usage rights on that item, specifically **VIEW** and **EXTRACT**. A user who can open a document in Word but lacks EXTRACT will not get that document's content summarized back to them by Copilot.

Two consequences follow that surprise people. First, generated content can inherit the most restrictive label or permission from its sources, and Copilot cites the original source, which keeps its own protection regardless of what the response does. Second, if sensitivity labels are not enabled for SharePoint and OneDrive, the encrypted files Copilot can reason about shrink to data in use inside Office apps on Windows, which is rarely what the customer intended.

Enabling labels for SharePoint and OneDrive is therefore the prerequisite, not an optimization. Without it, most of this protection layer is simply not in the retrieval path.

## Encryption without labels

Some encryption does not come from a label at all. Microsoft Purview Message Encryption, Information Rights Management, the Rights Management connector and the Rights Management SDK all use Azure Rights Management, so Copilot still checks VIEW and EXTRACT, but new items inherit nothing automatically.

Two further cases fail closed, and both are worth demonstrating because they contradict the usual assumption that Copilot sees everything the user sees:

- S/MIME protected mail is never returned by Copilot, and Copilot is unavailable in Outlook while an S/MIME message is open.
- Password-protected documents are unreachable unless the user already has them open in the same app. Passwords are not inherited by a destination item.

Items encrypted with Microsoft Purview Customer Key or your own root key (BYOK) behave the opposite way: they remain eligible to be returned by Copilot, exactly as they are for search and eDiscovery.

## Platform protections underneath

Alongside labels, the platform contributes the protections it always had. Access controls and multifactor authentication reduce credential compromise, "just enough access" limits lateral discovery, and service-side encryption covers data at rest and in transit using BitLocker, TLS 1.2 and IPsec.

For content reached through agents and plug-ins, encryption can exclude programmatic access, which stops the agent from reading content its user could open by hand. That distinction becomes important once the course reaches agent building in `03-extend`.

## Tenant isolation

Tenant isolation is the logical separation of each customer's data and services inside a shared multitenant platform. It has two goals: prevent leakage or unauthorized access across tenants, and prevent one tenant's activity from degrading service for another. Copilot running in Contoso's tenant cannot see Fabrikam's data, and the mechanism is not Copilot-specific.

The isolation controls that carry the load are worth naming, because auditors ask for them by name:

- **Logical isolation** of content per tenant through Microsoft Entra authorization and role-based access control.
- **Data segregation** through database schema, encryption and access control mechanisms, with SharePoint Online adding isolation at the storage level.
- **Authentication boundaries**, where credentials are verified against Microsoft Entra ID and only resolve within the user's own tenant.
- **Service customization** scoped per tenant, so configuration in one tenant cannot affect another.
- **Monitoring and diagnostics** scoped per tenant, so analytics and logs expose only that customer's data.
- **Regular validation** through audits, penetration testing and access reviews.

Microsoft describes the result as logical isolation providing threat protection and mitigation equivalent to physical isolation alone.

## The federated directory model

Underneath sits a federated directory. Microsoft Entra ID is the system of truth for small, shared, largely static data, while each workload keeps its own directory infrastructure in sync through state-based replication. Exchange Online uses its own storage; SharePoint Online uses both SQL Server storage and Azure Storage, which is why it needs extra isolation at the storage level.

No single system holds all directory data. That is part of why a permission change is not instantly reflected everywhere, including in what Copilot can retrieve, and it is the honest answer when a student asks why their test did not update immediately.

## Safety mitigations in the model

Copilot applies defense in depth to the model itself, not only to the data around it. Content harm filters cover Hate and Fairness, Sexual, Violence and Self-harm. Protected material detection covers text under copyright and code under licensing restrictions. Jailbreak and cross-prompt injection attack (XPIA) classifiers inspect input and block high-risk prompts before model execution.

One mitigation is specific to the workplace and often overlooked in a security review. Microsoft restricts generative models from making inferences, judgments or evaluations about an employee's performance, attitude, internal or emotional state, or personal characteristics based on their workplace communication.

## Discussion questions

- A customer says "Copilot leaked our salary data." What actually happened, and which control (permissions, sensitivity labels, or Restricted Content Discovery) should have prevented it?
- Sensitivity labels are not enabled for SharePoint and OneDrive. Which of the protections on this page are actually in effect?
- A user can open a document but Copilot refuses to summarize it. Which usage right is missing, and where do you check?
