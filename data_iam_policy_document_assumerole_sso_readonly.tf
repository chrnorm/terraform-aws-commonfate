# used only when AWS SSO is enabled as an identity provider.
data "aws_iam_policy_document" "assumerole_sso_readonly" {
  statement {
    sid    = "AllowPrincipalsAssumeRoleForSsoReadOnlyRole"
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        module.lambdacron_idp_sync.iam_role_arn,
        module.lambdacron_approvals.iam_role_arn,
      ]
    }
  }
}
