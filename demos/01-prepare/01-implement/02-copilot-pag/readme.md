# Copilot & Copilot Studio Billing

Hands-On Demo: [Cap Copilot credit spend with a targeted spending policy](demo-spending-policy.md)

## Copilot Pay as you go billing

[Microsoft 365 Copilot pay-as-you-go overview](https://learn.microsoft.com/en-us/copilot/microsoft-365/pay-as-you-go/overview)

[Set up Microsoft 365 Copilot pay-as-you-go services](https://learn.microsoft.com/en-us/copilot/microsoft-365/pay-as-you-go/setup)

[View costs and billing for Microsoft 365 Copilot pay-as-you-go](https://learn.microsoft.com/en-us/copilot/microsoft-365/pay-as-you-go/view-cost)

[Meters for Microsoft 365 Copilot pay-as-you-go services](https://learn.microsoft.com/en-us/copilot/microsoft-365/pay-as-you-go/meters)

Pay-as-you-go lets an organization use Copilot capabilities on metered billing instead of committing to per-user licenses. The usual reason to reach for it is to establish real usage patterns before deciding how many prepaid seats to buy.

Three services bill this way today:

- Microsoft 365 Copilot Chat
- SharePoint agents
- Microsoft Copilot Retrieval API (Preview)

### Setup is two steps, not one

Creating the billing policy does not finish the job, which is the step teams most often miss.

1. **Add a billing policy.** The policy is the billing identifier that ties an Azure subscription to a set of users. Add a budget limit and configure email notifications at percentage milestones.
2. **Connect the billing policy to a Copilot service.** This grants the covered users access to the metered service. Disconnecting removes their access to the metered agents.

Policies connect one at a time, and an existing "all users" policy has to be disconnected before you connect a user-specific one.

Billing lands on the Azure subscription named in the policy, through that service's Azure meter. Pay-as-you-go is disabled by default; a Global Administrator or subscription owner enables it.

### Roles that can manage it

Global administrator, Billing administrator, AI administrator, and Global reader for read-only access. Prefer the AI administrator or Billing administrator role over Global administrator.

### Monitoring

- **Microsoft 365 admin center** > **Copilot** > **Cost management**, with Overview, Configuration and Consumption tabs. A banner on that page states it applies to **Copilot Cowork** and **Work IQ API** only for now, and points at **classic Billing & usage** for the other pay-as-you-go services.
- Azure portal, for cost breakdown and analysis through Microsoft Cost Management

Spending policies on the Configuration tab carry a precedence rule that reads backwards to most people: when several policies apply to one user, the most targeted policy wins, so a higher targeted budget overrides a lower all-users budget.

## Copilot Studio Pay as you go billing

[Copilot Studio licensing](https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing)

[Copilot Studio - set up pay as you go](https://learn.microsoft.com/en-us/power-platform/admin/pay-as-you-go-set-up)

Copilot Studio bills separately, through Power Platform rather than the Microsoft 365 admin center.

- Setup in **Power Platform admin center** > **Licensing** > **Copilot Studio** > **Manage billing plans**
