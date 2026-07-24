# Hands-On Demo: Catch a risky Copilot prompt with a communication compliance policy and remediate it

Goal: prove a Microsoft Purview communication compliance policy turns a Copilot prompt into a reviewable, taggable, escalatable item, and that adoption reports cannot do that job (nor the compliance policy the adoption job).

[Communication compliance for Copilot](https://learn.microsoft.com/en-us/purview/communication-compliance-copilot) - [Copilot usage reports](https://learn.microsoft.com/en-us/microsoft-365-copilot/microsoft-365-copilot-usage)

Prerequisites: an account with Communication Compliance (or Communication Compliance Investigators), AI Administrator for the reporting half, one Copilot-licensed test user. Scoping to Microsoft Copilot experiences avoids pay-as-you-go billing. Budget 15 minutes.

## Steps

1. In the Microsoft Purview portal open **Communication Compliance** > [**Policies**](https://purview.microsoft.com/communicationcompliance) > **Create policy** and pick the **Detect Microsoft Copilot interactions** template. Name it:

   ```text
   MS4017 Copilot supervision
   ```

   Set **Users and groups** to the test user and add your investigator account in **Reviewers**. Expected: wizard opens on the name page with the template name shown; the investigator resolves to a person card (an account with no comm-compliance role fails to resolve).

2. On the settings summary choose **Customize policy**, advance to **Choose locations to detect communications**, and confirm only **Microsoft Copilot experiences** is selected. Expected: exactly one location ticked; no pay-as-you-go billing banner.

3. On **Choose conditions and review percentage**, add **Message contains any of these words** and set review percentage to `100`:

   ```text
   Project Northwind, severance package, layoff list
   ```

   Swap in terms your own tenant content will contain. Expected: **Review and finish** lists the three keywords at 100% review; after **Create policy** the row appears on **Policies**.

4. As the licensed user, open Copilot Chat and submit:

   ```text
   Summarize what we know about the Project Northwind severance package and draft an announcement.
   ```

   Expected: Copilot returns an ordinary grounded answer with citations; no banner, warning, block, or delay (detection is after the fact, not prevention).

5. Back in Purview open **Communication Compliance** > [**Policies**](https://purview.microsoft.com/communicationcompliance), open `MS4017 Copilot supervision`, and select the **Pending** tab. Expected: entries carry the Copilot icon and *[Copilot]* in Subject; the user is Sender on the prompt entry and *Copilot* on the response entry.

6. Select the prompt entry, then the response entry, and read the full text in the right pane. Expected: the reading pane renders each message in full (the user's prompt, Copilot's response), not a snippet or redacted excerpt.

7. With an item selected, apply a tag (**Questionable** or **Compliant**), **Escalate** to a second reviewer, then **Resolve**. Expected: the row moves from **Pending** to **Resolved**; reopening shows the tag and escalation as dated history entries.

8. In a second tab, as **AI Administrator** in the Microsoft 365 admin center open **Reports** > [**Usage**](https://admin.cloud.microsoft/#/reportsUsage) > **Microsoft 365 Copilot**, and open the **Copilot Dashboard** in Viva Insights beside it. Expected: today is missing from the trend chart and prompt count is unchanged, because usage data lands within 48 hours (up to 72 for readiness and agents).

9. For the audit view, open **Solutions** > [**Audit**](https://purview.microsoft.com/audit), filter **Workloads** to `AIApp` and `Copilot`, and search the same user and time window. Expected: the interaction is retrievable and complete, but with no reviewer, queue, tag, or escalation path (Learn warns against building usage metrics on it).
