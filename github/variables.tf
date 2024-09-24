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