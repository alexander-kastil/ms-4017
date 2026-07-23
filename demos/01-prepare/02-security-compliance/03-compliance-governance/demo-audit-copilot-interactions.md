# Hands-On Demo: Find a Copilot interaction after the fact

Goal: take one prompt a user typed and follow it through the three places an administrator can reach it, so the class sees that Copilot interactions are ordinary auditable Microsoft 365 data.

Budget 20 minutes. You need a Purview-capable administrator account and one licensed Copilot user who has used Copilot at least once today.

## Generate the evidence

1. As the test user, ask Copilot Chat a question grounded in a specific SharePoint document, ideally one carrying a sensitivity label. Expected result: an answer with a citation to that document. Note the exact time.

2. Ask a second question containing a recognizable sensitive information type, for example a fake credit card number pasted into the prompt. Expected result: Copilot responds, and the prompt text is now stored in the interaction history.

## Follow it through Purview

3. Open the Microsoft Purview portal and go to **Audit**. Search the unified audit log for the user over the time window from step 1. Expected result: the Copilot interactions appear as events, including which Microsoft 365 service the activity took place in and references to the files used for grounding. If a grounding file had a sensitivity label, the label is captured too.

4. Open DSPM for AI and go to the activity explorer **AI activities** tab. Expected result: the same interactions, this time with the sensitive information types detected in the prompt from step 2 surfaced as classifications.

5. Open **eDiscovery**, create a case, and add the test user's mailbox as a source. In the query builder select **Add condition** > **Type** > **Contains any of** > *Copilot activity*. Expected result: the search returns the interactions, because prompts and responses are stored in the user's mailbox.

6. Add the results to a review set and export. Expected result: an export containing the prompts, the responses, and the citations, in a form you could hand to a regulator or a legal team.

## Show the retention side

7. Open **Data Lifecycle Management** and inspect the retention policies that apply to the test user's mailbox. Expected result: whatever mailbox policy already existed also governs these AI interactions.

8. Create a retention policy scoped to Copilot and AI app interactions with a short duration, and apply it to a pilot group. Expected result: the policy is created and lists the pilot group as its location. Point out that if it conflicts with the existing mailbox policy, the longest duration wins.

## Talking points

Steps 3 to 5 are the same data reached three ways, and it is worth saying so explicitly. Audit answers "what happened", DSPM for AI answers "how exposed are we", and eDiscovery answers "give me the evidence". Customers routinely buy a fourth tool for a job one of these already does.

Step 7 is the uncomfortable one. Nobody decided to retain AI interactions; an existing mailbox policy decided it for them on the day Copilot was switched on. Ask the room what their own mailbox retention duration is, then let them do the arithmetic.

## Variation

If the tenant has Insider Risk Management available, enable the **Risky AI usage** policy template before step 1 and revisit it at the end. Expected result: prompt injection attempts and access to protected material surface as risk signals, which also flow into Microsoft Defender XDR.
