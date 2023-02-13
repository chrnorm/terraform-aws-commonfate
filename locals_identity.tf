locals {
  identity_configuration = jsonencode({
    azure = {
      tenantId        = var.azure_tenant_id
      clientId        = var.azure_client_id
      clientSecret    = "awsssm://${aws_ssm_parameter.secrets_identity_token.name}"
      emailIdentifier = var.azure_email_identifier
    }

    okta = {
      apiToken = "awsssm://${aws_ssm_parameter.secrets_identity_token.name}"
      orgUrl   = var.okta_org_url
    }

    "aws-sso" = {
      identityStoreId      = var.aws_sso_identity_store_id
      identityStoreRoleArn = var.identity_provider_type == "aws-sso" ? aws_iam_role.sso_readonly[0].arn : null
      region               = var.aws_sso_region
    }
  })
}
