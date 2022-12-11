# Terraform Migration Workflow

You may need to manage infrastructure that wasn’t created by Terraform. Terraform import solves this problem by loading supported resources into your Terraform workspace’s state.
The import command doesn’t automatically generate the configuration to manage the infrastructure, though. Because of this, importing existing infrastructure into Terraform is a multi-step process.

Bringing existing infrastructure under Terraform’s control involves five main steps:

- Identify the existing infrastructure to be imported.
- Import the infrastructure into your Terraform state.
- Write a Terraform configuration that matches that infrastructure.
- Review the Terraform plan to ensure that the configuration matches the expected state and infrastructure.
- Apply the configuration to update your Terraform state.

# Import a Docker Container
- An example repository:

```
git clone https://github.com/hashicorp/learn-terraform-import.git
cd learn-terraform-import
terraform init
```
- Comment out as per the below code:
```
provider "docker" {
#   host    = "npipe:////.//pipe//docker_engine"
}
```
- Add following to docker.tf:
```
resource "docker_container" "web" {}
```
- Run the following terraform import command to attach the existing Docker container to the docker_container.web resource you just created. Terraform import requires this Terraform resource ID and the full Docker container ID. The command docker inspect -f {{.ID}} hashicorp-learn returns the full SHA256 container ID:
```
terraform import docker_container.web $(docker inspect -f {{.ID}} hashicorp-learn)
terraform show
```

## Create the configuration
- Copy your Terraform state into your docker.tf file:
```
terraform show -no-color > docker.tf
```
- Remove all lines and keep only required fields:
```
resource "docker_container" "web" {
    image = "sha256:87a94228f133e2da99cb16d653cd1373c5b4e8689956386c1c12b60a20421a02"
    name  = "hashicorp-learn"
    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
```
- Run terraform plan