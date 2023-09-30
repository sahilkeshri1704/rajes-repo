```bash

█▀▀ █░░ █▀█ █░█ █▀▄ █░█░█ █▀▀ █▀█ ▀▄▀
█▄▄ █▄▄ █▄█ █▄█ █▄▀ ▀▄▀▄▀ ██▄ █▀▄ █░█
```
# VPC Terraform Module

This Terraform module provides a reusable module for creating a VPC (Virtual Private Cloud) in Google Cloud Platform (GCP). It provisions a VPC network, subnetwork, IP address blocks, and enables private services access. Additionally, it sets up NAT (Network Address Translation) for resources within the private subnet to access the internet.


## Features

- **VPC Creation**: This module creates a VPC network with customizable name and CIDR range.

- **Subnet Configuration**: It allows you to define multiple subnets within the VPC, each with its own name and CIDR range.

- **Private IP Addressing**: The module allocates a block of private IP addresses that are accessible only from within the VPC. This enhances security and improves latency by routing requests to private IPs through Google's network.

- **Private Services Access**: Private services access is enabled, allowing instances within the VPC and Google services to communicate exclusively using internal IP addresses.

- **NAT Gateway**: The module sets up a NAT gateway for resources within the private subnet to access the internet.

- **Logging Configuration**: Detailed logging is enabled for the NAT gateway to capture errors.


## Usage

To use this module, include the following code in your Terraform configuration:

```ruby
module "vpc" {
  source = "path/to/module"

  name           = var.name
  subnet_name    = var.subnet_name
  gcp_region     = var.gcp_region
  ip_cidr_range  = var.ip_cidr_range
}
```

Be sure to replace `path/to/module` with the actual path where this module is located.


## Inputs

This module accepts the following input variables:

- `name` (required): The name of the VPC to create. It should be provided as a map of string values, where each key represents a unique identifier for the VPC.

- `subnet_name` (required): The name of the subnet to create. Similar to the `name` variable, it should be provided as a map of string values.

- `gcp_region` (required): The default region for the VPC connector. Specify it as a string.

- `ip_cidr_range` (required): The IP CIDR range for the VPC. Provide it as a string.

## Outputs

This module exposes the following outputs:

- `link`: A link to the VPC resource, which can be used to create resources inside the VPC. It returns a list of self links for each VPC.

- `vpc_name`: The name of the VPC. It returns a list of VPC names.

- `subnet_name`: The name of the VPC subnet. It returns a list of subnet names.

- `private_vpc_connection`: The private VPC connection. It returns a map of private VPC connections.

## Example

Here's an example usage of the VPC module:

```ruby
module "vpc" {
  source = "path/to/module"

  name = {
    "vpc1" = "my-vpc-1"
    "vpc2" = "my-vpc-2"
  }

  subnet_name = {
    "vpc1" = "subnet1"
    "vpc2" = "subnet2"
  }

  gcp_region = "us-central1"
  ip_cidr_range = "10.0.0.0/16"
}
```

In this example, two VPCs are created with their respective subnets, using the provided name and subnet configurations.

