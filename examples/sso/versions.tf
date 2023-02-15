terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }

    commonfate = {
      source  = "common-fate/commonfate"
      version = "~> 1.1"
    }
  }

  required_version = ">= 0.14.7"
}
