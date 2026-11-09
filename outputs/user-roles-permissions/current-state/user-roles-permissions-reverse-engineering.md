# Atlas user and roles management: PRD vs. today

Reviewed: 5 November 2026. Compared the supplied PRD with Atlas source code. Production behavior was not tested.

**Atlas already has login, permission checks, and basic user management. The main missing piece is controlling which portfolios each user can access.**

## What exists and what is missing

Each row compares the same capability. “Not verified” means we do not yet know whether Atlas meets it.

| Capability | Required by the PRD | Atlas today |
| --- | --- | --- |
| Access to other organizations | Users cannot access another organization's data. | Organization restrictions exist. Blocking access in every workflow is not verified. [E1] |
| Access to portfolios | Users can access only portfolios assigned to them. | Access is checked for the organization, without restricting each user to assigned portfolios. [E1] |
| Access to Monitoring | Users need Monitoring permission for each portfolio. | Per-user Monitoring permission for each portfolio is missing from the reviewed access checks. [E1][E8] |
| Invite users | Internal admins can invite users. | Users can be invited. Restricting invitations to internal admins is not established. [E4][E10] |
| Assign roles | Internal admins can assign a user's role. | Role assignment in the user-management screen is unfinished. [E6] |
| Assign portfolios and products | Internal admins can assign a user's portfolios and products. | The invitation flow does not assign portfolios or products. [E4][E6] |
| Activate invited users | Users can accept a valid invitation and access their assigned portfolios. | Invitation exists. Acceptance within the validity period and access to assigned portfolios are not verified. [E4] |
| Deactivate users | Deactivated users lose access on their next request. | Immediate loss of access after deactivation is not implemented in the reviewed user-management flow. [E4] |
| Merchant uploads | Users can upload merchants only with permission for that portfolio and Monitoring. | Upload permission checks exist, but the required per-user portfolio and Monitoring restrictions are incomplete. [E1][E7] |
| View findings | Users can view findings only with permission for that portfolio and Monitoring. | Some reviewed findings-viewing flows lack the required permission checks. [E8][E15] |
| Update finding resolutions | Users can update resolutions only when their role allows it in that portfolio. | Some reviewed resolution-update flows lack the required permission checks. [E15] |
| Approve high-risk actions | Authorized Risk Managers can approve high-risk actions. | Approval by authorized Risk Managers is not verified. The PRD also needs to define which actions require approval. |
| Download reports | Reports contain data only from portfolios the user can access. | Restricting report contents to the user's assigned portfolios is not verified. [E17] |
| Record admin changes and denied actions | All admin changes and denied actions are recorded. | Some denied actions are recorded. Recording every admin change and denial is not verified. [E11] |
| Keep audit records | Records cannot be changed and are kept for seven years. | Protection against changes and seven-year retention are not verified. |
| Permission-service failure | Protected actions are blocked if permissions cannot be checked, and an alert is raised. | Inspected checks block actions on errors. Blocking every protected action and raising alerts are not verified. [E8] |
| Backup permission checks | A local backup checks permissions when needed. | A separate local backup was not found in the reviewed permission-checking flow. [E1] |
| Default portfolio | A default portfolio is created automatically. | Automatic default-portfolio creation exists in code. [E13] |
| Inherit organization settings | Portfolios inherit settings from their organization. | Inheriting organization settings is not established; the reviewed category settings use global defaults instead. [E18] |
| Internal role visibility | Customers never see internal roles. | The reviewed user screen does not hide internal role names. Whether customers currently see them was not tested. [E6] |
| Landing after login | Users land in a portfolio they are allowed to access. | Landing only in an assigned portfolio is not verified. |
| Permission-check speed | 95% of permission checks take no more than 10 ms. | Not verified. |
| Permission-service availability | The permission service is available at least 99.9% of the time. | Not verified. |
| Analytics and dashboards | Track onboarding, role changes, permission changes, denied actions, and Monitoring usage. | Coverage of these events and dashboards is not verified. |

## Two onboarding gaps to make explicit

| Topic | What the PRD says | Atlas today |
| --- | --- | --- |
| User without a role | Least privilege, role-based permissions, and no reliance on login alone imply no access to protected data or actions without a grant. The PRD does not explicitly say to block entry to the application. | An invitation can be sent without assigning a role. Some protected workflows lack permission checks, so no-role access is not consistently prevented by the reviewed code. [E4][E15] |
| Invitation email | Users must be able to accept an invitation within its validity period, activate their account, and enter their assigned scope. Email wording, expiry duration, and the existing-user email are not specified. | For a new Auth0 user, Atlas requests a password-reset email as the invitation. For an existing Auth0 user, this flow adds organization membership without requesting an invitation email. The actual email template and expiry were not inspected. [E4][E19] |

