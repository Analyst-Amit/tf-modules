resource "github_repository" "this" {
  for_each    = local.projects
  name        = each.value.repo_name
  description = each.value.repo_description

  visibility = "public"

  #Automatically delete head branches 
  delete_branch_on_merge = true

  template {
    owner                = var.github_org
    repository           = var.template_repo
    include_all_branches = false
  }
}

# Define your ruleset with for_each to apply to each repository
resource "github_repository_ruleset" "main_branch_protection_ruleset" {

  for_each = { for k, v in local.projects : k => v if try(v.add_ruleset, false) == true }
  # Name of the ruleset
  name        = "main-branch-protection-ruleset"
  repository  = github_repository.this[each.key].name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"] # target branch or pattern
      exclude = []
    }
  }

  rules {

    #Restrict deletions
    deletion = true

    #block force pushes
    non_fast_forward = true

    # #Require status checks to pass
    # required_status_checks {
    #   required_check {
    #     context        = "SonarCloud Code Analysis"
    #     integration_id = var.sonar_cloud_app_id
    #   }
    #   required_check {
    #     context        = join(".",[try(each.value.prefix,"MLOps"),var.mlops_platform,try(each.value.custom_pipeline_suffix,github_repository.this[each.key].name)])
    #     integration_id = var.azure_pipeline_app_id
    #   }
    # }

    #Require a pull request before merging
    pull_request {
      required_approving_review_count = 0
      dismiss_stale_reviews_on_push   = true
      require_code_owner_review       = false
    }
  }
}