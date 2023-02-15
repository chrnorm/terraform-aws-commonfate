module "granted" {
  count  = var.sso_granted["enabled"] ? 1 : 0
  source = "../../"

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }

  project        = var.project
  environment    = var.environment
  component      = var.component
  aws_account_id = var.aws_account_id
  region         = var.region

  aws_sso_identity_store_id = tolist(data.aws_ssoadmin_instances.main.identity_store_ids)[0]
  aws_sso_instance_arn      = tolist(data.aws_ssoadmin_instances.main.arns)[0]
  aws_sso_region            = var.aws_sso_region

  public_hosted_zone_id = var.public_hosted_zone_id

  administrator_group_id    = lookup(var.sso_granted, "administrator_group_id", "granted_administrators")
  azure_client_id           = lookup(var.sso_granted, "azure_client_id", "")
  azure_tenant_id           = lookup(var.sso_granted, "azure_tenant_id", "")
  azure_email_identifier    = lookup(var.sso_granted, "azure_email_identifier", "mail")
  identity_provider_name    = lookup(var.sso_granted, "identity_provider_name", null)
  identity_provider_type    = lookup(var.sso_granted, "identity_provider_type", "cognito")
  saml_sso_metadata_content = lookup(var.sso_granted, "saml_sso_metadata_content", null)
  saml_sso_metadata_url     = lookup(var.sso_granted, "saml_sso_metadata_url", null)
  sources_version           = lookup(var.sso_granted, "sources_version", null)
  sources_s3_bucket_id      = lookup(var.sso_granted, "sources_s3_bucket_id", "granted-releases-us-west-2")

  web_cognito_custom_image_file   = lookup(var.sso_granted, "cognito_custom_image_file", null)
  web_cognito_custom_image_base64 = lookup(var.sso_granted, "cognito_custom_image_base64", null)

  default_tags = local.default_tags
}


resource "commonfate_access_rule" "example" {
  name        = "Terraform Example"
  description = "Access Rule made in Terraform"
  groups      = ["976708da7d-b2f2e2cf-152c-4301-923f-ed6b3b9564a3"]

  target = [
    {
      field = "accountId"
      value = ["344406835407"] # 'web-application-prod' demo account.
    },
    {
      field = "permissionSetArn"
      value = [aws_ssoadmin_permission_set.example.arn]
    }
  ]
  target_provider_id = "aws-sso"
  duration           = "3700"
}


output "saml_acs_url" {
  value = "https://${module.granted[0].web_cognito_user_pool_domain}/saml2/idpresponse"
}

output "saml_audience_uri" {
  value = "urn:amazon:cognito:sp:${module.granted[0].web_cognito_user_pool_id}"
}

