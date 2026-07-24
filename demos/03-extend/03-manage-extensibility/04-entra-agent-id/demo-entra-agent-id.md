# Hands-On Demo: Give an agent a governed identity

Goal: prove an agent is a first-class Entra identity you can inspect, sponsor, and gate with Conditional Access.

Prerequisite: a licensed tenant with at least one agent identity provisioned; Entra agent-identity governance is in preview.

[Govern agent identities with Microsoft Entra](https://learn.microsoft.com/en-us/entra/id-governance/agent-id-governance-overview)

[Conditional Access for agent identities](https://learn.microsoft.com/en-us/entra/identity/conditional-access/agent-id)

[Agent registry convergence in Microsoft Entra](https://learn.microsoft.com/en-us/entra/agent-id/agent-registry-convergence)

## Steps

1. As admin, in the [Microsoft Entra admin center](https://entra.microsoft.com) open **Entra ID** > **Agent identities** and select an agent identity. Expected: the identity page opens with its created date and Entra-enabled status.

2. On the identity page, note the **agent identity blueprint** it derives from. Expected: every derived agent inherits the blueprint's configuration and permissions.

3. Confirm the human **sponsor** assigned to the agent identity. Expected: a named user is accountable for the agent's lifecycle and access.

4. In the [Microsoft Entra admin center](https://entra.microsoft.com) open **Entra ID** > **Conditional Access** > **Policies** and create a policy. Expected: the new-policy blade opens.

5. Under **Target resources**, target agent identities (or their blueprint), then under **Conditions** add agent identity risk and under **Grant** select **Block access**. Expected: the policy blocks high-risk agents while leaving compliant agents unaffected.

6. Set the policy to **On** and save. Expected: the policy applies to all agent identities in scope, including future agents derived from the targeted blueprint.
