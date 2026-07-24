# Hands-On Demo: Catch a risky Copilot prompt with a communication compliance policy and remediate it

Goal: prove that a Microsoft Purview communication compliance policy turns a Microsoft 365 Copilot prompt into a reviewable, taggable, escalatable item, and that the adoption reports cannot do that job (nor the compliance policy the adoption job).

Budget 15 minutes. You need an account holding *Communication Compliance* (or *Communication Compliance Investigators*), the **AI Administrator** role for the reporting half, one licensed Microsoft 365 Copilot user to seed the prompt, and a tenant with communication compliance available. Scoping the policy to Microsoft Copilot experiences only avoids any pay-as-you-go billing requirement.

## Steps

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com) and go to **Communication Compliance** > [**Policies**](https://purview.microsoft.com/communicationcompliance/policies) > **Create policy**, then pick the **Detect Microsoft Copilot interactions** template. Name the policy:

   ```text
   MS4017 Copilot supervision
   ```

   Set **Users and groups** to the single licensed test user, and add your investigator account in the **Reviewers** field. Expected result: the wizard opens on the policy name page with the template name shown at the top, instead of the blank custom-policy form you get from **Create custom policy**, and the investigator account resolves to a person card inside the Reviewers box. An account without a communication compliance role fails to resolve and cannot be added, which is the early warning that no match will ever be visible to it.

2. On the settings summary the template fills in, choose **Customize policy** rather than **Create policy**, advance to **Choose locations to detect communications**, and confirm **Microsoft Copilot experiences** is selected while **Enterprise AI apps** and **Other AI apps** are clear. Expected result: exactly one location checkbox is ticked and the pay-as-you-go billing banner that the other two locations raise stays absent.

3. On **Choose conditions and review percentage**, add a condition of **Message contains any of these words** with this value, and set the review percentage to `100`:

   ```text
   Project Northwind, severance package, layoff list
   ```

   These three keywords are placeholders: swap in terms that real content in your own tenant will actually contain. Expected result: on **Review and finish** the summary lists the three keywords under the condition and shows 100% review, and after **Create policy** the new row appears on the **Policies** page.

4. As the licensed user, open Microsoft 365 Copilot Chat and submit this prompt:

   ```text
   Summarize what we know about the Project Northwind severance package and draft an announcement.
   ```

   Expected result: Copilot returns an ordinary grounded answer with citations, and no banner, warning, block, or delay appears anywhere in the chat pane.

6. Back in the Purview portal, go to **Communication Compliance** > **Policies**, open `MS4017 Copilot supervision`, and select the **Pending** tab. Expected result: entries carrying the Copilot icon and the value *[Copilot]* in the Subject column, with the user as Sender on the prompt entry and *Copilot* as Sender on the response entry.

7. Select the prompt entry and read the full message text in the right-hand pane, then select the response entry and read that. Expected result: the reading pane on the right renders the message text in its entirety for each entry, the user's full prompt on one and Copilot's full generated response on the other, rather than a keyword snippet or a redacted excerpt.

8. With the item selected, apply a tag (**Questionable** or **Compliant**), then **Escalate** it to a second reviewer, then **Resolve** it. Expected result: the row disappears from **Pending** and is listed on the **Resolved** tab, and reopening it shows the tag and the escalation as dated entries in the item history.

9. Open a second browser tab on the [Microsoft 365 admin center](https://admin.cloud.microsoft) as **AI Administrator**, go to **Reports** > [**Usage**](https://admin.cloud.microsoft/#/reportsUsage) > **Microsoft 365 Copilot** > **Copilot** and select the **Usage** tab, then open the **Copilot Dashboard** in the Viva Insights web app beside it. Expected result: today's date is missing from the trend chart and the prompt count is unchanged from before the demo, because Copilot usage data lands within 48 hours (up to 72 for readiness and agents). Ask the class to state, out loud, which of the three tabs now open answers an adoption question and which answers a compliance question.

## Talking points

Step 5 is the moment worth pausing on. The user saw nothing: no banner, no block, no delay. Communication compliance is detection and review after the fact, not prevention, and if the customer wanted the prompt stopped they needed a Microsoft Purview DLP policy on the Microsoft 365 Copilot location instead. Naming that distinction here saves an argument later in the engagement.

Step 7 is the one that makes legal teams lean forward and privacy officers stiffen. The reviewer reads the employee's verbatim prompt and Copilot's verbatim response. That is exactly why usernames are pseudonymized by default, why reviewers are opted in by an admin rather than self-selected, and why the reviewer action itself is audited.

Step 9 is the payoff of the whole topic. Three consoles are open, one of them has your prompt in it within seconds and the other two will not have it for two days. Any student who was planning to answer "is anyone using Copilot" from the compliance queue has just watched why that fails, and vice versa.

## Variation

Run the same lesson from the Microsoft Purview audit surface instead. Go to the Purview portal > **Solutions** > **Audit**, filter **Workloads** to `AIApp` and `Copilot`, and search for the same user and time window: the interaction is there, retrievable, and complete. Then point out that this view has no reviewer, no queue, no tag, and no escalation path, and that Learn explicitly warns against building usage metrics on top of it. Same underlying event, three different jobs.
