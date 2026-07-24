# Build a Declarative Agent in Copilot Studio Agent Builder

[Copilot Studio agent builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder)

[Agent builder vs full Copilot Studio](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/copilot-studio-experience)

[Copy an agent to Copilot Studio](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/copy-agent-to-copilot-studio)

The grounding document for this demo is `returns-policy.docx`, next to this readme.

## Demo

- Create Returns Agent in Copilot Studio

```text
I want to create an agent for a service desk that gets some metadata for a purchase: customer, order no, amount, payment method, country of purchase and returns a written letter with returns instructions and refund terms based on some word based knowledge. if the metadata is not passed ask for it using an adaptive card. the letter should use this template

Dear {{customer}}

Your purchase {{order no}} can be returned under the following conditions:

i. Instructions for return
ii. Payment refund
```

- Test using Copilot Studio

```text
I have a customer that wants to return the following purchase

Order No: 12354
Country: Austria
Amount: 55€
Payment: EPS Payment

Please create returns instructions
```
