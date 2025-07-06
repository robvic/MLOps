####################################################################################################
## Datasets
####################################################################################################

resource "google_bigquery_dataset" "staging" {
    dataset_id = "staging"
    location   = var.location
    default_table_expiration_ms = 3600000
}

resource "google_bigquery_dataset" "preprocessed" {
    dataset_id = "preprocessed"
    location   = var.location
    default_table_expiration_ms = 3600000
}

resource "google_bigquery_dataset" "evaluation" {
    dataset_id = "evaluation"
    location   = var.location
    default_table_expiration_ms = 3600000
}

resource "google_bigquery_dataset" "predicted" {
    dataset_id = "predicted"
    location   = var.location
    default_table_expiration_ms = 3600000
}

####################################################################################################
## Tables
####################################################################################################

resource "google_bigquery_job" "mockup_table" {
    job_id = "mockup_table_job"
    location   = var.location
    query {
        query = <<EOF
            SELECT *
            FROM `bigquery-public-data.sdoh_cdc_wonder_natality.county_natality`
        EOF
        destination_table {
            project_id = var.project_id
            dataset_id = google_bigquery_dataset.staging.dataset_id
            table_id   = "p1_county_natality"
            }
        write_disposition = "WRITE_TRUNCATE"
        use_legacy_sql    = false
        }    
}