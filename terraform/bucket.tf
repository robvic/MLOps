####################################################################################################
## Buckets
####################################################################################################

resource "google_storage_bucket" "notebooks_bucket" {
    name          = "colab-notebooks-${var.project_id}"
    location      = var.region
    force_destroy = true

    uniform_bucket_level_access = true

    versioning {
        enabled = true
    }

    labels = {
        environment = var.environment
        purpose     = "colab-notebooks"
    }
}

resource "google_storage_bucket" "colab_outputs_bucket" {
    name          = "colab-outputs-${var.project_id}"
    location      = var.region
    force_destroy = true

    uniform_bucket_level_access = true

    versioning {
        enabled = true
    }

    labels = {
        environment = var.environment
        purpose     = "colab-outputs"
    }
}

resource "google_storage_bucket" "vertex_pipelines_bucket" {
    name          = "vertex-pipelines-${var.project_id}"
    location      = var.region
    force_destroy = true

    uniform_bucket_level_access = true

    versioning {
        enabled = true
    }

    labels = {
        environment = var.environment
        purpose     = "vertex-pipelines"
    }
}

resource "google_storage_bucket" "models_bucket" {
    name          = "vertex-models-${var.project_id}"
    location      = var.region
    force_destroy = true

    uniform_bucket_level_access = true

    versioning {
        enabled = true
    }

    labels = {
        environment = var.environment
        purpose     = "vertex-models"
    }
}

####################################################################################################
## Objects
####################################################################################################