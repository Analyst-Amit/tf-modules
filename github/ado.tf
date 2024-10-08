# Retrieve the Azure DevOps project details using the project name
data "azuredevops_project" "example" {
  name = "AconDataLake" # Use the actual project name here
}

resource "azuredevops_build_definition" "example" {
  for_each = local.projects
  project_id = var.azure_devops_project
  name       = github_repository.this[each.key].name
#   path       = "\\ExampleFolder"

  ci_trigger {
    use_yaml = true
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = join("/", [var.github_org, github_repository.this[each.key].id])
    branch_name           = "main"
    yml_path              = ".ado/cicd.yml"
    service_connection_id = var.ado_service_connection_id
  }
}