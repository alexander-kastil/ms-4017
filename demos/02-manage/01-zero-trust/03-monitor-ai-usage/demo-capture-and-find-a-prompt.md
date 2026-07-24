# Hands-On Demo: Build a collection policy and surface a specific prompt and response

Goal: prove that seeing an AI interaction and reading its prompt text are separate entitlements, one earned by a collection policy with content capture on, the other by a content-viewer role.

[Collection policies for AI interactions](https://learn.microsoft.com/purview/collection-policies-solution-overview) | [Audit logs for Copilot and AI activities](https://learn.microsoft.com/purview/audit-copilot)

## Steps

1. In the Microsoft Purview portal open **Data Loss Prevention** > **Classifiers** > [**Collection policies**](https://purview.microsoft.com/datalossprevention) > **+ Create policy**, name it `MS4017 Capture AI prompts`, description `Demo policy: capture prompts and responses for Copilot experiences`. Expected: the wizard advances to **Data to detect** with the name in the breadcrumb.

2. Select **+ Add condition** > **Content contains** > **Classifiers** and leave the scope on **All classifiers** with no exclusions. Expected: the condition row reads **All classifiers** (excluding even one greys out content capture on the later page).

3. Select **+ Add activities** and choose **Text sent to or shared with cloud or AI app** and **File uploaded to or shared with cloud or AI app**, then **Add**. Expected: both activities appear as chips and **Next** enables.

4. On **Where to apply** select **+ Add data source** and pick the Copilot experiences source (Copilot in Microsoft Fabric and Microsoft Security Copilot), or the **Unmanaged cloud apps** tab for a third-party app. Expected: the data source lists with an **Edit scope** link defaulting to all users.

5. On the next page change **Don't capture content** to the option that captures prompts and responses, then finish with the policy state **Turn on** and select **Create policy**. Expected: the review page lists content capture as enabled and the policy appears with state on.

6. Grant reading rights: in Purview open **Settings** > [**Roles and scopes**](https://purview.microsoft.com/settings/roles) > **Role groups** and add the demo account to a group carrying **Microsoft Purview Data Security AI Content Viewer** or **Content Explorer Content Viewer**. Expected: the account shows on the **Members** tab (sign out and back in, since a new role is not in the current token).

7. As the licensed user send one distinctive prompt to Microsoft 365 Copilot Chat, for example `MS4017 canary: summarize our Q3 pricing exception memo`, and note the exact minute. If the tenant has Microsoft Security Copilot, send the same canary there too (that is the interaction the collection policy is responsible for). Expected: Copilot answers and the prompt is listed in the user's Copilot activity history in the [My Account portal](https://myaccount.microsoft.com/).

8. Back in Purview open **DSPM** > [**Activity explorer**](https://purview.microsoft.com/datasecurityposturemanagement), switch to **AI activities**, filter to **AI interaction** for today, and open your user's event; in a second tab open [**Audit**](https://purview.microsoft.com/audit) and search the same window for `CopilotInteraction`. Expected: activity explorer shows the literal `MS4017 canary` prompt and response text, and the audit record shows `RecordType` `CopilotInteraction`, an `AppIdentity` such as `Copilot.MicrosoftCopilot.BizChat`, and `AccessedResources` with a `SensitivityLabelId` per grounding item.
