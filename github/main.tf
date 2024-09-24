locals {
  projects = {
    for key, value in var.projects :
    key => merge(value,
      {
        repo_name        = value.custom_repo_name
        repo_description = value.custom_repo_description
        template_repo    = value.template_repo
      },
    )
  }
}
