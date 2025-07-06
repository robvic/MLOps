####################################################################################################
## Runtimes
####################################################################################################

resource "random_string" "random_string" {
    length   = 8
    special  = false
    upper    = false
}

resource "google_colab_runtime_template" "default_template" {
    provider                = google-beta
    project                 = var.project_id
    name                    = "default_template_${random_string.random_string.result}"
    display_name            = "default_template"
    description             = "Default Colab Runtime Template"
    location                = var.location

    machine_spec {
        machine_type        = "e2-standard-4"
    }

    network_spec {
      enable_internet_access = true
    } 
}

####################################################################################################
## Executors
## |!| Este elemento precisa ser melhorado para execução dinâmica de múltiplos notebooks em um mesmo pipeline.
####################################################################################################

resource "google_colab_notebook_execution" "notebook_pipeline_1_processing" {
    provider                = google-beta
    project                 = var.project_id
    notebook_execution_job_id = "notebook_pipeline_1_processing_job"
    display_name            = "notebook_pipeline_1_processing"
    location                = var.location

    execution_timeout = "300s"
    gcs_notebook_source {
      uri                   = "gs://${var.project_id}-notebooks/pipeline_1/preprocessing.ipynb"
    }

    service_account         = google_service_account.ai_platform.email
    gcs_output_uri          = "gs://${var.project_id}-colab-outputs/notebook_pipeline_1_processing"
    notebook_runtime_template_resource_name = "projects/${var.project_id}/locations/${var.location}/notebookRuntimeTemplates/${google_colab_runtime_template.default_template.name}"
}

resource "google_colab_notebook_execution" "notebook_pipeline_1_training" {
    provider                = google-beta
    project                 = var.project_id
    notebook_execution_job_id = "notebook_pipeline_1_training_job"
    display_name            = "notebook_pipeline_1_training"
    location                = var.location

    execution_timeout       = "300s"
    gcs_notebook_source {
      uri                   = "gs://${var.project_id}-notebooks/pipeline_1/training.ipynb"
    }

    service_account         = google_service_account.ai_platform.email
    gcs_output_uri          = "gs://${var.project_id}-colab-outputs/notebook_pipeline_1_training"
    notebook_runtime_template_resource_name = "projects/${var.project_id}/locations/${var.location}/notebookRuntimeTemplates/${google_colab_runtime_template.default_template.name}"

    depends_on              = [ google_colab_notebook_execution.notebook_pipeline_1_processing ]
}

resource "google_colab_notebook_execution" "notebook_pipeline_1_testing" {
    provider                = google-beta
    project                 = var.project_id
    notebook_execution_job_id = "notebook_pipeline_1_testing_job"
    display_name            = "notebook_pipeline_1_training"
    location                = var.location

    execution_timeout       = "300s"
    gcs_notebook_source {
      uri                   = "gs://${var.project_id}-notebooks/pipeline_1/testing.ipynb"
    }

    service_account         = google_service_account.ai_platform.email
    gcs_output_uri          = "gs://${var.project_id}-colab-outputs/notebook_pipeline_1_testing"
    notebook_runtime_template_resource_name = "projects/${var.project_id}/locations/${var.location}/notebookRuntimeTemplates/${google_colab_runtime_template.default_template.name}"

    depends_on              = [ google_colab_notebook_execution.notebook_pipeline_1_training ]
}