# SharePoint Advanced Management

[SharePoint Advanced Management](https://learn.microsoft.com/en-us/sharepoint/advanced-management)

[SharePoint Advanced Management prerequisites](https://learn.microsoft.com/en-us/sharepoint/sharepoint-advanced-management-prerequisites)

- Managed in the [**SharePoint admin center**](https://admin.microsoft.com/sharepoint) (or `https://<tenant>-admin.sharepoint.com`) once the SAM license is assigned.

[Get ready for Microsoft 365 Copilot and agents with SharePoint Advanced Management](https://learn.microsoft.com/en-us/microsoft-365/copilot/get-ready-copilot-sharepoint-advanced-management)

Hands-On Demo: [Turn a Data Access Governance report into a site access review](demo-oversharing-report.md)

SharePoint Advanced Management (SAM) is the governance layer that makes a Copilot rollout defensible. Microsoft organizes it into three jobs: manage content sprawl, manage the content lifecycle, and prevent oversharing. Administrators work with it mainly in the SharePoint admin center, with PowerShell for bulk and reporting operations.

The oversharing group is the one that decides whether Copilot is safe to broaden. The others decide whether the tenant stays governable a year later.

## Manage content sprawl

- **Site ownership policy** defines who is accountable for each site, sets a minimum owner or admin count, and notifies when sites fall below it.
- **Inactive site policy** detects inactive sites and emails their owners.
- **Site attestations** ask owners to periodically confirm the site is still needed and that its owners, members, permissions and sharing settings are correct.

## Manage the content lifecycle

- **Catalog management** groups sites into logical categories by region, department, user, information barrier or custom property.
- **Change history reports** track changes to individual sites or to organization settings over the last 180 days.
- **Recent actions panel** shows changes an administrator made to a site's properties in the last 30 days, such as a rename, a deletion or a quota change.
- **Restrict site creation by apps** names the non-Microsoft applications allowed to create sites.

## Prevent oversharing

- **Restricted Content Discovery (RCD)** keeps high-risk sites and files out of Microsoft 365 Copilot and agentic experiences. This is the successor to Restricted SharePoint Search, covered in [04-restricted-search](../04-restricted-search/readme.md).
- **Restricted access control (RAC)** limits a SharePoint or OneDrive site to members of specific groups, so previously shared links stop resolving for everyone else.
- **Conditional Access policies** connect a Microsoft Entra Conditional Access policy to a site through an authentication context.
- **Block download policy** blocks moving or downloading files from SharePoint and OneDrive sites and from Teams meeting recordings, while leaving the Office web apps usable.
- **Content management assessment** is the hub that scores current practice and recommends actions.
- **Data Access Governance (DAG) reports** at **Reports** > **Data access governance** surface sites that may hold overshared or sensitive content. The portal splits them into two groups. Snapshot reports:
  - **Site permissions across your organization**, tagged RECOMMENDED
  - **Site permissions for users**, tagged NEW
  - **Sensitivity labels applied to files**

  Activity reports, both covering the last 28 days:
  - **Sharing links**
  - **Shared with 'Everyone except external users'**
- **Site access reviews** delegate the review of a DAG report to the owners of the overshared sites.
- **Site policy comparison** takes one or more sites as a baseline and compares up to 10,000 target sites using AI.
- **AI insights** sits next to the reports in the admin center and turns a report into a list of suggested actions.
- **App insights** shows which non-Microsoft applications registered in Microsoft Entra are reaching SharePoint content.
- **Insights on agents in SharePoint** lists recently created agents and the sites with the most of them.
- **Agent access insights** show how agents are interacting with SharePoint and OneDrive content.
- **OneDrive access restriction** limits OneDrive access by security group, tenant-wide or for one user's OneDrive.
- **Restricted site creation** designates who may create SharePoint or OneDrive sites, using security groups and PowerShell.

The two agent reports are new relative to earlier versions of this course and are worth demonstrating. Once a customer allows agent creation in SharePoint, agent sprawl becomes its own governance problem, and these are the only reports that make it visible.

The **SharePoint Admin Agent** is the productivity layer over all of this, and is a reasonable place to start a demo because it explains its own findings in natural language.

## Stewardship rules

Governance tooling only works if someone owns the outcome. Use these as the discussion frame when a customer asks who should be running the reports above.

1. **Role responsibilities.** Define what a data steward is accountable for, such as data quality, metadata management and compliance, and clarify the scope of their authority.
2. **Data quality standards.** Set expectations for accuracy, completeness, consistency and timeliness, and outline how issues get identified and corrected.
3. **Documentation and metadata management.** Require up-to-date metadata and data dictionaries, and track lineage and provenance.
4. **Compliance and security.** Align data handling with internal policy and external regulation such as GDPR and HIPAA, and define handling for sensitive or restricted data.
5. **Change management.** Establish protocols for changes to data definitions, structures or usage, with impact assessments and stakeholder communication.
6. **Monitoring and reporting.** Set expectations for regular audits and quality checks, and define KPIs for stewardship performance.
7. **Collaboration and escalation.** Define how stewards work with data owners, IT and compliance, and provide an escalation path.
