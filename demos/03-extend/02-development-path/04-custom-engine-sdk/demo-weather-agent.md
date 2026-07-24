# Hands-On Demo: Run the weather agent and call its tools

Goal: run the `weather-agent` custom engine agent locally and prove it invokes the weather and datetime tools.

Needs Node.js 18, 20, or 22 and an Azure OpenAI resource (key, endpoint, and a deployment such as gpt-4o-mini).

[Custom engine agents overview](https://learn.microsoft.com/en-us/microsoft-365/copilot/extensibility/overview-custom-engine-agent)

[Microsoft 365 Agents SDK](https://learn.microsoft.com/en-us/microsoft-365/agents-sdk/)

[Use the Microsoft Agent Framework as the orchestrator in the Agents SDK](https://learn.microsoft.com/en-us/microsoft-365/agents-sdk/using-semantic-kernel-agent-framework)

## Steps

1. Install dependencies in the project folder.

   ```bash
   cd weather-agent
   npm install
   ```

   Expected: `node_modules` is restored with no errors.

2. Add your Azure OpenAI credentials to `env/.env.playground.user`: `SECRET_AZURE_OPENAI_API_KEY`, `AZURE_OPENAI_ENDPOINT`, and `AZURE_OPENAI_DEPLOYMENT_NAME`. Expected: placeholders are replaced. Keep real keys out of source control.

3. In Visual Studio Code, select the Microsoft 365 Agents Toolkit icon, press F5, and choose `Debug in Microsoft 365 Agents Playground` (this runs `npm run dev` and opens the playground). Expected: the Microsoft 365 Agents Playground opens in the browser wired to the running agent.

4. Exercise the weather tool. Send: `What is the weather in Seattle tomorrow?`. Expected: the agent calls `getWeatherTool` and replies with a forecast Adaptive Card.

5. Exercise the datetime tool. Send: `What day and time is it right now?`. Expected: the agent calls `dateTimeTool` and returns the current date and time.
