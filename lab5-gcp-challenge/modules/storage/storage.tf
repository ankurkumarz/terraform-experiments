resource "google_storage_bucket" "storage-state" {
  name          = "tf-bucket-268171"
  location      = "US"
  force_destroy = true
  uniform_bucket_level_access = true
}