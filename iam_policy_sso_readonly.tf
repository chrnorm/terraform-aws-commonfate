resource "aws_iam_policy" "sso_readonly" {
  # used only when AWS SSO is enabled as an identity provider.
  count = var.identity_provider_type == "aws-sso" ? 1 : 0

  name   = "${local.csi}-sso-readonly"
  path   = "/"
  policy = data.aws_iam_policy_document.sso_readonly.json

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-sso-readonly"
    }
  )
}
