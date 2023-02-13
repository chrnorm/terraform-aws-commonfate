resource "aws_iam_role" "sso_readonly" {
  # used only when AWS SSO is enabled as an identity provider.
  count = var.identity_provider_type == "aws-sso" ? 1 : 0

  name               = "${local.csi}-sso-readonly"
  assume_role_policy = data.aws_iam_policy_document.assumerole_sso_readonly.json

  tags = merge(
    local.default_tags,
    {
      Name = "${local.csi}-sso-readonly"
    }
  )

  provisioner "local-exec" {
    command = "sleep 10"
  }
}
