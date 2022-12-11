provider "google" {
  project     = "# REPLACE WITH YOUR PROJECT ID"
  region      = "us-central-1"
}
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "# REPLACE WITH YOUR PROJECT ID"
  location    = "US"
  uniform_bucket_level_access = true
}

# add a local backend
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}

# add a cloud backend
terraform {
  backend "gcs" {
    bucket  = "# REPLACE WITH YOUR BUCKET NAME"
    prefix  = "terraform/state"
  }
}