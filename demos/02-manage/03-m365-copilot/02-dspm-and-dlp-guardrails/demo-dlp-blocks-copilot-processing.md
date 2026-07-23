# Hands-On Demo: Build a DLP policy that makes Copilot refuse to summarize a Highly Confidential document

Goal: prove that a sensitivity label only changes Copilot behavior once a data loss prevention policy is scoped to the Microsoft 365 Copilot and Copilot Chat location, that the blocked item still appears as a citation, and that the enforcement leaves a traceable **DLP rule match** event in Data Security Posture Management.

Budget 15 minutes, plus a wait of up to four hours between step 5 and step 6. You need an account holding **Purview Data Security AI Admin** or **Purview Compliance Administrator** (Global Administrator works but teach the least-privilege option), one Microsoft 365 Copilot licensed test user, a published sensitivity label named **Highly Confidential**, and Microsoft Purview Audit turned on in the tenant.

## Steps

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/) and open **Solutions** > [**DSPM**](https://purview.microsoft.com/) > **Objectives**. Locate the card **Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions** and note its current coverage metric before you change anything. Expected result: the objective card renders with a coverage percentage and a list of prioritized actions, and the left navigation shows **Posture**, **Objectives**, **AI observability**, **Discover**, **Tasks and actions**, and **Reports**. If you land on a page titled **DSPM (classic)** or **DSPM for AI (classic)**, you are in the wrong solution.

2. As the licensed test user, upload a document to OneDrive named **Q4 Restructuring Options** (a placeholder title for this demo, substitute any document you own), apply the **Highly Confidential** sensitivity label to it, and ask Microsoft 365 Copilot Chat to summarize it with this prompt:

   ```text
   Summarize the key points of the document titled Q4 Restructuring Options.
   ```

   Expected result: Copilot returns a real summary with the document listed as a citation. The label is published and applied, and it changes nothing about Copilot's willingness to read the file.

3. Back in the Microsoft Purview portal, go to **Data Loss Prevention** > [**Policies**](https://purview.microsoft.com/) > **+ Create policy**, choose the **Custom** template and then **Custom policy**, and name it:

   ```text
   Copilot guardrail - block Highly Confidential processing
   ```

   Expected result: the wizard accepts the name and advances to admin units. Admin units are unavailable for this scenario, which is the first hint that the Copilot location behaves differently from the rest of DLP.

4. On the **Locations** page, switch **Microsoft 365 Copilot and Copilot Chat** to on. Expected result: every other location in the policy greys out and cannot be selected. This location is mutually exclusive with all others.

5. Create the first rule with **Content contains** > **Sensitivity labels** > **Highly Confidential** and the action **Prevent Copilot from processing content**. Then add a second rule in the same policy with **Content contains** > **Sensitive information types** > **Credit Card Number** and the action **Prevent Copilot from processing content** > **Performing Web Searches**. On the final page choose **Run the policy in simulation mode**. Expected result: the policy saves with status **In simulation**, and any attempt to put both conditions in one rule is rejected because sensitivity labels and sensitive information types cannot coexist in a single rule.

6. Open the policy from **Data Loss Prevention** > **Policies**, select **View simulation**, and read the **Simulation overview** and **Items for review** tabs. Then edit the policy and set it to **Turn it on right away**. Expected result: the simulation dashboard lists matched items with no user impact, and after the edit the policy status changes to **On**. Allow up to four hours for the change to reach the Copilot experience.

7. As the same test user, repeat the exact prompt from step 2. Then submit a second prompt containing the published Visa test card number below, which is a placeholder value that matches the SIT pattern and belongs to no real account:

   ```text
   Search the web for guidance on disputing a charge on card 4111 1111 1111 1111.
   ```

   Expected result: for the first prompt Copilot declines to summarize and states that organizational policy prevents it from using the content, while the document still appears in the citations list. For the second prompt Copilot answers from internal sources only, with no web citations returned.

8. Return to the Microsoft Purview portal > **Solutions** > **DSPM** > **Discover** > **Activity explorer** and select the **AI activities** tab. Filter for the **DLP rule match** event and open the entry for your test user. Then revisit **Objectives** > **Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions**. Expected result: the flyout shows the matched policy and rule name from step 3 alongside the **AI interaction** and **Sensitive info types** events for the same prompts, and the objective card now counts your policy toward its coverage metric.

## Talking points

Step 2 is the one to slow down for. Everyone in the room assumes the label did the work. It did not: the user had access, Copilot ran in that user's security context, and the summary came back. The label is a classification; the DLP policy is the control.

Step 7 always produces the citation objection. The blocked document is still named in the response, and that is documented behavior, not a leak. Copilot tells the user which item it refused to read; the user could have opened that file anyway, because this policy removes processing rather than access. If the requirement is that the item never surfaces at all, the answer is SharePoint Restricted Content Discovery or a permission fix, not a bigger DLP policy.

The two waits are worth naming explicitly rather than apologizing for. Policy updates take up to four hours to reach the Copilot experience, and in Word, Excel, and PowerPoint the policy is evaluated at file open, so labelling a document that is already open enforces nothing until the next open. Both facts turn into support tickets in production if nobody told the service desk.

## Variation

Reach the same policy from the other direction. Go to **DSPM** > **Discover** > **Data risk assessments**, open the default weekly Microsoft 365 assessment, select a flagged site, and on the **Protect** tab of the flyout choose **Restrict access by label**. That path creates the same Microsoft 365 Copilot and Copilot Chat DLP policy from an oversharing finding rather than from a blank wizard, which shows the class that DSPM's guided workflow and the hand-built policy converge on one object. Compare the generated policy's state and scope with what you built in step 5, and discuss whether you would have shipped it that way.
