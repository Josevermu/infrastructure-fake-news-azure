variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "konradquiz-rg"
}

variable "environment" {}

variable "backend_image" {}

variable "cors_allowed_origins" {}

variable "encryption_secret_key" {
  sensitive = true
}

variable "admin_password" {
  sensitive = true
}

variable "ghcr_username" {}

variable "ghcr_token" {
  sensitive = true
}