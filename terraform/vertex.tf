####################################################################################################
## Workbenchs
####################################################################################################

resource "google_workbench_instance" "instance" {
    name = "notebook-instance-1"
    location = var.region
    gce_setup {
      container_image {
        repository = "us-docker.pkg.dev/jupyter/base-notebook:x86_64-ubuntu-22.04" # Alterar para imagem básica de Jupyter Notebook
      }
    }
    desired_state = "STOPPED"
}

####################################################################################################
## Pipelines
####################################################################################################

# resource "google_vertex_ai_pipeline_job" "pipeline_1" {
#     display_name = "notebook-pipeline-1-job"

#     pipeline_spec {
#         pipeline_spec = jsonencode({
#             "displayName": "Pipeline de notebooks para regressor linear básico.",
#             "tasks": {
#                 "run-notebook": {
#                     "taskInfo": {
#                         "name": "Run Notebook"
#                     },
#                     "notebookTask": {
#                         "notebook": google_storage_bucket.notebooks_bucket.name,
#                         "inputParameters": {
#                             "bq_dataset": google_bigquery_dataset.staging.dataset_id,
#                         }
#                     }
#                 }
#             }
#         })
#     }
# }

####################################################################################################
## Endpoints
####################################################################################################

resource "google_vertex_ai_endpoint" "endpoint" {
    name            = "mockup-endpoint-1"
    display_name    = "mockup-endpoint_1"
    description     = "Endpoint for mockup pipeline 1"
    location        = var.location
    region          = var.region

    private_service_connect_config {
        enable_private_service_connect = true
        project_allowlist = [var.project_id]
        enable_secure_private_service_connect = false
    } 
}