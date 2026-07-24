# Hands-On Demo: Find a Copilot interaction after the fact

Goal: follow one prompt through the three places an administrator can reach it, so Copilot interactions read as ordinary auditable Microsoft 365 data.

[Audit logs for Copilot and AI activities](https://learn.microsoft.com/purview/audit-copilot) | [Purview compliance for Microsoft 365 Copilot](https://learn.microsoft.com/purview/ai-m365-copilot)

## Steps

1. As the test user, ask Copilot Chat a question grounded in a specific SharePoint document, ideally one carrying a sensitivity label, and note the exact time. Expected: an answer with a citation to that document.

2. As the same user, ask a second question containing a recognizable sensitive information type, for example a fake credit card number. Expected: Copilot responds and the prompt text is stored in the interaction history.

3. In the Microsoft Purview portal open [**Audit**](https://purview.microsoft.com/audit) and search the unified audit log for the user over the step 1 window (set **Workloads** to **AIApp** and **Copilot**). Expected: the interactions appear as events with the Microsoft 365 service, the grounding files, and any file sensitivity label.

4. Open **DSPM for AI** > [**Activity explorer**](https://purview.microsoft.com/datasecurityposturemanagement) and switch to the **AI activities** tab. Expected: the same interactions, now with the sensitive information types from the step 2 prompt surfaced as classifications.

5. Open [**eDiscovery**](https://purview.microsoft.com/ediscovery), create a case, add the test user's mailbox as a source, and in the query builder select **Add condition** > **Type** > **Contains any of** > *Copilot activity*. Expected: the search returns the interactions, because prompts and responses are stored in the user's mailbox.

6. Add the results to a review set and export. Expected: an export containing the prompts, responses, and citations, in a form you could hand to a regulator or legal team.

7. Open **Data Lifecycle Management** > [**Retention policies**](https://purview.microsoft.com/datalifecyclemanagement) and inspect the policies applying to the test user's mailbox. Expected: whatever mailbox policy already existed also governs these AI interactions.

8. Create a retention policy scoped to Copilot and AI app interactions with a short duration and apply it to a pilot group. Expected: the policy lists the pilot group as its location (if it conflicts with the mailbox policy, the longest duration wins).
