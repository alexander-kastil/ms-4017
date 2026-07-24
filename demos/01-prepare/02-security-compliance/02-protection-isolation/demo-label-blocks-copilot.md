# Hands-On Demo: Watch a sensitivity label block Copilot

Goal: prove Copilot enforces Microsoft Purview usage rights with no Copilot-side configuration, by labeling a document the test user lacks EXTRACT rights on.

[Sensitivity labels for Microsoft 365 Copilot](https://learn.microsoft.com/purview/sensitivity-labels#sensitivity-labels-for-microsoft-365-copilot-and-microsoft-365-copilot-chat) | [Copilot honors the EXTRACT usage right](https://learn.microsoft.com/purview/ai-m365-copilot-considerations#copilot-honors-existing-protection-with-the-extract-usage-right)

## Steps

1. In the Microsoft Purview portal, confirm [**Information protection**](https://purview.microsoft.com/informationprotection) has sensitivity labels enabled for Office files in SharePoint and OneDrive. Expected: the tenant setting is on and labels are listed (if off, stop and enable it).

2. In **Information protection** > [**Labels**](https://purview.microsoft.com/informationprotection/sensitivitylabels), publish or reuse a label that applies encryption and grant its usage rights to a group the test user is **not** in. Expected: the label appears in the Office label picker for the administrator.

3. Apply the label to one document in a SharePoint site the test user can browse. Expected: the document shows the label name and any header or footer marking, so the user can see the file exists but lacks EXTRACT on its contents.

4. As the test user, ask Microsoft 365 Copilot Chat a question this document is the only answer to. Expected: Copilot does not return the protected content; it answers from elsewhere or reports nothing found.

5. Have the user open the file directly in Word Online. Expected: access is blocked per the label, confirming the block is the label, not a Copilot quirk.

6. Add the test user to the group holding the label's usage rights, then wait for propagation. Expected: no immediate change (directory propagation is not instant).

7. Repeat the prompt from step 4, then open the citation. Expected: Copilot now answers and cites the document, and the cited original is still labeled and protected.
