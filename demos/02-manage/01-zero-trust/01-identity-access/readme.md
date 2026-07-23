# Stop Copilot at the front door with Conditional Access

[Apply principles of Zero Trust to Microsoft 365 Copilot](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-365-copilot)

[Apply principles of Zero Trust to Microsoft 365 Copilot Chat](https://learn.microsoft.com/en-us/security/zero-trust/copilots/zero-trust-microsoft-copilot)

[Use Zero Trust security to prepare for AI companions](https://learn.microsoft.com/en-us/security/zero-trust/copilots/apply-zero-trust-copilots-overview)

[Common security policies for Microsoft 365](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/zero-trust-identity-device-access-policies-common)

Hands-On Demo: [Block Copilot on a non-compliant device with Conditional Access](demo-conditional-access-for-copilot.md)

The Zero Trust guidance for Microsoft 365 Copilot is a seven-step article: data protection, identity and access, App Protection, device management, threat protection, secure Teams collaboration, and user permissions to data. This topic takes two of those steps, step 2 (identity and access) and step 4 (device management and protection), and turns them into something a student actually builds. [Module 01](../../../01-prepare/02-security-compliance/readme.md) explains that Copilot inherits the Microsoft 365 security model. Here the class proves it, by hardening Copilot with a policy that contains the word "Copilot" nowhere in it.

## Which resource the policy must target

The instinct is to open Conditional Access, search the resource picker for "Copilot", tick whatever appears, and call the job done. That policy will be thin. Microsoft 365 Copilot is not one endpoint: a grounded prompt fans out into Microsoft Graph, Exchange Online, SharePoint Online, and the Office 365 service group, and the token requests that carry the grounding data are issued for those resources, not for a Copilot front end. Microsoft Graph is explicitly not individually targetable in Conditional Access at all, because it functions as an umbrella resource.

That is why Microsoft's guidance for generative AI services is to target **All resources (formerly 'All cloud apps')** with no resource exclusions, rather than to hunt for a Copilot app. The same guidance appears in the [Conditional Access target resources reference](https://learn.microsoft.com/en-us/entra/identity/conditional-access/concept-conditional-access-cloud-apps#conditional-access-for-all-resources) and in the [Security Copilot troubleshooting article](https://learn.microsoft.com/en-us/entra/identity/conditional-access/troubleshoot-security-copilot-policies). Where a narrower scope is genuinely required, target the **Office 365** app grouping instead of individual child apps, so that [service dependencies](https://learn.microsoft.com/en-us/entra/identity/conditional-access/service-dependencies) do not leave a gap between Teams and the Exchange or SharePoint data it reaches.

There is a dated caveat worth saying out loud in class. Historically, an **All resources** policy that carried any resource exclusion silently skipped enforcement for a set of low-privilege scopes such as `openid`, `profile`, and `User.Read`. Microsoft is removing that carve-out in phases starting March 2026, so tenants that built exclusions on the old behavior will start seeing Conditional Access challenges where users previously sailed through.

## The two protection tiers, mapped onto a Copilot rollout

The [common security policies](https://learn.microsoft.com/en-us/microsoft-365/security/office-365-security/zero-trust-identity-device-access-policies-common) article groups its recommendations into three levels: starting point, Enterprise, and Specialized security. Starting point is multifactor authentication on sign-in risk, blocking clients that do not support modern authentication, forcing a password change for high-risk users, and Microsoft Intune App Protection policies on mobile. The Enterprise tier is where device compliance enters: define Intune compliance policies per platform, then require compliant PCs and mobile devices. Specialized security adds one thing, MFA on every single sign-in, aimed at a named group rather than the whole tenant.

For a Copilot rollout the useful mapping is blunt. Everyone who gets a Copilot license should already be at Enterprise, because that is the tier where a stolen password stops being sufficient to make Copilot summarize the company's data on an attacker's laptop. Specialized is reserved for the group whose content would hurt most in a summary, typically the same executive or project group you would put behind a sensitivity label.

Two prerequisites in that article are the ones people trip over. Every group used for these policies must be a **Microsoft 365 Group**, not a security group, because the same groups are later used to deploy sensitivity labels. And Intune app protection and device compliance policies can be assigned to groups only, while Conditional Access policies can also be assigned to users and directory roles.

## Device compliance is the grant control, not a separate project

Intune enrollment and Intune compliance policies do nothing to access on their own. A compliance policy in the Microsoft Intune admin center under **Devices** > [**Compliance**](https://intune.microsoft.com/#view/Microsoft_Intune_DeviceSettings/DevicesMenu/~/compliance) > **Create policy** evaluates a device and marks it compliant or non-compliant; that is the entire effect. The enforcement happens in Microsoft Entra ID, when a Conditional Access policy created under **Entra ID** > **Conditional Access** > [**Policies**](https://entra.microsoft.com/#view/Microsoft_AAD_ConditionalAccess/ConditionalAccessBlade/~/Policies) sets **Access controls** > **Grant** > **Require device to be marked as compliant**. Without the Conditional Access half, you have a very well-informed dashboard and zero controls.

The recommended Windows compliance baseline is concrete enough to teach from. Under **Device health** it requires BitLocker, Secure Boot, and code integrity; under **System security** it requires encryption, firewall, antivirus, antispyware, Microsoft Defender anti-malware with up-to-date signatures, and real-time protection; and where Microsoft Defender for Endpoint is deployed, it requires the device to sit at or under a **Medium** machine risk score. That last setting is the one that turns compliance from a static checklist into a live signal: a device that gets compromised at 11:00 drops out of compliance, and Copilot access goes with it.

Two behaviors of **Require device to be marked as compliant** prevent a bootstrapping deadlock. It does not block Intune enrollment, so a new device can still enroll under an all-users policy. It also does not block the Microsoft Authenticator app from reading `UserAuthenticationMethod.Read` during registration, so users can still set up MFA. What it will do, cheerfully, is lock out the administrator who forgot to check their own device before flipping the toggle, which is why the emergency access accounts must be excluded first.

## App Protection: the containment layer for unmanaged devices

Requiring a compliant device answers "may this device connect?". It does not answer "what happens to the answer once it is on screen?". Intune App Protection policies (APP) are the containment layer, and they work even on devices the organization does not manage: Intune builds a wall between organization data and personal data inside the app itself. Applied to Copilot, APP prevents Copilot-generated content from being copied and pasted into apps that are not on the permitted list, which is the difference between an attacker on a compromised phone reading one summary and exfiltrating a hundred.

APP needs its own Conditional Access half too. Creating the app protection policies in Microsoft Intune is step one; the enforcement comes from the **Require app protection policy** grant control under **Access controls** > **Grant**, and Microsoft ships three template levels. Level 1 is enterprise basic data protection, Level 2 is enterprise enhanced (the recommended default for most mobile users touching work data), and Level 3 is enterprise high, for uniquely high-risk users. Most organizations should be deploying Level 2 and Level 3, not Level 1.

The trade-off is user-visible and worth naming before rollout. APP restrictions land on the copy and paste path, which is the exact path a user takes when Copilot has just written something useful. Deploy it without telling people, and the helpdesk hears about it the same afternoon. One dated detail belongs in the same breath: the older **Require approved client app** grant retires in early March 2026, so new policies should carry **Require app protection policy** on its own.

## Edge page summarization is a separate switch

Microsoft 365 Copilot Chat has a second data path that neither compliance nor APP closes: browser page summarization in the Microsoft Edge sidebar. When it is on, Copilot in Edge can summarize intranet SharePoint sites (though not embedded Office documents), Outlook Web App, PDFs including ones stored locally on the device, and any site that is not protected by a Microsoft Purview data loss prevention policy, a mobile application management policy, or an MDM policy. That list is the attack surface, and it includes content on virtual machines and third-party SaaS sites.

The control is a single group policy setting, `EdgeEntraCopilotPageContext`, documented under [Manage Copilot Chat in Edge](https://learn.microsoft.com/en-us/copilot/manage#manage--chat-in-edge). Microsoft's staged model is deliberate: stage 1 is web-grounded prompts with summarization off and identity and device policies in place, and stage 2 re-enables summarization only once Purview protections, minimum user permissions, and Microsoft Defender for Cloud Apps are in place. Treat the setting as the gate between those two stages rather than as a browser preference, because it is the switch that decides whether local and intranet content is in scope for Copilot at all.

## Discussion questions

- A security team proposes a Conditional Access policy scoped only to the Copilot app so that "we do not disturb anything else". Where does that policy fail, and what would you have to prove to them to change their mind?
- Your executives are on the Specialized tier and complain about MFA on every sign-in, while an audit finds most of them already use Windows Hello for Business. Do you drop the tier, change the authentication method, or narrow the group, and what do you lose in each case?
- A contractor population uses unmanaged personal laptops and cannot be enrolled in Intune. Do you block Copilot for them with a compliance grant control, contain them with App Protection policies, or turn `EdgeEntraCopilotPageContext` off for that group, and how do you defend the choice to their manager?
