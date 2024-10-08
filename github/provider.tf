terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = ">= 0.1.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  owner = var.github_org
  token = var.GITHUB_TOKEN
}

# Configure the Azure DevOps Provider
provider "azuredevops" {
  org_service_url      = var.AZDO_ORG_SERVICE_URL
  personal_access_token = var.AZDO_PERSONAL_ACCESS_TOKEN
}