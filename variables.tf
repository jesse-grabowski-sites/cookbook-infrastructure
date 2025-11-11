variable "terraform_state_bucket_name" {
  type        = string
  description = "Name of the bucket that holds terraform state"
  sensitive   = true
  nullable    = false

  validation {
    condition     = can(regex("^(?=.{3,63}$)[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.terraform_state_bucket_name))
    error_message = "terraform_state_bucket_name must be 3–63 chars, lowercase letters, numbers, dots, or hyphens; no leading/trailing dots or hyphens."
  }
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with least-privilege for managing the Pages project and domain."
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(trimspace(var.cloudflare_api_token)) > 0
    error_message = "cloudflare_api_token must be a non-empty string (provide via CI secrets or env var)."
  }
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID (32 hex characters)."
  nullable    = false

  validation {
    condition     = can(regex("(?i)^[a-f0-9]{32}$", var.cloudflare_account_id))
    error_message = "cloudflare_account_id must be a 32-character hex string."
  }
}

variable "project_name" {
  type        = string
  description = "Cloudflare Pages project name (lowercase, numbers, hyphens)."
  nullable    = false

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{0,62}$", var.project_name))
    error_message = "project_name must be lowercase alphanumeric with optional hyphens; max 63 chars."
  }
}

variable "production_branch" {
  type        = string
  description = "Production Git branch (all others are previews)"
  default     = "main"
  nullable    = false

  validation {
    condition     = can(regex("^[A-Za-z0-9._/-]+$", var.production_branch))
    error_message = "production_branch may only include letters, numbers, dot, underscore, slash, and hyphen."
  }
}

variable "github_owner" {
  type        = string
  description = "GitHub organization or username that owns the repository."
  nullable    = false

  validation {
    condition     = can(regex("^[A-Za-z0-9](?:[A-Za-z0-9-]{0,37}[A-Za-z0-9])?$", var.github_owner))
    error_message = "github_owner must be 1–39 chars, alphanumeric with optional internal hyphens; cannot start or end with a hyphen."
  }
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name."
  nullable    = false

  validation {
    condition     = can(regex("^[A-Za-z0-9._-]{1,100}$", var.github_repo))
    error_message = "github_repo must be 1–100 chars and use letters, numbers, dot, underscore, or hyphen."
  }
}

variable "project_domain" {
  type        = string
  description = "Custom domain for the Pages project (e.g., example.com)."
  nullable    = false

  validation {
    condition     = can(regex("(?i)^(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z]{2,}$", var.project_domain))
    error_message = "project_domain must be a valid DNS name (labels 1–63 chars, no leading/trailing hyphens)."
  }
}

variable "node_version" {
  type        = string
  description = "Node.js version used by Cloudflare Pages to build the site."
  default     = "22.16.0"
  nullable    = false

  validation {
    condition     = can(regex("^\\d+\\.\\d+\\.\\d+$", var.node_version))
    error_message = "node_version should be a semantic version like 22.16.0."
  }
}

variable "build_command" {
  type        = string
  description = "Shell command to build the site."
  default     = "npm ci && npm run build"
  nullable    = false

  validation {
    condition     = length(trimspace(var.build_command)) > 0
    error_message = "build_command cannot be empty."
  }
}

variable "build_destination" {
  type        = string
  description = "Relative output directory produced by the build, used as Pages build artifact path."
  default     = ".vitepress/dist"
  nullable    = false

  validation {
    condition     = can(regex("^[^\\s].*$", var.build_destination))
    error_message = "build_destination cannot be empty or start with whitespace."
  }
}
