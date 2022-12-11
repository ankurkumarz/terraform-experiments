terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
  ## Add later
  /*backend "gcs" {
    bucket  = "tf-bucket-268171"
    prefix  = "terraform/state"
  }*/
}

provider "google" {
  version = "3.55.0"
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "instances" {
  source     = "./modules/instances"
}

# Uncomment later
module "storage" {
  source     = "./modules/storage"
}

module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 3.4.0"

    project_id   = "PROJECT_ID"
    network_name = "VPC_NAME"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-east1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-east1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
    ]
}

## Add a firewall
resource "google_compute_firewall" "tf-firewall"{
  name    = "tf-firewall"
 network = "projects/<PROJECT_ID>/global/networks/VPC_Name"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
  source_ranges = ["0.0.0.0/0"]
}
