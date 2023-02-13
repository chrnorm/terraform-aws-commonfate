# used only when AWS SSO is enabled as an identity provider.
data "aws_iam_policy_document" "sso_readonly" {
  statement {
    sid    = "ReadIdentityStore"
    effect = "Allow"

    actions = [
      "identitystore:DescribeGroup",
      "identitystore:DescribeUser",
      "identitystore:ListGroupMembershipsForMember",
      "identitystore:ListUsers",
      "identitystore:ListGroups",
    ]

    resources = [
      "*",
    ]
  }
}
