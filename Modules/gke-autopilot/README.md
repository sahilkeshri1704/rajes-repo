```bash

█▀▀ █░░ █▀█ █░█ █▀▄ █░█░█ █▀▀ █▀█ ▀▄▀
█▄▄ █▄▄ █▄█ █▄█ █▄▀ ▀▄▀▄▀ ██▄ █▀▄ █░█
```

# GKE Autopilot Terraform Module
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.gke](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gke_cluster_name"></a> [gke\_cluster\_name](#input\_gke\_cluster\_name) | Name of the rancher server cluster | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The default region for GKE cluster | `string` | n/a | yes |
| <a name="input_master_authorized_source_ranges"></a> [master\_authorized\_source\_ranges](#input\_master\_authorized\_source\_ranges) | Whitelist IP addresses that can communicate to GKE control plane | `list(string)` | n/a | yes |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | CIDR block for control plane master | `string` | n/a | yes |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnet name for the cluster | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC for the cluster | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->