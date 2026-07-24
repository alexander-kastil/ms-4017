# Hands-On Demo: Turn off Copilot web search for one group and watch the user toggle go dark

Goal: prove that the Copilot settings page in the Microsoft 365 admin center does not own web search or Teams meeting Copilot, by configuring both from the consoles that do and watching two users diverge.

[Manage web access for Microsoft 365 Copilot](https://learn.microsoft.com/microsoft-365/copilot/manage-public-web-access)

Prerequisite: **AI Administrator**, **Office Apps Administrator**, and **Teams Administrator** roles, two Microsoft 365 Copilot licensed users (one in the pilot group, one outside), and a Microsoft Entra group named `Copilot Web Search Pilot`.

## Steps

1. In the Microsoft 365 admin center open **Copilot** > [**Settings**](https://admin.cloud.microsoft/#/copilot/settings), select the **Data access** tab, and open **Web search for Microsoft 365 Copilot and Microsoft 365 Copilot Chat**. Expected: the pane offers no on/off control, only a link out to the Microsoft 365 Apps admin center.

2. Follow that link to the [Microsoft 365 Apps admin center](https://config.office.com/officeSettings/officePolicies), open **Customization** > **Policy Management** > **Create**, and name it `Copilot web search off for pilot`. Expected: the wizard advances to Choose the scope.

3. On **Choose the scope**, pick specific groups, **Add Groups**, and add `Copilot Web Search Pilot`. Expected: the group appears in the selected list and Next becomes available.

4. On **Configure Settings**, search `Allow web search in Copilot`, open it, set it to **Disabled in Microsoft 365 Copilot and Microsoft 365 Copilot Chat**, then **Create**. Expected: the configuration is listed on the Policy configurations page with a priority and one policy.

5. Sign in as the pilot-group member, open the Microsoft 365 Copilot app, and go to **Settings** > **Personalization** > **Advanced**. Expected: the **Web content** toggle is off and dimmed. The user outside the group sees the toggle on and can still change it.

6. In the [Microsoft Teams admin center](https://admin.teams.microsoft.com), open **Meetings** > **Meeting policies**, create `Copilot Pilot`, in **Recording & transcription** set **Copilot** to **On with saved transcript required**, **Save**, and assign it to the pilot-group member. Expected: the policy is listed and reopening it shows Copilot set to On with saved transcript required.

7. As the pilot-group member, create a Teams meeting and open its meeting options. Expected: **Copilot** reads During and after the meeting and the dropdown is not editable (the difference from the other three values).

8. In the Microsoft 365 admin center open **Copilot** > [**Settings**](https://admin.cloud.microsoft/#/copilot/settings) > **View all** and search `Bing`. Expected: no result; searching `Edge` returns **Copilot in Edge**, which opens the Microsoft Edge configuration policies console, not a toggle on this page.
