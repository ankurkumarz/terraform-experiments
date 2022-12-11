
# Objective
- To use Terraform for resource workflow building infrastructure, change infrastructure, create resource dependencies, and provision infrastructure.

# Terraform Commands
```
terraform plan -out save_plan
#Use terraform taint to tell Terraform to recreate the instance
terraform taint google_compute_instance.vm_instance
```

# Notes
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
- The presence of the access_config block, even without any arguments, ensures that the instance will be accessible over the internet.
- Notice how this configuration refers to the network's name property with google_compute_network.vpc_network.name -- google_compute_network.vpc_network is the ID, matching the values in the block that defines the network, and name is a property of that resource.
- The prefix -/+ means that Terraform will destroy and recreate the resource, rather than updating it in-place.
- While some attributes can be updated in-place (which are shown with the ~ prefix), changing the boot disk image for an instance requires recreating it.
- Terraform determines the order in which things must be destroyed. Google Cloud won't allow a VPC network to be deleted if there are resources still in it, so Terraform waits until the instance is destroyed before destroying the network. When performing operations, Terraform creates a dependency graph to determine the correct order of operations. In more complicated cases with multiple resources, Terraform will perform operations in parallel when it's safe to do so.
-  Implicit dependencies via interpolation expressions are the primary way to inform Terraform about these relationships, and should be used whenever possible.
- For example, perhaps an application you will run on your instance expects to use a specific Cloud Storage bucket, but that dependency is configured inside the application code and thus not visible to Terraform. In that case, you can use depends_on to explicitly declare the dependency.
- The order that resources are defined in a terraform configuration file has no effect on how Terraform applies your changes. Organize your configuration files in a way that makes the most sense for you and your team.
- https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax 
- The local-exec provisioner executes a command locally on the machine running Terraform, not the VM instance itself. 
- Provisioners only run when a resource is created, but adding a provisioner does not force that resource to be destroyed and recreated.
- Use terraform taint to tell Terraform to recreate the instance
- A tainted resource will be destroyed and recreated during the next apply.
- If a resource is successfully created but fails a provisioning step, Terraform will error and mark the resource as tainted. A resource that is tainted still exists, but shouldn't be considered safe to use, since provisioning failed.
- When you generate your next execution plan, Terraform will remove any tainted resources and create new resources, attempting to provision them again after creation.
- Provisioners can also be defined that run only during a destroy operation. These are useful for performing system cleanup, extracting data, etc.
- https://github.com/GoogleCloudPlatform/terraform-google-examples 

# Provision Infrastructure

Google Cloud allows customers to manage their own custom operating system images. This can be a great way to ensure the instances you provision with Terraform are pre-configured based on your needs. Packer is the perfect tool for this and includes a builder for Google Cloud.

Terraform uses provisioners to upload files, run shell scripts, or install and trigger other software like configuration management tools.

To define a provisioner:
```
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]
  provisioner "local-exec" {
    command = "echo ${google_compute_instance.vm_instance.name}:  ${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
  }
  # ...
}
```

Commands to execute:
```
#Use terraform taint to tell Terraform to recreate the instance:
terraform taint google_compute_instance.vm_instance
terraform apply
```