# Stop Copilot answering from your most sensitive files

A sensitivity label classifies content; it does not decide what Microsoft 365 Copilot is allowed to read. The control that decides that is a Microsoft Purview data loss prevention policy scoped to the Copilot location, and the place you prove it worked is Data Security Posture Management. This topic covers both halves, and the operational cost of getting the scope wrong.

## The console moved, and the old one is still there to catch you

Microsoft Purview now ships a single, unified **Data Security Posture Management** solution at Microsoft Purview portal > **Solutions** > [**DSPM**](https://purview.microsoft.com/). The two things most people were trained on, DSPM and DSPM for AI, still exist but are renamed **Data Security Posture Management (classic)** and **DSPM for AI (classic)**. Learn is blunt about the consequence: most new capability lands only in the current version. If a student follows an eighteen-month-old blog post into the classic blade, everything looks familiar and nothing new is there.

The current solution is organized around pages rather than around products. **Posture** is the landing dashboard with key metrics, the highest-risk objectives, and a 30-day trend. **Objectives** holds the guided workflows. **AI observability** inventories every AI app and agent with activity in the last 30 days, flags how many are high risk, and shows which policies govern each one.

Under **Discover** you find **Apps and agents**, **Activity explorer**, and **Data risk assessments**. **Tasks and actions** and **Reports** round out the navigation.

First use prompts you to accept setup tasks if the tenant has not already turned them on, and you should allow roughly a day before real tenant data appears. In a demo tenant that delay is the single most common reason a live walkthrough falls flat, so turn DSPM on before the class, not during it.

## Objectives replace solution-hopping

The genuinely new idea in the current DSPM is the **data security objective**. Instead of asking an admin to visit Information Protection, then data loss prevention, then Insider Risk Management, then eDiscovery and mentally stitch the result together, an objective is a card that represents an outcome and pulls the relevant solutions into one workflow. The one this module cares about is **Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions**; siblings include **Prevent oversharing of sensitive data**, **Prevent exfiltration to risky locations**, and **Discover sensitive data in your organization**.

Each objective card shows outcome metrics: percentage of data covered by policies, number of risky sharing incidents, improvement over time. Inside, you get prioritized actions with **one-click policies** that create the underlying DLP, labeling, or Insider Risk policy for you.

This is the part worth teaching as a judgement skill rather than a click path. A one-click policy is a real policy with real scope, and DSPM creates several of them in full enforcement across the whole organization rather than in simulation. Knowing what the button just did is the difference between a controlled rollout and an unannounced production change.

The complementary surface is **Discover** > **Data risk assessments**. A default assessment runs weekly over the top 100 SharePoint sites by usage, and the per-site flyout has **Overview**, **Identify**, **Protect**, and **Monitor** tabs. The **Protect** tab is where the two worlds join: **Restrict access by label** creates exactly the DLP policy this subtopic builds by hand, and **Restrict all items** hands you off to SharePoint Restricted Content Discovery instead.

## What the Copilot DLP location actually enforces

Sensitivity labels alone do not change Copilot behavior for a user who already has access. Copilot runs every prompt in the security context of the caller, so a user with **View** rights on a Highly Confidential file can have it summarized unless something else intervenes. The something else is a Microsoft Purview data loss prevention policy scoped to the **Microsoft 365 Copilot and Copilot Chat** policy location, which is available only in the **Custom** template, and selecting it disables every other location in that policy.

Four condition and action pairs are supported, and they do genuinely different things:

| Condition | Action | Effect |
| --- | --- | --- |
| **Content contains** > **Sensitivity labels** | **Prevent Copilot from processing content** | The labeled file or email is not read into the response. The item can still appear in citations. |
| **Content contains** > **Sensitive information types** | **Prevent Copilot from processing content** > **Processing prompts** | Copilot returns no response at all, and the prompt is used for neither internal nor web search. |
| **Content contains** > **Sensitive information types** | **Prevent Copilot from processing content** > **Performing Web Searches** | Only web grounding is blocked for that prompt; internal grounding continues. |
| **Email is received from** > **External users** | **Prevent Copilot from processing content** | External mail is excluded from grounding, summarization, and citation. Only sender metadata is evaluated, never the body. |

One constraint trips up almost everyone on the first attempt: you cannot combine the sensitivity-label condition and the sensitive-information-type condition in the same rule. Put them in two rules inside one policy. The label rule covers stored files and files that are actively open, plus email sent on or after January 1, 2025, but not calendar invites. Files a user uploads directly into a prompt are not scanned at all; DLP only inspects the text the user typed.

Creating or editing a policy for this location needs one of a short list of roles, and the interesting one is **Purview Data Security AI Admin**, which can edit Copilot-related DLP policies and view AI content in DSPM but explicitly cannot read the prompts and responses of AI interactions. **Microsoft Entra AI Admin**, **Purview Compliance Administrator**, **Purview Information Protection Admin**, and **Purview Security Administrator** also qualify. Reaching for Global Administrator here is a habit worth breaking in front of the class.

## Simulation, propagation, and the citation that still shows up

The Copilot location supports DLP alerts, notifications, and **policy simulation mode**, and the last step of the creation wizard is where you choose **Run the policy in simulation mode**, **Turn it on right away**, or **Keep it off**. Simulation runs the policy as though it were enforced but takes no action, and reports matches in a separate dashboard reached from **Data Loss Prevention** > **Policies** > **View simulation**, with **Simulation overview**, **Items for review**, and **Alerts** tabs. A simulation runs for up to 15 days, results are kept for 30, and you can tell it to turn itself on if it is not edited within fifteen days.

Two timing facts decide whether the demo works. Updates to a policy for this location can take **up to four hours** to reach the Copilot experience. Separately, in Word, Excel, and PowerPoint the policy is evaluated **at file open**: if you apply the label to a document that is already open, enforcement starts the next time that file is opened, and until then the Copilot skills in the app keep working.

Then there is the behavior that reliably produces an objection from the room. The blocked item still appears in the citations of a response. That is by design and it is not a leak: Copilot names the item it could not use, but does not read its content into the answer.

The user could always have opened that file directly, because DLP for this location does not remove access; it removes processing. Say that out loud before someone in the room says it for you.

## What breaks, and the trade-off you are actually making

Turn this on too broadly and Copilot gets quiet in exactly the places people expected the most value. Label a whole legal or finance library Highly Confidential, block it from processing, and Copilot in Word stops offering to draft from those documents, meeting recaps stop reasoning over the attached deck, and the enterprise search value of the tool drops for the people who own the most valuable content. Nothing has failed, and there is no error to troubleshoot; the product just quietly becomes less useful, which is a much harder support call than an outright block.

Turn it on too narrowly and the label taxonomy becomes decoration. This is the operational half of the story that [Examine data security and compliance in Microsoft 365 Copilot](../../../01-prepare/02-security-compliance/readme.md) sets up: the security model explains VIEW and EXTRACT usage rights on a label, but an admin does not get to prove anything with a rights descriptor. Building a policy, simulating it, enforcing it, and then finding the resulting **DLP rule match** event on the **AI activities** tab of Activity explorer is what turns a taxonomy into a control you can evidence to an auditor.

The right sequencing is boring and works: simulate first, review **Items for review**, expand scope only after the false-positive rate is understood, and pair the block with a reason people can act on. DLP for the Copilot location is a stopgap that buys time while permissions and oversharing get fixed properly. It is not a substitute for that work.

## Discussion questions

- The default weekly data risk assessment flags a SharePoint site with sensitive data and anonymous links. You can restrict it by label with DLP, exempt it entirely with Restricted Content Discovery, or fix the permissions. Which do you do first, and what do you tell the site owner?
- Legal insists that Highly Confidential files must never be referenced by Copilot in any way. DLP for this location still returns those items as citations. Do you accept that, add Restricted Content Discovery on top, or fix it at the permission layer, and what does each choice cost?
- A one-click policy from the objective card would create the DLP policy in enforcement across the whole tenant in about a minute. Building it by hand in simulation takes an hour and a two-week soak. Under what tenant conditions is the one-click path the responsible choice?

## Sources

[Learn about using Microsoft Purview Data Loss Prevention to protect interactions with Microsoft 365 Copilot and Copilot Chat](https://learn.microsoft.com/en-us/purview/dlp-microsoft365-copilot-location-learn-about)

[Learn about Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-learn-about)

[Prevent oversharing with data risk assessments from Data Security Posture Management](https://learn.microsoft.com/en-us/purview/data-security-posture-management-oversharing)

[Learn about data loss prevention simulation mode](https://learn.microsoft.com/en-us/purview/dlp-simulation-mode-learn)

[Configure a secure and governed foundation for Microsoft 365 Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/configure-secure-governed-data-foundation-microsoft-365-copilot)

## Hands-On

[Build a DLP policy that makes Copilot refuse to summarize a Highly Confidential document](demo-dlp-blocks-copilot-processing.md)
