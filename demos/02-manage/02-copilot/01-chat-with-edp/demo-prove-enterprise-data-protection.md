# Hands-On Demo: Scope Copilot Chat to one pilot group

Goal: prove that access to Microsoft 365 Copilot Chat is an administrative decision, and that the green enterprise data protection shield is a fingerprint of which account signed in, not of which website was opened.

Budget 15 minutes of hands-on time. You need an account with the Microsoft Entra ID **AI Administrator** role (or Global Administrator) in the Microsoft 365 admin center, two Microsoft Entra test users in the same tenant, and one personal Microsoft account. No Microsoft 365 Copilot add-on license is required: Copilot Chat is included with the Microsoft 365 and Office 365 SKUs listed in the [readme](readme.md).

Plan the delivery around one constraint: Integrated apps availability changes take up to 24 hours to reach clients, and in rare cases up to six days. Make the change the day before the class and verify steps 5 and 6 have taken effect before you present.

## Steps

1. In the [Microsoft Entra admin center](https://entra.microsoft.com), go to **Entra ID** > **Groups** > **All groups** > **New group** and create a security group named `Copilot-Chat-Pilot`, then add your second test user (the one who keeps access) as a member. Leave the first test user out of the group. Expected result: the group appears in **All groups** with a membership count of 1 and an object ID on its overview page.

2. In the Microsoft 365 admin center, open **Settings** > [**Integrated apps**](https://admin.microsoft.com/#/Settings/IntegratedApps) and select the app named **Copilot** from the list of available apps. Expected result: the Copilot app details pane opens and shows its current availability, typically *All users in the organization can install*.

3. In the Copilot app pane, change availability to *Specific users/group in the organization can install*, assign the group `Copilot-Chat-Pilot`, and save. This is an allow list, not a block list: everyone outside the group, including the first test user, loses the Copilot app. Expected result: the Copilot app row now reads *Specific users/groups* and names the group instead of the whole organization.

4. Still in the Microsoft 365 admin center, open [**Copilot settings**](https://admin.cloud.microsoft/#/copilot/settings) > **View all**, type `blocked` into **Search all Copilot settings**, and open **Custom link for blocked Microsoft 365 Copilot app** if it is listed. Paste your own policy page URL; use your tenant's real page, because `https://contoso.sharepoint.com/sites/policies/SitePages/ai-use.aspx` is a placeholder and will not resolve. Expected result: either the setting saves and the admin center states that the link text shown to users is **View info from your organization**, or the search returns "We didn't find anything to show here". Both outcomes are worth showing: the entry is documented on Microsoft Learn but was not present in a tenant checked in July 2026, so treat it as conditional and continue with step 5.

5. In a private browser window, sign in as the first test user, the one outside the pilot group, at `https://m365.cloud.microsoft/chat`. Expected result: the page renders *Copilot Chat was turned off for your organization* together with a **View info from your organization** link pointing at the URL from step 4, and Chat is still visible in the Microsoft 365 Copilot app navigation.

6. In a second private window, sign in as the unblocked test user with their Microsoft Entra account at `https://copilot.cloud.microsoft` and submit the prompt `Summarize the top three cybersecurity news stories from this week and cite your sources.` Expected result: a green shield appears along the top of the interface next to the New Chat button, and the answer carries web citations.

7. In the same second window, open a new tab at `https://copilot.microsoft.com` and sign in with the personal Microsoft account, then submit the identical prompt. Expected result: the consumer Microsoft Copilot interface loads with no green shield anywhere in the user interface, and the tenant's administrative settings have no effect on it.

8. Return to **Settings** > [**Integrated apps**](https://admin.microsoft.com/#/Settings/IntegratedApps), set the Copilot app back to *All users in the organization can install*, and save. Expected result: the Copilot app row reads *All users* again, and once the change propagates the first test user's reload of `https://m365.cloud.microsoft/chat` replaces the policy page with a working Copilot Chat interface carrying the same green shield the second user saw.

## Talking points

Step 5 is the one that changes the room's mind about the pinning setting. The block worked, and Chat is still in the navigation: as of January 28, 2026 the **Pin Microsoft 365 Copilot Chat in Microsoft 365 apps** setting no longer governs the Microsoft 365 Copilot app for any tenant worldwide. Every blocked user will click it at least once, which is why step 4 is not optional in a real rollout.

Steps 6 and 7 are the payoff, because nothing on the screen changed except the account. The shield is asserting enterprise data protection under the Data Protection Addendum and Product Terms for a Microsoft Entra sign-in; the consumer product carries the Microsoft Services Agreement instead. Ask the class which of the two windows they would paste a customer contract into, then ask how a user would know without being taught.

Step 8 is worth timing out loud. Integrated apps changes are documented to take up to 24 hours, and a rollback that takes a while to appear is exactly the situation in which a support engineer changes a second setting and loses the ability to explain what fixed it.

## Variation

Run the same lesson from the identity console instead. In the [Microsoft Entra admin center](https://entra.microsoft.com), go to **Entra ID** > **External Identities** > **Cross-tenant access settings**, add the Microsoft account tenant under **Organizational settings**, and set tenant restrictions v2 to block Microsoft account sign-in. Its identifier is the same public well-known value in every tenant and is documented by Microsoft; it is not a customer tenant ID, so look it up in the Learn article rather than reusing an ID from a demo tenant. Repeat step 7 on a managed device with signaling enabled: the personal sign-in fails outright instead of landing on consumer Copilot, which demonstrates that the durable fix for "which Copilot did they land in?" lives in identity, not in the Copilot admin surface.
