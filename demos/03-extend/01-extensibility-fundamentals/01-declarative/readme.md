# Declarative Agent

[Copilot Studio](https://copilotstudio.microsoft.com/)

[Copilot Studio - Visual Studio Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-CopilotStudio.vscode-copilotstudio)

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
