# Meter and govern agents in Copilot Chat

[Using agents in Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/copilot/agents)

[Microsoft 365 Copilot pay-as-you-go service overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/overview)

[Set up Microsoft 365 Copilot pay-as-you-go services](https://learn.microsoft.com/en-us/microsoft-365/copilot/pay-as-you-go/setup)

[Agents admin guide for Microsoft 365](https://learn.microsoft.com/en-us/microsoft-365/copilot/agent-essentials/m365-agents-admin-guide)

Hands-On Demo: [Meter a Copilot Chat agent](demo-meter-and-govern-chat-agents.md)

## The free half and the paid half

Agents in Microsoft 365 Copilot Chat split along one line, and that line is grounding. A declarative agent grounded only in its own instructions and public websites costs nothing extra, is available by default, and shows up in the store according to the store settings you already run for Microsoft Teams and Microsoft 365 apps. An agent that reaches shared tenant data, such as a SharePoint site or Microsoft Graph connector content, is billed on metered consumption and is off by default for users in Copilot Chat.

"Off by default" is not a policy you configured, it is the absence of a billing arrangement. Until an administrator connects a billing source, an unlicensed user who opens a tenant-grounded agent simply cannot use it. Users who hold a Microsoft 365 Copilot license are outside this whole conversation: agent usage comes with the license, and no metering setup is required for them.

That asymmetry is the reason this topic exists. A tenant running Copilot Chat for everyone and Microsoft 365 Copilot for a hundred people has two populations with different agent behavior, and the difference is invisible in the product until someone in the unlicensed group hits a wall.

## Copilot Credits and the Copilot Studio meter

The unit of consumption is the Copilot Credit. Every metered interaction resolves to billable Copilot Studio messages, and the meter table lists a single line: the **Copilot Studio** meter, counting any request or message that triggers an action or response, billed at USD 0.01 per message. Nothing about credits is Copilot Chat specific; agent usage rides the Copilot Studio billing rails no matter which console you configure it in.

Credit cost varies by what the agent actually does per turn, which is the number people underestimate. Microsoft's own worked example: one complex prompt against an agent grounded in the tenant graph can consume 12 credits, 10 for the tenant graph grounding and 2 for the generative answer. Multiply that by a curious pilot group and the arithmetic stops being rounding error.

The consequence for demos is useful. Microsoft documents a deterministic test: have an eligible user prompt **Learning Coach**, **Writing Coach**, or **Career Coach** with `What can you do?`, which consumes roughly 12 credits and proves the plumbing without waiting for organic usage.

## Three ways to pay, and only one of them keeps the lights on

There are exactly three billing configurations, and choosing between them is a business-continuity decision rather than a pricing one.

A **pay-as-you-go billing policy** on its own charges per credit against an Azure subscription. The policy is a billing identifier that ties an Azure subscription and resource group to a set of users or groups, so cost can be allocated to the department that generates it. You can create up to 50 billing policies per tenant, and creating one is only half the job: nothing is billable until you connect the policy to a service under **Copilot** > [**Billing & usage**](https://go.microsoft.com/fwlink/p/?linkid=2330674) on the **Pay-as-you-go services** tab.

A **prepaid capacity pack** is a tenant-level subscription bought from the Microsoft 365 admin center Marketplace that provides 25,000 Copilot Credits per month, replenished each billing period. You attach it to users through a **Copilot credit policy**, scoped to security groups, distribution groups, or the whole tenant, with a hard ceiling of 10 credit policies per tenant. Credit policies need no Azure subscription at all, which makes them the low-friction option for a pilot.

Pairing the two is the configuration to recommend. Prepaid credits are consumed first, and when they run out usage switches automatically to pay-as-you-go with no interruption. Run a credit policy standalone and the failure mode is blunt: when the prepaid pool is empty, Copilot Chat becomes unavailable to every user in that policy's scope until credits replenish at the start of the next monthly period.

## The budget alert is a notification, not a brake

This is the single most misread control on the page. When you set a budget amount on a billing policy, it triggers email notifications at spending milestones relative to that limit. It does not enforce anything, it does not block, and usage continues uninterrupted after the budget is exceeded. If you present a budget to a finance stakeholder as a spending cap, you have mis-sold it.

Real ceilings live elsewhere and behave differently. In the [Power Platform admin center](https://admin.powerplatform.microsoft.com/) under **Licensing** > [**Copilot Studio**](https://go.microsoft.com/fwlink/p/?linkid=2330570), allocating capacity to the auto-provisioned **Microsoft 365 Copilot Chat** environment lets you choose what happens at zero: draw from remaining tenant capacity, bill to a pay-as-you-go plan, or neither. The same console sets per-agent monthly consumption limits under **Manage Agents**, which is the closest thing to a real cap on a single misbehaving agent.

Copilot Studio's own prepaid enforcement adds a grace band on top. Enforcement fires when a tenant reaches 125 percent of prepaid capacity, custom agents are disabled, and users start seeing `There is a billing issue.` or `This agent is currently unavailable. It has reached its usage limit.` An environment that has a pay-as-you-go meter attached is not caught by that enforcement, which is the mechanical reason the paired configuration is the safe one.

## Governing the agents themselves, not just their invoices

Metering answers "who pays". The Copilot Control System in the [Microsoft 365 admin center](https://admin.cloud.microsoft/) answers "which agents exist and who can reach them", under **Agents** > **All agents**. The **Agent inventory** tab is the tenant's real agent register, filterable by **Availability** (**All users**, **No users**) and by **Missing an owner**, with a **Support in** column showing where each agent surfaces.

The distinction that trips people up is availability versus deployment. **Available to** decides who can find and install an agent themselves. **Deployed to** installs it on their behalf and accepts the Microsoft Entra ID permissions for them, which is why deployment is the option you pick when you do not want a consent prompt deciding your rollout. **Pinning** is a third, separate act: an admin-pinned agent appears in the user's agent list whether or not they went looking, alongside agents pinned by Microsoft and by the user, and admin pins can be ranked.

Custom agents do not have to arrive through a maker publishing from Copilot Studio. **Agents** > **All agents** > **Upload custom agent** accepts a ZIP package containing the manifest, configuration, icons, branding, and embedded knowledge files, which a maker exports from Copilot Studio via **Agents** > *your agent* > **Channels** > **Teams and Microsoft 365 Copilot** > **Availability options** > **Download .zip**. Upload walks straight into the deployment wizard, so scoping it to **Just me** or a single test group is the difference between a pilot and an accident.

Run all of this as **AI Administrator**, not Global Administrator. Only AI Administrator and Global Administrator can install, modify, approve, and manage agent configurations; Global Reader, AI Reader, Security Administrator, Security Reader, and Reports Reader see the registry but cannot change it. Billing setup accepts Billing Administrator, AI Administrator, or Global Administrator. Note the one genuine exception: creating a Copilot credit policy is documented as requiring Global Administrator, so least privilege breaks down at exactly that step.

## Discussion questions

- Finance asks you to cap Copilot Chat agent spend at a fixed monthly figure. Which of the available controls actually deliver that, what does each of them cost the user experience when it fires, and which would you refuse to promise?
- A pilot group of 200 unlicensed users needs tenant-grounded agents next week. Do you start with a standalone Copilot credit policy on one 25,000-credit capacity pack, or pay-as-you-go against an Azure subscription? Defend the answer on the failure mode, not the price.
- The Credits report only counts users without a Microsoft 365 Copilot license. If your adoption plan moves heavy agent users onto full licenses, your credit consumption drops while total spend rises. How do you report that to a sponsor without it looking like a win?
