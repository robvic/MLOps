resource "google_project_service" "vertex_ai" {
    service = "aiplatform.googleapis.com"
}

resource "google_project_service" "vertex_notebooks" {
    service = "notebooks.googleapis.com"
}

resource "google_project_service" "data_catalog" {
    service = "datacatalog.googleapis.com"
}

resource "google_project_service" "dataproc" {
    service = "dataproc.googleapis.com"
}