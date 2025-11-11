terraform {
  required_version = ">= 1.6.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      # there's currently an issue with the `source` field, pin until fixed
      # https://github.com/cloudflare/terraform-provider-cloudflare/issues/5093
      version = "~> 4.52"
    }
  }

  backend "s3" {
    bucket = var.terraform_state_bucket_name
    key    = "cookbook"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
