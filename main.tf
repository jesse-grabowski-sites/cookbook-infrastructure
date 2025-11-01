resource "cloudflare_pages_project" "jesses-cookbook" {
  account_id        = var.cloudflare_account_id
  name              = var.project_name
  production_branch = var.project_branch

  source {
    type = "github"
    config {
      owner         = var.github_owner
      repo_name     = var.github_repo
      production_branch = var.project_branch
    }
  }

  build_config {
    build_command   = var.build_command
    destination_dir = var.build_destination
  }

  deployment_configs {
    production {
      environment_variables = {
        NODE_VERSION = var.node_version
      }
    }
    preview {
      environment_variables = {
        NODE_VERSION = var.node_version
      }
    }
  }
}

resource "cloudflare_pages_domain" "jesses-cookbook" {
  account_id   = var.cloudflare_account_id
  project_name = var.project_name
  domain       = var.project_domain
}
