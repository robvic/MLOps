variable "project_id" {
    description = "The GCP project ID"
    type        = string
}

variable "region" {
    description = "The GCP region to deploy resources"
    type        = string
    default     = "us-central1"
}

variable "environment" {
    description = "Deployment environment (e.g., dev, staging, prod)"
    type        = string
}

variable "service_account_email" {
    description = "Service account email to use for resources"
    type        = string
    default     = ""
}

variable "labels" {
    description = "A map of labels to assign to resources"
    type        = map(string)
    default     = {}
}

variable "location" {
    description = "The location for resources (region or multi-region, e.g., US, EU, us-central1)"
    type        = string
    default     = "US"
}

variable "solution" {
  description = "Solution's Title"
  type        = string
}

variable "git-repository" {
  description = "Git URL"
  type        = string
}

variable "branch" {
  description = "Defult branch for Dataform"
  type        = string
}

variable "git_token" {
  description = "Token to access the git repository"
  type        = string
}