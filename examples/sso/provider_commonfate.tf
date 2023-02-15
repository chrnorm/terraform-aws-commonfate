provider "commonfate" {
  governance_api_url = module.granted[0].governance_rest_api_endpoint
  aws_region         = var.region
}
