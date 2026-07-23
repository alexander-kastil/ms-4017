# CLAUDE.md

Companion repository for **MS-4017: Manage and extend Microsoft 365 Copilot** ([Microsoft Learn course](https://learn.microsoft.com/en-us/training/courses/ms-4017)), delivered by Alexander Kastil. The content is instructor demos: mostly `readme.md` walkthroughs and curated Microsoft Learn links, plus a few runnable agent projects.

## Repository Layout

- `demos/` — all course content, numbered by delivery order. Do not reorganize or renumber.
  - `01-prepare` — Prepare your organization for Microsoft 365 Copilot
    - `01-implement` with `01-prepare-env`, `02-copilot-pag`, `03-sp-adv-mgmt`, `04-restricted-search`, `05-external-data`
    - `02-security-compliance`
  - `02-manage` — `01-zero-trust`, `02-copilot`, `03-m365-copilot`
  - `03-extend` — `01-extensibility-fundamentals` (with `01-declarative`, `02-custom-engine`), `02-development-path`, `03-manage-extensibility`
- `setup/setup-ms-4017.ps1` — tenant/workstation prerequisites.
- `readme.md` (root), `demos/readme.md`, and each module `readme.md` are link hubs into the level below. When a topic folder is added, link it from its parent `readme.md`.
- Screenshots live in a `_images/` folder next to the `readme.md` that uses them, referenced relatively (`![alt](./_images/name.jpg)`).

There is no `labs/`, `src/`, or root `infra/` in this repo, and no `.claude/skills/` or custom slash commands. Do not write instructions that assume them.

## Runnable Projects

All code lives inside the `demos/03-extend` tree and is built with the **Microsoft 365 Agents Toolkit** (`m365agents.yml`, `appPackage/manifest.json`, `env/`, `infra/*.bicep`):

- `01-extensibility-fundamentals/01-declarative/hello-world/HelloWorldAgent` — declarative agent app package.
- `01-extensibility-fundamentals/01-declarative/copilot-studio-returns` — declarative agent walkthrough plus its grounding document.
- `01-extensibility-fundamentals/02-custom-engine/weather-agent` — TypeScript custom engine agent on the Microsoft 365 Agents SDK (`@microsoft/agents-hosting`) with LangChain/LangGraph and Express. Node 18/20/22, `npm run dev` / `npm run build`.
- `03-manage-extensibility/copilot-connector/Github Issues` — TypeScript Azure Functions Microsoft 365 Copilot connector.

`node_modules/`, `lib/`, and `appPackage/build/` directories exist on disk. Never read, edit, or search them; exclude them from every glob and grep.

## MCP Servers

`.mcp.json` wires four servers. Prefer them over guessing:

- `microsoft-learn` — authoritative source for Microsoft 365 Copilot, Entra, Purview, and extensibility docs. Verify product UI paths and identifiers here before writing them into a demo.
- `github`, `chrome-devtools`, `work-iq`.

## Content Conventions

- Demo files are named `readme.md` (lowercase). Leave the vendor-generated `README.md` files inside the toolkit projects as they are.
- A demo `readme.md` opens with an `#` title, then Learn links, then the click-through steps as a bullet list. Admin center paths use bold with the target linked, e.g. **Settings** > [**Org settings**](https://admin.cloud.microsoft/?#/Settings/Services).
- Internal links are relative (`01-implement/readme.md`); anchors use `#heading-name`.
- Code fences must declare a language (`powershell`, `bash`, `json`, `typescript`, …).
- No em dashes in prose: use `,` `;` `:` or `()`.
- Mermaid node labels use `"quoted<br/>labels"`, never `\n`.
- Product names in full on first use: Microsoft 365 Copilot, Microsoft Entra ID, Microsoft Purview.
- Microsoft admin UI moves often. When a step no longer matches the portal, fix the step; do not invent a plausible path.

## Hard Rules

- **PARALLELIZE ALL INDEPENDENT WORK.** Independent tool calls, file reads, searches, or subagent tasks go out in a single batch. Sequential execution of independent work is a bug.
- YOU MUST NOT commit or push without explicit user request.
- Git commands in this working copy fail with `dubious ownership` (the `.git` directory is owned by a different account). Surface that to the user rather than running `git config --global --add safe.directory` unasked.
- If a quality check fails, fix the underlying issue. Do not bypass with `--no-verify`.
- Write clean code with no noise: no inline comments, no explanatory remarks, no placeholder notes.
- No error handling in scripts unless explicitly requested.
- Never put tenant IDs, app secrets, or account credentials into demo content. Use placeholders and say so in the text.

## Workflow

### 1. Plan First
- Enter plan mode for any non-trivial task (3+ steps or structural decisions).
- If something goes sideways, STOP and re-plan instead of pushing on.
- Write detailed specs upfront to reduce ambiguity.

### 2. Subagents
- Use subagents liberally to keep the main context clean.
- Offload research, exploration, and parallel analysis; one task per subagent.

### 3. Verification Before Done
- Never mark a task complete without proving it works: build the project, follow the steps, check the links.
- For content changes, confirm every new external link resolves and every parent `readme.md` links the new topic.

### 4. Minimal Diff
- **Simplicity First**: make each change as small as it can be.
- **Tutorial over library**: clear explanations and copy-paste examples beat reusable abstractions.
- Do not rewrite a section to fix a typo.

## Token Efficiency

- Never re-read files you just wrote or edited.
- Never re-run commands to verify unless the outcome was uncertain.
- Do not echo back large blocks of code or file contents unless asked.
- Batch related edits into single operations.
- Do not summarize what you just did unless the result is ambiguous or you need input.
