# Add a local backend

```
provider "google" {
  project     = "# REPLACE WITH YOUR PROJECT ID"
  region      = "us-central-1"
}
resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "# REPLACE WITH YOUR PROJECT ID"
  location    = "US"
  uniform_bucket_level_access = true
}
terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}
```

# Add a cloud backend (Replace)
```
terraform {
  backend "gcs" {
    bucket  = "# REPLACE WITH YOUR BUCKET NAME"
    prefix  = "terraform/state"
  }
}
```
- Initialize your backend again, this time to automatically migrate the state:
```
terraform init -migrate-state
``` 

# Refresh the state
The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. This can be used to detect any drift from the last-known state and to update the state file.

```
terraform refresh
terraform show
```