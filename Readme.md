# Terraform Cloud Configuration Demo

This project demonstrates the use of Terraform to configure cloud resources on OpenTelekomCloud. The configuration includes setting up a VPC, CCE, DNS, Load Balancer, SWR, and other necessary resources.

## Prerequisites

- Terraform >= 0.12
- OpenTelekomCloud account
- Access to the OpenTelekomCloud API

## Project Structure

- `stages/development/main.tf`: Main Terraform configuration file for the development stage.
- `modules/`: Directory containing reusable Terraform modules.

## Configuration
1. Define the variables in a `variables.tf` file.
2. Reference these variables in the `provider` block.
3. Add a `.gitignore` file to exclude the `terraform.tfvars` file from being committed.

### Step-by-Step Plan:
1. Create a `variables.tf` file to define the variables.
2. Modify the `provider` block to use these variables.
3. Create a `terraform.tfvars` file to set the values for these variables.
4. Add a `.gitignore` file to exclude the `terraform.tfvars` file.

### Code:

#### `variables.tf`
```terraform ```
The folowwed variables need to be set in your Terraform configuration:
```
variable "user_name" {
  type        = string
  description = "OpenTelekomCloud user name."
}

variable "password" {
  type        = string
  description = "OpenTelekomCloud password."
}

variable "domain_name" {
  type        = string
  description = "OpenTelekomCloud domain name."
}

variable "tenant_name" {
  type        = string
  description = "OpenTelekomCloud tenant name."
}
```
Instead of using the variables.tf file, you can use the terraform.tfvars file to set the variables or insert the variables directly into the console. (at your own risk)
you can read more about the variables.tf and tfvars files [here](https://developer.hashicorp.com/terraform/language/values/variables)


#### `stages/development/main.tf`
```terraform
provider "opentelekomcloud" {
  user_name   = var.user_name
  password    = var.password
  domain_name = var.domain_name
  tenant_name = var.tenant_name
}
```

#### `terraform.tfvars`
```hcl
user_name   = "your_username"
password    = "your_password"
domain_name = "your_domain"
tenant_name = "your_tenant"
```

#### `.gitignore`
```
terraform.tfvars
```

### Variables

The following variables need to be set in your Terraform configuration:

- `project_name`: Name of the project.
- `stage_name`: Stage name (e.g., dev, prod).
- `cidr`: CIDR block for the VPC.
- `node_flavor`: Flavor ID for the CCE nodes.
- `tags`: Tags to apply to the resources.
- `allowed_ip`: Allowed IP addresses for access control.
- `region`: Region for the resources.

### Example

Here is an example of how to set the variables in a `terraform.tfvars` file:

```hcl
project_name  = "your_project"
stage_name    = "dev"
cidr          = "10.0.0.0/16"
node_flavor   = "s2.large.2"
tags          = { "env" = "dev" }
allowed_ip    = ["0.0.0.0/0"]
region        = "eu-de"
```
### Running the Configuration
First, you need to  to be in the ```stages/development```  directory.
initialize the Terraform configuration by running the following command:
```shell
terraform init
```


Then, you can ethe apply or view the planed configuration by running the following command:
for view the planed configuration and changes ran the command below:\
```shell
bash terraform plan
```
you can also run the following command to apply the configuration:
```shell
bash terraform apply
```
