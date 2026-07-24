# Hands-On Demo: Make a labeled document disappear from Copilot without changing a permission

Goal: prove discoverability and permissions are independent dials, by asking Copilot the same question before and after Restricted Content Discovery plus a DLP policy, then opening the file the same user can still read.

[Restrict discovery of SharePoint sites and content](https://learn.microsoft.com/sharepoint/restricted-content-discovery) | [DLP for the Microsoft 365 Copilot location](https://learn.microsoft.com/purview/dlp-microsoft365-copilot-location-learn-about)

## Steps

1. As the licensed user, upload a document with a distinctive fact to a demo SharePoint site, for example a line reading `Project Northwind margin target for FY27 is 41.5 percent`, and apply the **Highly Confidential** sensitivity label from the ribbon. Expected: the label shows in the sensitivity indicator and the library's label column.

2. As the same user, open [**Microsoft 365 Copilot Chat**](https://m365.cloud.microsoft/chat) and ask `What is the Project Northwind margin target for FY27?`. Expected: Copilot states 41.5 percent with a numbered citation to the document. Screenshot this "before" state.

3. As the Purview administrator, in the Microsoft Purview portal open **DSPM** > [**Data risk assessments**](https://purview.microsoft.com/datasecurityposturemanagement), choose **View details** on the default assessment, and read the demo site's **Monitor** tab. The default assessment covers only the top 100 sites by usage, so if the site is absent use **Create custom assessment** scoped to it. Expected: the flyout reports the exposure counts (shared with anyone, everyone, specific people, externally).

4. As the SharePoint Administrator, in the [**SharePoint admin center**](https://admin.microsoft.com/sharepoint) open **Sites** > **Active sites**, select the demo site, open the **Settings** tab, turn **Restrict content from Microsoft 365 Copilot** on, and **Save**. Expected: the site row gains a **Restricted** tag.

5. Confirm the setting on the site object with the SharePoint Online PowerShell module, substituting your site URL.

   ```powershell
   Get-SPOSite -Identity https://contoso.sharepoint.com/sites/northwind | Select RestrictContentOrgWideSearch
   ```

   Expected: the command returns `RestrictContentOrgWideSearch : True`.

6. Back in Purview open **Data Loss Prevention** > [**Policies**](https://purview.microsoft.com/datalossprevention) > **+ Create policy**, choose **Custom** > **Custom policy**, on **Locations** turn on **Microsoft 365 Copilot and Copilot Chat**, add a rule with condition **Content contains** > **Sensitivity labels** > **Highly Confidential** and action **Prevent Copilot from processing content**, name it `Block Highly Confidential from Copilot grounding`, and finish with the policy on. Expected: every other location greys out and the policy lands with status **On**.

7. After the propagation window (up to four hours), sign back in as the licensed user and repeat the exact prompt from step 2. Expected: the 41.5 percent figure is absent and Copilot cannot find it or answers generically, while the document may still appear as a citation (that surviving citation is the point).

8. As the same user in the same session, click through to the document and open it. Expected: the file opens with full content because no permission was removed, and the site's Copilot button and AI actions menu are gone (Restricted Content Discovery, not DLP).
