# Hands-On Demo: Turn off Copilot web search for one group and watch the user toggle go dark

Goal: prove that the Copilot settings page in the Microsoft 365 admin center does not own web search or Teams meeting Copilot, by configuring both from the consoles that do own them and observing the effect on two different users.

Budget 15 minutes. You need an account holding **AI Administrator** (to read the Copilot Control System), **Office Apps Administrator** (to create the Cloud Policy configuration), and **Teams Administrator** (to create the meeting policy), plus two users with a Microsoft 365 Copilot license: one inside the pilot group and one outside it. Create the Microsoft Entra security group first and name it `Copilot Web Search Pilot`.

## Steps

1. Sign in to the Microsoft 365 admin center and open **Copilot** > [**Settings**](https://admin.microsoft.com), then select the **Data access** tab and open **Web search for Microsoft 365 Copilot and Microsoft 365 Copilot Chat**. Expected result: the pane offers no on/off control at all, only a link out to the Microsoft 365 Apps admin center, which is the whole point of the step.

2. Follow that link to the [Microsoft 365 Apps admin center](https://config.office.com/officeSettings/officePolicies), go to **Customization** > **Policy Management**, and select **Create**. On **Start with the basics** enter the name `Copilot web search off for pilot`. Expected result: the wizard advances to **Choose the scope** with the name accepted.

3. On **Choose the scope**, pick the option for specific groups, select **Add Groups**, and add `Copilot Web Search Pilot`. Expected result: the group appears in the selected-groups list and **Next** becomes available.

4. On **Configure Settings**, search the policy list for `Allow web search in Copilot`, open it, and set it to **Disabled in Microsoft 365 Copilot and Microsoft 365 Copilot Chat**. Continue to the review page and select **Create**. Expected result: the new policy configuration is listed on the **Policy configurations** page with a priority value and one configured policy.

5. Sign in as the pilot-group member, open the Microsoft 365 Copilot app, and go to **Settings** > **Personalization** > **Advanced**. Expected result: the **Web content** toggle is off and dimmed, and cannot be switched back on. Sign in as the user outside the group and open the same place: the toggle is on and the user can still turn it off themselves.

6. In the [Microsoft Teams admin center](https://admin.teams.microsoft.com), go to **Meetings** > **Meeting policies**, create a policy named `Copilot Pilot`, open the **Recording & transcription** section, set **Copilot** to **On with saved transcript required**, and select **Save**. Assign the policy to the pilot-group member. Expected result: the policy appears in the **Meeting policies** list, and reopening it shows **Copilot** set to **On with saved transcript required**.

7. As the pilot-group member, create a Teams meeting and open its meeting options. Expected result: **Copilot** reads **During and after the meeting** and the dropdown is not editable, which is the difference between this value and the other three.

8. Return to the Microsoft 365 admin center, open [**Copilot settings**](https://admin.cloud.microsoft/#/copilot/settings) > **View all** and type `Bing` into **Search all Copilot settings**. Expected result: no result is returned; searching `Edge` instead returns **Copilot in Edge**, which opens the Microsoft Edge configuration policies console rather than a toggle on this page.

## Talking points

Step 1 next to step 4 is the lesson. The Copilot Control System advertises web search on the **Data access** tab, but the value is a Cloud Policy setting created by a different role in a different console, and nobody looking only at the Copilot page would ever know a pilot group had it disabled.

Step 5 is the evidence students remember. Two users, same license, same tenant, same app, and the toggle is live for one and dimmed for the other. It also shows the layering: when the admin permits web search the user keeps a real choice, and when the admin forbids it the user choice disappears rather than being silently ignored.

Step 7 is where the meeting policy stops being theory. Had you chosen **Off** instead, the organizer could simply switch Copilot back on for their own meeting, because three of the four values only set a default. **On with saved transcript required** is the only value that survives contact with a determined organizer.

## Variation

Do step 4 from the [Microsoft Intune admin center](https://intune.microsoft.com) instead, under **Apps** > **Policies for Microsoft 365**, which surfaces the same Cloud Policy configurations. Nothing about the outcome changes, which makes the point that the Copilot page is a set of shortcuts over policy stores that other administrators can already reach, and that a change made there will not be visible to whoever is watching the Copilot settings page.
