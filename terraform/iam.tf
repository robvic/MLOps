####################################################################################################
## Service Accounts
####################################################################################################

resource "google_service_account" "ai_platform" {
    account_id   = "ai-platform"
    display_name = "AI Platform Service Account"
}

resource "google_service_account" "dataform_sa" {
  account_id   = "dataform-sa"
  display_name = "Dataform Service Account"
}


####################################################################################################
## Permissions
####################################################################################################

resource "google_project_iam_member" "dataform_bigquery_user" {
  project = var.project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.dataform_sa.email}"
}

resource "google_project_iam_member" "dataform_sa_dataeditor" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.dataform_sa.email}" 
}

resource "google_project_iam_member" "dataform_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.dataform_sa.email}"
}

resource "google_secret_manager_secret_iam_member" "dataform_access" {
  project = var.project_id
  secret_id = google_secret_manager_secret.dataform_git_token.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.dataform_sa.email}"
}