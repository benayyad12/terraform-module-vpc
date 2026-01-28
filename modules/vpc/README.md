# VPC Module (Simple)

Creates a simple AWS network:
- 1 VPC
- 1 subnet (public or private)
- If `subnet_public = true`: Internet Gateway + public route table + default route (`0.0.0.0/0`) + association


## Usage (from a root module)

In your root `main.tf`:

```hcl
module "vpc" {
  source = "./modules/vpc"  # or "git::https://github.com/<org>/<repo>.git//modules/vpc?ref=vX.Y.Z"

  cidr_block        = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  az                = var.availability_zone
  vpc_name          = var.vpc_name

  subnet_public = var.subnet_public

  tags = {
    Environment = var.environment
    Owner       = "you"
  }
}
```

Then run:

```bash
terraform init
terraform plan  -var-file="values.tfvars"
terraform apply -var-file="values.tfvars"
```

## Example `values.tfvars`

```hcl
region             = "eu-west-3"
availability_zone  = "eu-west-3a"
vpc_cidr_block     = "10.0.0.0/16"
subnet_cidr_block  = "10.0.1.0/24"
vpc_name           = "my-vpc"
subnet_public      = true
```

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `cidr_block` | `string` | yes | VPC CIDR (example: `10.0.0.0/16`) |
| `subnet_cidr_block` | `string` | yes | Subnet CIDR inside the VPC CIDR (example: `10.0.1.0/24`) |
| `az` | `string` | yes | Availability Zone (example: `eu-west-3a`) |
| `vpc_name` | `string` | yes | Name tag for the VPC |
| `subnet_public` | `bool` | yes | If `true`, creates IGW + public routing and assigns public IPs on launch |
| `tags` | `map(string)` | no | Extra tags applied to all resources (default `{}`) |

## Outputs

| Name | Description |
|------|-------------|
| `vpc_id` | ID of the created VPC |
| `subnet_id` | ID of the created subnet |
| `internet_gateway_id` | IGW ID if created, otherwise `null` |
| `route_table_id` | Public route table ID if created, otherwise `null` |

## Notes

- A subnet is “public” when it has a default route (`0.0.0.0/0`) to an Internet Gateway.
- `map_public_ip_on_launch = true` makes instances launched in that subnet get a public IPv4 automatically.
- This module creates only **one subnet**. To evolve it, the next step is supporting multiple subnets with `for_each`.
