# Hands-On Demo: Build a DLP policy that makes Copilot refuse to summarize a Highly Confidential document

Goal: prove a sensitivity label changes Copilot behavior only once a DLP policy is scoped to the Microsoft 365 Copilot location; the blocked item still appears as a citation, and the block leaves a DLP rule match event in DSPM for AI.

[DLP for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-policies) - [DSPM for AI](https://learn.microsoft.com/en-us/purview/ai-microsoft-purview)

Prerequisites: Purview Data Security AI Admin (or Compliance Administrator), one Copilot-licensed test user, a published sensitivity label named **Highly Confidential**, Purview Audit on. Budget 15 minutes plus up to 4 hours between step 5 and step 6.

## Steps

1. In the Microsoft Purview portal open **DSPM for AI** > [**Objectives**](https://purview.microsoft.com/dspm/ai) and note the coverage on the card **Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions**. Expected: card shows a coverage percentage; left nav lists Posture, Objectives, AI observability, Discover, Tasks and actions, Reports.

2. As the test user, upload a OneDrive document named **Q4 Restructuring Options** (any document you own), apply the **Highly Confidential** label, and ask Copilot Chat:

   ```text
   Summarize the key points of the document titled Q4 Restructuring Options.
   ```

   Expected: Copilot returns a real summary with the document as a citation (the label alone blocks nothing).

3. Open **Solutions** > [**Data Loss Prevention**](https://purview.microsoft.com/datalossprevention) > **Policies** > **+ Create policy**, pick **Custom** > **Custom policy**, and name it:

   ```text
   Copilot guardrail - block Highly Confidential processing
   ```

   Expected: wizard accepts the name; admin units are unavailable for this scenario.

4. On **Locations**, switch **Microsoft 365 Copilot and Copilot Chat** on. Expected: every other location greys out (this location is mutually exclusive with all others).

5. Add rule 1: **Content contains** > **Sensitivity labels** > **Highly Confidential**, action **Prevent Copilot from processing content**. Add rule 2: **Content contains** > **Sensitive information types** > **Credit Card Number**, action **Prevent Copilot from processing content** > **Performing Web Searches**. Finish with **Run the policy in simulation mode**. Expected: policy saves as **In simulation**; a label and a SIT cannot share one rule.

6. Open the policy from **Data Loss Prevention** > **Policies**, select **View simulation**, review **Simulation overview** and **Items for review**, then edit and set **Turn it on right away**. Expected: status changes to **On**; allow up to 4 hours to reach Copilot.

7. As the same user, repeat the step 2 prompt, then submit a second prompt with the published Visa test number (placeholder, no real account):

   ```text
   Search the web for guidance on disputing a charge on card 4111 1111 1111 1111.
   ```

   Expected: prompt 1 is declined with an organizational-policy message while the document still appears in citations; prompt 2 answers from internal sources only, no web citations.

8. Open **DSPM for AI** > **Discover** > [**Activity explorer**](https://purview.microsoft.com/dspm/ai), select the **AI activities** tab, filter for **DLP rule match**, and open your user's entry; then revisit **Objectives** > **Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions**. Expected: flyout shows the matched policy and rule alongside AI interaction and Sensitive info types events; the objective card now counts your policy.
