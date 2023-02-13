resource "aws_iam_role_policy_attachment" "sso_readonly_sso_readonly" {
  # used only when AWS SSO is enabled as an identity provider.
  count = var.identity_provider_type == "aws-sso" ? 1 : 0

  role       = aws_iam_role.sso_readonly.name
  policy_arn = aws_iam_policy.sso_readonly.arn
}
