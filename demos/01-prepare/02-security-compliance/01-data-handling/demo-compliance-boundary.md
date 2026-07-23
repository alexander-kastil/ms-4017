# Hands-On Demo: Trace the compliance boundary

Goal: show that the compliance boundary is a setting, not a property of the product, by turning web grounding off and watching the same prompt produce a different answer shape.

Budget 15 minutes. You need a tenant administrator account and one licensed Copilot user.

## Steps

1. Sign in as the licensed user and open Microsoft 365 Copilot Chat. Ask a question that can only be answered from the public web, for example a current news question about a public company. Expected result: Copilot answers and the response carries web citations pointing at public URLs.

2. Ask a question that can only be answered from tenant content, for example a summary of a document only that user can reach. Expected result: Copilot answers with citations that link to items in SharePoint or OneDrive, not to public URLs.

3. As administrator, open the Microsoft 365 admin center and disable web search for Microsoft 365 Copilot and Copilot Chat. Expected result: the setting saves, with a note that changes take time to reach all users.

4. Wait for the setting to apply, then repeat the prompt from step 1 as the same user. Expected result: Copilot no longer returns web-grounded citations, and either answers from model knowledge alone or states it cannot find the information.

5. Repeat the prompt from step 2. Expected result: unchanged. Tenant grounding is unaffected, which is the point.

6. Ask the user to open the [My Account portal](https://myaccount.microsoft.com/) and view their Copilot activity history. Expected result: every prompt from this demo is listed, including the ones that returned nothing useful.

7. Delete the activity history from the same portal. Expected result: the entries disappear from the user view. Note for the class that this is the user-facing delete, and that the administrator-side story is covered in [03-compliance-governance](../03-compliance-governance/readme.md).

## Talking points

Step 4 is the moment worth pausing on. Nothing about the model changed and no data was moved. A single tenant setting decided whether a generated search query left the Microsoft 365 service boundary for the Bing Search service.

Step 5 is the counterweight. Customers frequently assume that disabling web search cripples Copilot. It does not touch grounding on their own content, which is the part they actually bought.

Step 6 usually surprises the room. Prompts that produced no answer are still interactions, still stored, and still discoverable.

## Variation

If the tenant uses the Microsoft 365 Apps privacy control for optional connected experiences, turn that off instead of the Copilot-specific control and repeat step 4. The outcome is the same, which demonstrates that two different administrators, working in two different consoles, can each close the boundary without telling the other.
