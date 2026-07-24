# Hands-On Demo: Turn a Data Access Governance report into a site access review

Goal: run the SharePoint Advanced Management loop, from assessment score to a Data Access Governance report that names overshared sites to a site access review that puts remediation on the site owner.

[Data access governance reports for SharePoint sites](https://learn.microsoft.com/en-us/sharepoint/data-access-governance-reports)
[Site access reviews for Data access governance reports](https://learn.microsoft.com/en-us/sharepoint/site-access-review)

## Steps

1. In the [SharePoint admin center](https://admin.microsoft.com/sharepoint) (`https://<tenant>-admin.sharepoint.com`) select **Advanced management**. Expected: the page opens with **Subscription status: Active**; anything else means the licensing prerequisite is unmet.

2. On the **Overview** tab read the **Content management assessment** and **Site lifecycle** card. Expected: an "N sites require attention" count with a **Last updated** date (a periodic snapshot, not live).

3. Open **Reports** > **Data access governance**. Expected: the **Reports** tab shows **Snapshot reports** and **Activity reports**, plus an **All review requests** tab.

4. Open **Site permissions across your organization** (tagged **RECOMMENDED**), pick one high-count site and keep it open. Expected: a report of sites with broad permissions (Everyone except external users, guest access, sharing links, unique permissions).

5. Open the activity report **Shared with 'Everyone except external users'**. Expected: sites with the most items shared with that claim over the last 28 days (what people just did vs what the snapshot shows is exposed now).

6. From the report create a site access review for the site you picked and send it to its owners. Expected: the request appears on the **All review requests** tab and the owner receives it.

7. Open **Reports** > **Agent insights**. Expected: recently created agents and the sites hosting the most of them (the only report that makes agent sprawl visible).
