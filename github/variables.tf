variable "projects" {
  description = "MlOps Project to create."
  type        = any
}

variable "github_org" {
  type = string
  description = "The GitHub organization or user the template repository is owned by"
  default = "Analyst-Amit"
}

variable "template_repo" {
  type = string
  description = "The template repo to use"
  default = "mlops-template"
}

variable "GITHUB_TOKEN" {
  type = string
  sensitive = true
}

variable "ado_service_connection_id" {
  type = string
  description = "Azure devops service connection to github enterprise"
  default = "d9119ba1-b86e-4230-a942-7d22a412c15f"
}

variable "AZDO_PERSONAL_ACCESS_TOKEN" {
  type = string
  sensitive = true
}

variable "AZDO_ORG_SERVICE_URL" {
  type = string
  sensitive = true
}

variable "azure_devops_project" {
  type = string
  description = "Azure devops project name"
  default = "AconDataLake"
}