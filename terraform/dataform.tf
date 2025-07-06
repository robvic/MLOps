 ####################################################################################################
## Repository
####################################################################################################
 
 resource "google_dataform_repository" "dataform_repository" {
   project = var.project_id
   provider = google-beta
   name = "dataform-${var.solution}"
   region = var.region
   service_account = google_service_account.dataform_sa.email
   timeouts {}

   git_remote_settings {
       url = var.git-repository
       default_branch = var.branch
       authentication_token_secret_version = "projects/${var.project_id}/secrets/${google_secret_manager_secret.dataform_git_token.secret_id}/versions/latest"
   }

   workspace_compilation_overrides {
     schema_suffix = var.branch
     default_database = var.project_id
   }

   depends_on = [
    google_secret_manager_secret.dataform_git_token,
    google_secret_manager_secret_version.dataform_git_token_version,
    google_secret_manager_secret_iam_member.dataform_access,
    google_service_account.dataform_sa
  ]
 }

####################################################################################################
## Release & Workflow for Pipeline 1
####################################################################################################

resource "google_dataform_repository_release_config" "release_config_1" {
  provider = google-beta

  project    = var.project_id
  region     = var.region
  repository = google_dataform_repository.dataform_repository.name

  name          = "pipeline_1_release"
  git_commitish = "main"
  cron_schedule = "0 7 * * *"
  time_zone     = "America/Sao_Paulo"

  code_compilation_config {
    default_database = var.project_id
    default_location = var.region
  }
}

resource "google_dataform_repository_workflow_config" "workflow_config_1" {
  provider = google-beta

  project        = var.project_id
  region         = var.region
  repository     = google_dataform_repository.dataform_repository.name
  name           = "pipeline_1_workflow"
  release_config = google_dataform_repository_release_config.release_config.id

  invocation_config {
    transitive_dependencies_included         = true
    transitive_dependents_included           = true
    fully_refresh_incremental_tables_enabled = false
    service_account                          = google_service_account.dataform_sa.email
    included_tags                            = ["pipeline_1"]
  }

  cron_schedule   = "0 7 * * *"
  time_zone       = "America/Sao_Paulo"
}