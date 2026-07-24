# Hands-On Demo: Build a Returns agent in agent builder

Goal: build a declarative agent in the Copilot Studio agent builder, ground it in a Word policy, and test it against a returns request.

Prerequisite: a Microsoft 365 Copilot licensed tenant. The grounding document `returns-policy.docx` sits next to this file.

[Copilot Studio agent builder](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder)

[Add knowledge sources to an agent](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/agent-builder-add-knowledge)

[Copy an agent to Copilot Studio](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/copy-agent-to-copilot-studio)

## Steps

1. Upload `returns-policy.docx` to a SharePoint or OneDrive location the agent can reach. Expected: file is stored and searchable.

2. In [Microsoft 365 Copilot](https://m365.cloud.microsoft), select **New agent** to open agent builder. Expected: the **Describe** and **Configure** tabs appear.

3. On the **Describe** tab, paste the prompt below to define the agent. Expected: name, description, and instructions populate on the **Configure** tab.

```text
I want to create an agent for a service desk that gets some metadata for a purchase: customer, order no, amount, payment method, country of purchase and returns a written letter with returns instructions and refund terms based on some word based knowledge. if the metadata is not passed ask for it using an adaptive card. the letter should use this template

Dear {{customer}}

Your purchase {{order no}} can be returned under the following conditions:

i. Instructions for return
ii. Payment refund
```

4. On the **Configure** tab, under **Knowledge**, add `returns-policy.docx` as a SharePoint or OneDrive knowledge source. Expected: the file is listed as a knowledge source.

5. On the **Try it** tab, run the sample request below. Expected: the agent asks for any missing metadata, then returns a letter grounded in the policy.

```text
I have a customer that wants to return the following purchase

Order No: 12354
Country: Austria
Amount: 55€
Payment: EPS Payment

Please create returns instructions
```

6. To take the agent into the full low-code canvas, use [Copy an agent to Copilot Studio](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/copy-agent-to-copilot-studio). Expected: an editable copy opens in Copilot Studio.
