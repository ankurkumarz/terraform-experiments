# Challenge

## Creating the folder structure
```
touch main.tf variables.tf
mkdir -p modules/instances
touch modules/instances/instances.tf
touch modules/instances/outputs.tf
touch modules/instances/variables.tf
mkdir -p modules/storage
touch modules/storage/storage.tf
touch modules/storage/outputs.tf
touch modules/storage/variables.tf
```

## update variables.tf
```
variable "region" {
 default = " us-east1"
}

variable "zone" {
 default = "<ZONE_ID”
}

variable "project_id" {
 default = "<REPLACE PROJECT ID>"
}
```

## Refer to main.tf
```
terraform init
```

## Import Infrastructure
- Refer to instances.tf file
- Copy INSTANCE from Google Cloud Console
- Run Import:
```
terraform import module.instances.google_compute_instance.tf-instance-1 <Instance ID - 1>
terraform import module.instances.google_compute_instance.tf-instance-2 <Instance ID - 2>
```
## Change the Storage to Google Cloud Bucket
- Update backend in main.tf
- Run in cloud shell:
```
terraform init
terraform apply
```

## Update the instance type
- Update for 2 instance types
```
machine_type = "n1-standard-2"
```
- Copy INSTANCE_NAME from instructions and copy
- Uncomment 3rd INSTANCE_NAME section

## TAINT and DESTROY
```
terraform taint module.instances.google_compute_instance.Instance_name
```

##  Use a module from the Registry
- Uncomment VPC section