# Terraform Private VPC Lab

A Terraform learning project that creates an isolated AWS VPC with one subnet, a dedicated route table, and security groups.

## What it creates

- Custom VPC (`10.30.0.0/16`)
- Subnet (`10.30.1.0/24`) with automatic public IPv4 assignment disabled
- Dedicated route table associated with the subnet
- No Internet Gateway or NAT Gateway route
- Security group with no ingress or egress rules

## Security notes

This subnet has no route to the internet through its route table. This is a learning lab, not a production-ready network design.

Terraform also manages the VPC's default security group. Review `main.tf` before applying this configuration to any account or VPC.

## Requirements

- Terraform
- AWS CLI
- AWS credentials with the required VPC permissions

## Use

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
