# Hands-On Demo: Watch a sensitivity label block Copilot

Goal: prove that Copilot enforces Microsoft Purview usage rights, and that nothing about Copilot itself had to be configured to make that happen.

Budget 20 minutes. You need a tenant administrator account and one licensed Copilot user who is not a member of the group you will grant rights to.

## Setup

1. In the Microsoft Purview portal, confirm sensitivity labels are enabled for Office files in SharePoint and OneDrive. Expected result: the tenant setting is on and existing labels are listed. If it is off, stop and enable it, because the rest of the demo cannot work.

2. Publish or reuse a label that applies encryption, and grant its usage rights to a group the test user is **not** in. Expected result: the label appears in the Office label picker for the administrator.

3. Apply the label to one document in a SharePoint site the test user can otherwise browse. Expected result: the document shows the label name and any configured header or footer marking.

Note the asymmetry you just created: the user can reach the site and see the file exists, but lacks the label's usage rights on its contents.

## The demonstration

4. As the test user, ask Microsoft 365 Copilot Chat a question that this document is the only possible answer to. Expected result: Copilot does not return the protected content. It answers from something else or reports that it found nothing.

5. Have the user open the file directly in Word Online. Expected result: access is blocked or restricted according to the label, which confirms the block came from the label and not from a Copilot quirk.

6. Add the test user to the group that holds the label's usage rights, then wait for propagation. Expected result: no immediate change; propagation across the federated directory is not instant.

7. Repeat the prompt from step 4. Expected result: Copilot now answers and cites the document. Open the citation. Expected result: the original file is still labeled and still protected. The citation did not strip anything.

## Talking points

Step 4 is the argument for the whole Purview investment. Nothing about Copilot was configured to produce that block. The label did it, and it would have done it for search and eDiscovery too.

Step 6 is worth being honest about in front of a class. Permission and rights changes propagate on their own schedule, and a demo that appears to fail is usually a demo that was rushed. Fill the gap by explaining the federated directory model from [the topic readme](readme.md).

Step 7 addresses the question every security officer asks: does a Copilot response launder protected content into an unprotected form? It does not. Generated content can inherit the most restrictive label from its sources, and the cited original keeps its own protection regardless.

## Variations worth showing if time allows

- Send the test user an S/MIME protected mail and ask Copilot to summarize the mailbox. Expected result: that message is never returned, and Copilot is unavailable in Outlook while it is open.
- Upload a password-protected document and prompt against it. Expected result: unreachable unless the user already has it open in the same app.
- Remove EXTRACT but keep VIEW on the label. Expected result: the user can open the document by hand, but Copilot still will not summarize it. This is the cleanest illustration of why both rights matter.
