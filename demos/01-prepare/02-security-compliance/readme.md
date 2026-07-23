# Examine data security and compliance in Microsoft 365 Copilot

Copilot introduces no new security model. It inherits the one Microsoft 365 already has: Microsoft Entra ID for identity, per-item permissions in SharePoint, OneDrive, Exchange and Teams, and Microsoft Purview for classification, protection and compliance.

The uncomfortable part is that inheritance cuts both ways. If permissions are already too loose, Copilot does not cause a leak, it surfaces one that was always reachable, just faster and in natural language. Preparing a tenant for Copilot is therefore mostly permission hygiene, and only secondarily a Copilot configuration exercise.

## Topics

- [How Copilot handles your data](01-data-handling/readme.md)
- [Protection and isolation](02-protection-isolation/readme.md)
- [Compliance and governance](03-compliance-governance/readme.md)

## Sources

[Data, Privacy, and Security for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-privacy)

[Microsoft Purview data security and compliance protections for generative AI apps](https://learn.microsoft.com/en-us/purview/ai-microsoft-purview)

[Microsoft 365 isolation controls](https://learn.microsoft.com/en-us/compliance/assurance/assurance-microsoft-365-isolation-controls)

[Apply principles of Zero Trust to Microsoft 365 Copilot](https://learn.microsoft.com/en-us/security/zero-trust/zero-trust-microsoft-365-copilot)

[Learn module: Examine data security and compliance in Microsoft 365 Copilot](https://learn.microsoft.com/en-us/training/modules/examine-data-security-microsoft-365-copilot/)
