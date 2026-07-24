# Hands-On Demo: Trace the compliance boundary

Goal: prove the compliance boundary is a setting, not a product property, by toggling web grounding off and re-running the same prompts.

[Manage web access for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365-copilot/manage-public-web-access)

## Steps

1. As the licensed user, open [Microsoft 365 Copilot Chat](https://m365.cloud.microsoft/chat) and ask a public-web question. Expected: answer carries public web citations.

2. Ask a tenant-only question (summarize a document only that user can open). Expected: citations link to SharePoint or OneDrive, not public URLs.

3. As admin, in the Microsoft 365 admin center open **Copilot** > [**Settings**](https://admin.cloud.microsoft/#/copilot) and turn off web search for Microsoft 365 Copilot and Copilot Chat. Expected: setting saves (propagation takes time).

4. Re-run step 1 as the user. Expected: no web-grounded citations; answers from model knowledge or declines.

5. Re-run step 2. Expected: unchanged, tenant grounding is not affected.

6. User opens [My Account](https://myaccount.microsoft.com/) and views Copilot activity history. Expected: every prompt is listed.

7. Delete the activity history there. Expected: entries disappear (user-facing delete; admin-side story in [03-compliance-governance](../03-compliance-governance/readme.md)).
