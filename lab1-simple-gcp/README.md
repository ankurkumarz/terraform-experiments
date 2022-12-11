# Simple Terraform Workflow

A simple workflow for deployment will follow closely to the steps below:
- Scope - Confirm what resources need to be created for a given project.
- Author - Create the configuration file in HCL based on the scoped parameters.
- Initialize - Run terraform init in the project directory with the configuration files. This will download the correct provider plug-ins for the project.
- Plan & Apply - Run terraform plan to verify creation process and then terraform apply to create real resources as well as the state file that compares future changes in your configuration files to what actually exists in your deployment environment.


# Terraform Commands Used

```
touch main.tf
terraform init
terraform plan
terraform apply
terraform show
terraform destroy
```

The resource block has two strings before opening the block: the resource type and the resource name. For this lab, the resource type is google_compute_instance and the name is terraform. The prefix of the type maps to the provider: google_compute_instance automatically tells Terraform that it is managed by the Google provider.

The terraform init command will automatically download and install any provider binary for the providers to use within the configuration, which in this case is just the Google provider.
terraform init
