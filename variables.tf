variable "cloudflare_api_token" { 
  type = string 
}

variable "cloudflare_account_id" { 
  type = string 
}

variable "project_name" { 
  type = string 
}

variable "project_branch" { 
  type = string  
  default = "main" 
}

variable "project_domain" {
  type = string
}

variable "github_owner" { 
  type = string 
}

variable "github_repo" { 
  type = string 
}

variable "node_version" {
  type = string
  default = "22.16.0"
}

variable "build_command" {
  type = string
  default = "npm ci && npm run build"
}

variable "build_destination" {
  type = string
  default = ".vitepress/dist"
}