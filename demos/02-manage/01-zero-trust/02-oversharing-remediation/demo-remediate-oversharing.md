# Hands-On Demo: Make a labeled document disappear from Copilot without changing a permission

Goal: prove that discoverability and permissions are two independent dials, by asking Microsoft 365 Copilot the same question before and after applying Restricted Content Discovery and a DLP policy, and then having the same user open the file that Copilot can no longer read.

Budget 15 minutes, plus up to four hours of policy propagation between step 6 and step 7. You need a SharePoint Administrator with SharePoint Advanced Management available (included with Microsoft 365 Copilot licences), a Microsoft Purview account holding the Purview Data Security AI Admin role or equivalent, a published **Highly Confidential** sensitivity label, and one licensed Microsoft 365 Copilot user who is not an administrator.

## Steps

1. Sign in as the licensed user, open a SharePoint site you can dedicate to the demo, and upload a document containing a distinctive fact nobody could answer from general knowledge, for example a line reading `Project Northwind margin target for FY27 is 41.5 percent`. Apply the **Highly Confidential** sensitivity label from the ribbon. Expected result: the label name shows in the document's sensitivity indicator and the file appears in the library with the label column populated.

2. As the same user, open [**Microsoft 365 Copilot Chat**](https://m365.cloud.microsoft/chat) and ask `What is the Project Northwind margin target for FY27?`. Expected result: Copilot states the 41.5 percent figure in the answer body and shows a numbered citation linking to the uploaded document. Screenshot this; it is the "before" half of the transcript.

3. As the Microsoft Purview administrator, open the Microsoft Purview portal and go to **DSPM** > [**Discover**](https://purview.microsoft.com) > **Data risk assessments**. Choose **View details** on the default assessment, select the demo site in the list, and read the **Monitor** tab. The default assessment only covers the top 100 SharePoint sites by usage, so if the demo site is absent use **Create custom assessment** and scope it to that site. Expected result: the flyout reports counts for items shared with anyone, with everyone in the organization, with specific people, and externally, giving you the exposure number you are about to act on.

4. As the SharePoint Administrator, open the [**SharePoint admin center**](https://admin.microsoft.com/sharepoint), expand **Sites** > **Active sites**, select the demo site, open the **Settings** tab, and turn **Restrict content from Microsoft 365 Copilot** on. Select **Save**. Expected result: the site row gains a **Restricted** tag in the Active sites list.

5. Confirm the setting landed on the site object by running the following in the SharePoint Online PowerShell module, substituting your own site URL for the placeholder.

   ```powershell
   Get-SPOSite -Identity https://contoso.sharepoint.com/sites/northwind | Select RestrictContentOrgWideSearch
   ```

   Expected result: the command returns `RestrictContentOrgWideSearch : True`.

6. Back in the Microsoft Purview portal, go to **Data Loss Prevention** > [**Policies**](https://purview.microsoft.com) > **+ Create policy**, choose the **Custom** template and **Custom policy**, and on the **Locations** page turn the **Microsoft 365 Copilot and Copilot Chat** location on. Add one rule with the condition **Content contains** > **Sensitivity labels** > **Highly Confidential** and the action **Prevent Copilot from processing content**. Name it `Block Highly Confidential from Copilot grounding`, finish the wizard with the policy turned on rather than in simulation mode. Expected result: every other location greys out as soon as the Copilot location is selected, and the policy lands in the list with a status of **On**.

7. After the propagation window, sign back in as the licensed user and repeat the exact prompt from step 2. Expected result: the 41.5 percent figure is absent from the answer body, and Copilot either says it cannot find the information or answers generically, while the document may still be listed as a citation. That surviving citation is the point, not a bug.

8. As the same user and in the same browser session, click through to the document and open it. Expected result: the file opens normally with full content, because nothing in steps 4 through 6 removed a single permission. Also note that the site's Copilot button and AI actions menu are now gone, which is Restricted Content Discovery, not DLP.

## Talking points

Step 7 is the moment the demo exists for. Two controls acted on the same file through two entirely different mechanisms: Restricted Content Discovery stopped the site being reachable through organization-wide discovery, and DLP stopped the item's content being used to compose a response. Neither one asked SharePoint who is allowed to read the file, and neither one is a permission change you could find in a site's Advanced permissions page.

The surviving citation in step 7 is the detail that ends up in a customer's risk register. DLP for the Copilot location excludes the item's content from the response summary but the item can still appear in the citations, so the file name and its existence are still disclosed. If the file name itself is the sensitive fact (`Q3 Layoff List.xlsx`), DLP is the wrong control and site-level Restricted Content Discovery is the right one. Ask the room which of their real documents fail that test.

Step 8 is the counterweight, and it is what makes both controls safe to deploy on day one of a remediation project. Nobody loses access, nobody's existing workflow breaks, and no site owner has to be consulted first. That is exactly why Microsoft sequences these as interim protections applied before permission remediation begins, and why the guidance says to remove them once access has actually been fixed.

## Variation

Drive the same outcome from the Microsoft Purview portal alone. In **DSPM** > **Discover** > **Data risk assessments**, open the demo site's flyout and use the **Protect** tab, which offers **Restrict access by label** (which creates the same DLP policy for the Microsoft 365 Copilot and Copilot Chat location) and **Restrict all items** (which applies SharePoint Restricted Content Discovery to the site). Reaching identical settings from the assessment that found the problem teaches the loop as one workflow rather than three consoles, and it shows the class that the Microsoft Purview administrator can apply a SharePoint control without ever opening the SharePoint admin center.
