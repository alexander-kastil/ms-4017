# Hands-On Demo: Turn a Data Access Governance report into a site access review

Goal: show the full SharePoint Advanced Management loop, from an assessment score, to a report that names the overshared sites, to a review request that puts the remediation work on the site owner instead of the administrator.

Budget 20 minutes. You need a SharePoint Administrator and an active SharePoint Advanced Management subscription in the tenant.

## Steps

1. Sign in to the SharePoint admin center at `https://<tenant>-admin.sharepoint.com` and select **Advanced management** in the left navigation. Expected result: the **Advanced management** page opens with **Subscription status: Active** in the top right. If it reads anything else, the rest of this demo is unavailable and the licensing prerequisite is the lesson.

2. On the **Overview** tab, read the **Content management assessment** section. Expected result: either a green bar stating "Your results are ready. Explore the findings and take action today", or a **Restart assessment** button in the "Prepare for Copilot with SharePoint Advanced Management" banner if no assessment has run.

3. Scroll to the **Site lifecycle** card. Expected result: a headline count in the form "N sites require attention" with a **Last updated** date, a percentage dial, and a table of Issue type, Number of issues and Recommendations. Note the last-updated date out loud: this is a periodic snapshot, not a live view.

4. Switch to the **All features** tab. Expected result: a **What's included** table pairing each feature with its **Location** and **Purpose**, for example Data access governance reports at **Reports** > **Data access governance**, and Site-level access restriction at **Policies** > **Access control**. Use this table rather than memory when a customer asks where a feature lives.

5. Go to **Reports** > **Data access governance**. Expected result: the page opens on the **Reports** tab with two groups, **Snapshot reports** and **Activity reports**, and a second tab named **All review requests**.

6. Open **Site permissions across your organization**, tagged **RECOMMENDED**. Expected result: a report of sites carrying broad permissions such as Everyone except external users, guest access, sharing links and unique permissions, current as of the report generation date. Pick one site with a high count and keep it open.

7. Compare that with the activity reports by opening **Shared with 'Everyone except external users'**. Expected result: a list of sites with the most items shared with that claim over the last 28 days. Contrast the two: the snapshot answers "what is exposed right now", the activity report answers "what did people just do".

8. From the report, create a site access review for the site you picked and send it to its owners. Expected result: the request appears on the **All review requests** tab with a status, and the site owner receives it. The administrator has now delegated the permission decision to the person who knows why the permission exists.

9. Open **Reports** > **Agent insights**. Expected result: recently created agents and the sites hosting the most of them. Once a customer allows agent creation in SharePoint, this is the only report that makes agent sprawl visible.

## Talking points

Step 6 and step 7 together are the whole argument for these reports. Snapshot and activity reports answer different questions, and a customer who runs only one of them will either miss a long-standing exposure or miss the change that caused today's incident.

Step 8 is the part that scales. An administrator cannot judge whether a marketing site should really be shared with everyone in the company, and site access reviews exist because that judgement belongs to the owner. The administrator's job is to find the site and route the question.

The in-product **What's included** table in step 4 is shorter than the feature list on Microsoft Learn. Treat the portal as the authority for where something lives in this tenant, and Learn as the authority for what exists in the product, because the visible feature set moves with licensing and rollout.

## Variation

If the tenant has no meaningful oversharing to show, run **Reports** > **Site policy comparison** instead. Choose a well-governed site as the baseline and compare it against the rest of the tenant, then walk the differences. It makes the same governance point without depending on the tenant actually being messy.