Suggested additions to the PRD, pending product agreement:

- **No-role access:** A user without an assigned role cannot access protected Atlas pages, data, or actions. After login, show “Your access has not been assigned. Contact your administrator.” Block protected requests on the server too.
- **New-user email:** Send an Atlas invitation naming the organization, with an “Accept invitation and set password” link, its expiry, and a support contact.
- **Existing-user email:** Send an invitation naming the organization, with an “Accept invitation” link that uses the user's existing account.
- **Access assignment:** Assign the intended role, portfolios, and products before sending the invitation. Accepting it must not grant broader access.

These are proposed clarifications. The supplied PRD does not currently specify this email content or require assignment before sending.

## Where the PRD needs a decision

1. **Which roles are in MVP?** The PRD lists Risk Analyst as both a future role and an MVP role. Current production policy files define seven roles, including internal/external risk roles, Org Admin, API Client, and Beta Testers. [E10]
2. **Can customers manage users?** The PRD says only internal staff can administer users. Current Org Admin policy allows user creation and removal. We did not check whether customers actually hold that role. [E10]
3. **Keep Permit or replace it?** The PRD requires Permit. A newer proposal recommends replacing it, but says implementation has not started. [D1]
4. **What are the exact rules?** Confirm the seven-year retention requirement, which settings inherit into portfolios, and what “approve high-risk actions” means.

## What to finish first

1. Agree on the MVP roles and who may manage users.
2. Add user access assignments for portfolios and Monitoring.
3. Check permissions consistently on every protected workflow.
4. Finish role assignment and immediate deactivation.
5. Verify audit retention, report access, and the PRD's acceptance criteria.

## Sources and limits

This was a targeted code review. It does not confirm what is deployed or which roles customers currently hold. Reporting, audit storage, analytics, and performance need further verification.

Source links above point to the reviewed versions. Current remote files were used for the portal, access manager, account service, and policy definitions. The BFF code matched its remote branch, whose last commit was 4 October. The report-screen evidence came from the older local portal copy dated 25 October.

[E1]: https://github.com/evercompliant/ufp-access-manager/blob/a5c7e5646cacafb5e0ca92ae542004fb399ef155/src/main/java/com/everc/ufp/accessmanager/services/PermitAuthorizationService.java#L37
[E4]: https://github.com/evercompliant/ufp-access-manager/blob/a5c7e5646cacafb5e0ca92ae542004fb399ef155/src/main/java/com/everc/ufp/accessmanager/services/AuthApiService.java#L71
[E6]: https://github.com/evercompliant/marketview-portal/tree/2795e1b0fdf3af83ca1c540566a46a32c7cbfa3b/src/features/settings/pages/UsersAndRoles
[E7]: https://github.com/evercompliant/mlrc-bff-2.0/blob/dd21f670ba862e1432985b7357088fee531c8171/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/controller/MerchantCreationController.java#L62
[E8]: https://github.com/evercompliant/mlrc-bff-2.0/blob/dd21f670ba862e1432985b7357088fee531c8171/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/service/AnalystReviewAccessValidator.java#L40
[E10]: https://github.com/evercompliant/terraform/blob/a538b6d4676eba7c50938560d6aff6ba58831a99/marketview/permit.io-resources/prod/permit-roles.tf#L63
[E11]: https://github.com/evercompliant/mlrc-bff-2.0/blob/dd21f670ba862e1432985b7357088fee531c8171/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/security/AuthorizationDenialAuditService.java#L59
[E13]: https://github.com/evercompliant/mlrc-account/blob/282d8bd7a3c7838886bf62a77e0adff2a77345f4/api/src/main/java/com/everc/mlrc/account/api/service/AccountScopeService.java#L35
[E15]: https://github.com/evercompliant/mlrc-bff-2.0/blob/dd21f670ba862e1432985b7357088fee531c8171/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/controller/FindingStatusController.java#L58
[E17]: /Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal/src/components/pages/Portfolio/DownloadReportsModal/CreateReportModal.tsx:51
[E18]: https://github.com/evercompliant/mlrc-account/blob/282d8bd7a3c7838886bf62a77e0adff2a77345f4/api/src/main/java/com/everc/mlrc/account/api/service/CategoryConfigService.java#L62
[D1]: https://g2rs.atlassian.net/wiki/spaces/AG/pages/4407492609/Discovery+Replacing+Permit.io+for+Authorization
[E19]: https://github.com/evercompliant/ufp-access-manager/blob/a5c7e5646cacafb5e0ca92ae542004fb399ef155/src/main/java/com/everc/ufp/accessmanager/clients/auth0/Auth0ClientImpl.java#L202
