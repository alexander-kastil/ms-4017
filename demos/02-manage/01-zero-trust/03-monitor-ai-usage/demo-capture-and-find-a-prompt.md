# Hands-On Demo: Build a collection policy and surface a specific prompt and response

Goal: prove that seeing an AI interaction and reading its prompt text are two separate entitlements, one earned by a collection policy with content capture on, the other by a content-viewer role.

Budget 15 minutes. You need an account in the Microsoft Purview Compliance Administrator role group (or the Microsoft Entra Compliance Administrator role) to create the policy, the **Microsoft Purview Data Security AI Content Viewer** role (or the **Content Explorer Content Viewer** role group) to read prompt text, Microsoft Purview auditing turned on, and one Microsoft 365 Copilot licensed user. The **Copilot experiences** and **Enterprise AI** data sources are pay-as-you-go features, so Microsoft Purview pay-as-you-go billing must be linked to an Azure subscription before you can create the policy at all.

## Steps

1. In the [Microsoft Purview portal](https://purview.microsoft.com), open **Solutions** > **Data Loss Prevention** > **Classifiers** > [**Collection policies**](https://purview.microsoft.com/datalossprevention) and select **+ Create policy**. Name it `MS4017 Capture AI prompts` and set the description to `Demo policy: capture prompts and responses for Copilot experiences`. Expected result: the wizard advances to **Data to detect** with the policy name shown in the breadcrumb.

2. Select **+ Add condition** > **Content contains** > **Classifiers**, and leave the scope on **All classifiers** without exclusions. Expected result: the **Scope for classifiers** flyout closes with the **Exclude classifiers** checkbox clear, and the condition row reads **All classifiers**. Keep it that way: if you exclude even one classifier, the content-capture option on the later page is greyed out.

3. Select **+ Add activities** and choose **Text sent to or shared with cloud or AI app** and **File uploaded to or shared with cloud or AI app**, then **Add**. Expected result: both activities appear as chips on the activities step and **Next** becomes available.

4. On **Where to apply**, select **+ Add data source** and pick the Copilot experiences source (Copilot in Microsoft Fabric and Microsoft Security Copilot), or the **Unmanaged cloud apps** tab if you are demonstrating with a third-party app. Expected result: the data source is listed with an **Edit scope** link, defaulting to all users.

5. On the next page, change the default **Don't capture content** to the option that captures prompts and responses, then finish the wizard with the policy state set to **Turn on** and select **Create policy**. Expected result: the review page lists content capture as enabled, and after creation the policy appears in the collection policies list with a state of on.

6. Assign reading rights: in the Microsoft Purview portal go to **Settings** > [**Roles and scopes**](https://purview.microsoft.com/settings/roles) > **Role groups**, and add the demo account to a role group carrying **Microsoft Purview Data Security AI Content Viewer** or to **Content Explorer Content Viewer**. Expected result: the account appears on the role group's **Members** tab and the member count on the role groups list increments by one. Sign the account out and back in before the next step, because a newly granted role is not in the existing session's token.

7. Sign in as the licensed user and send one distinctive prompt to Microsoft 365 Copilot Chat, for example `MS4017 canary: summarize our Q3 pricing exception memo`. Note the exact minute you sent it. If the tenant has Microsoft Security Copilot, send the same canary there as well, because that one is the interaction your new collection policy is responsible for. Expected result: Copilot returns an answer in the chat, and the prompt is listed in the user's Copilot activity history in the [My Account portal](https://myaccount.microsoft.com/), which confirms the interaction was recorded before you go looking for it as an administrator.

8. Back in the Purview portal, open **Solutions** > **DSPM** > **Discover** > **Activity explorer**, switch to the **AI activities** tab, filter the activity to **AI interaction** and set the date range to today, then open the event for your user. In a second tab open **Solutions** > [**Audit**](https://purview.microsoft.com/audit/auditsearch) and search the same window for the operation `CopilotInteraction`. Expected result: activity explorer shows the literal `MS4017 canary` prompt and Copilot's response text, and the audit record for the same timestamp shows `RecordType` `CopilotInteraction`, an `AppIdentity` such as `Copilot.MicrosoftCopilot.BizChat`, and the `AccessedResources` list with a `SensitivityLabelId` per grounding item.

## Talking points

Step 5 is the whole demo. Everything before it produced a policy that would have recorded that an interaction happened and which sensitive information types it contained, and nothing else. One option is the difference between a metadata trail and readable evidence, and the one-click policy created from the **Extend insights into sensitive data in AI app interactions** recommendation ships with that option unselected.

Be precise about which prompt the policy earned you. The Microsoft 365 Copilot canary from step 7 is readable because auditing is on and you hold the content-viewer role; no collection policy is involved. The Security Copilot canary is the one that would show no text at all without the policy you just built, which is why sending both in the same minute makes the distinction visible in a single activity explorer view.

Step 6 is where the room argues. Compliance Administrator built the policy and still cannot read a single prompt. Microsoft split posture administration from content reading deliberately, and the split survives Global Administrator too, so "I am Global Admin" is not an answer here.

Step 8 is the credibility moment. Activity explorer answers "was sensitive data involved", the unified audit log answers "what exactly did Copilot open to answer this", including whether `AISystemPlugin.Id` is `BingWebSearch`. Regulators tend to ask the second question, and only the audit log has the resource-level detail.

## Variation

Run the same lesson from the classic console: open **DSPM for AI (classic)** > **Recommendations**, accept **Secure interactions in Microsoft Copilot experiences** to let the one-click flow create **DSPM for AI - Capture interactions for Copilot experiences** for you, then go back into **Classifiers** > **Collection policies** and inspect what it actually configured. Students see that the recommendation produced a real, editable collection policy, and that accepting a recommendation is not the same as choosing its settings.
