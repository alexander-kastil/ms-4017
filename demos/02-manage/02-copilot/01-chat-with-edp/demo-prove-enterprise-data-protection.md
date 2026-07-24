# Hands-On Demo: Scope Copilot Chat to one pilot group

Goal: prove that Copilot Chat access is an admin decision, and that the green enterprise data protection shield reflects which account signed in, not which website was opened.

[Enterprise data protection in Microsoft 365 Copilot](https://learn.microsoft.com/microsoft-365/copilot/enterprise-data-protection)
[Copilot Chat updates and enterprise data protection FAQ](https://learn.microsoft.com/copilot/edpfaq)

Note: Integrated apps availability changes take up to 24 hours (rarely up to six days) to reach clients. Make the change the day before class and verify steps 5 and 6 first.

## Steps

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), open **Entra ID** > **Groups** > [**All groups**](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade) and create a security group named `Copilot-Chat-Pilot`, adding only the second test user (the one who keeps access). Expected: group shows a membership count of 1 and an object ID.

2. In the Microsoft 365 admin center, open **Settings** > [**Integrated apps**](https://admin.microsoft.com/#/Settings/IntegratedApps) and select the **Copilot** app. Expected: the Copilot app pane shows its current availability (typically all users can install).

3. In the Copilot app pane, set availability to *Specific users/groups in the organization can install*, assign `Copilot-Chat-Pilot`, and save. Expected: the row reads Specific users/groups and names the group (allow list; everyone outside it loses the Copilot app).

4. In the Microsoft 365 admin center open **Copilot** > [**Settings**](https://admin.cloud.microsoft/#/copilot/settings) > **View all**, search `blocked`, open **Custom link for blocked Microsoft 365 Copilot app** if listed, and paste your tenant's real policy page URL. Expected: the setting saves (user-facing link text is View info from your organization), or the search returns nothing (setting is conditional; continue to step 5).

5. In a private browser window, sign in as the first test user (outside the group) at `https://m365.cloud.microsoft/chat`. Expected: the page shows Copilot Chat was turned off for your organization with a View info from your organization link.

6. In a second private window, sign in as the unblocked test user with their Microsoft Entra account at `https://copilot.cloud.microsoft` and submit this prompt:

   ```text
   Summarize the top three cybersecurity news stories from this week and cite your sources.
   ```

   Expected: a green shield appears next to the New Chat button and the answer carries web citations.

7. In the same window, open a new tab at `https://copilot.microsoft.com`, sign in with the personal Microsoft account, and submit the identical prompt. Expected: consumer Microsoft Copilot loads with no green shield, and tenant settings have no effect on it.

8. Return to **Settings** > [**Integrated apps**](https://admin.microsoft.com/#/Settings/IntegratedApps), set the Copilot app back to *All users in the organization can install*, and save. Expected: the row reads All users, and after propagation the first user's reload of the chat URL shows a working Copilot Chat with the same green shield.
