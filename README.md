<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-scaffolding/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-scaffolding/actions/workflows/test.yml)

# Terraform ACI Multicast Route Map Module

Manages ACI Multicast Route Map

Location in GUI:
`Tenants` » `XXX` » `Policies` » `Protocols` » `Route Maps for Multicast`

## Examples

```hcl
module "aci_multicast_route_map" {
  source  = "netascode/multicast-route-map/aci"
  version = ">= 0.0.1"

  name   = "MRM1"
  tenant = "ABC"
  multicast_route_map_entries = [
    {
      order     = 1
      action    = "deny"
      source_ip = "1.2.3.4/32"
      group_ip  = "224.0.0.0/8"
      rp_ip     = "3.4.5.6"
    },
    {
      order = 2
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Multicast Route Map name. | `string` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Multicast Route Map's Tenant Name. | `string` | `""` | no |
| <a name="input_multicast_route_map_entries"></a> [multicast\_route\_map\_entries](#input\_multicast\_route\_map\_entries) | Multicast Route Map Entries. `order` allowed range: `0-9999`. `action` allowed values: `permit` or `deny`. Default value `action`: `permit` | <pre>list(object({<br>    action    = optional(string, "permit")<br>    group_ip  = optional(string, "0.0.0.0")<br>    order     = number<br>    rp_ip     = optional(string, "0.0.0.0")<br>    source_ip = optional(string, "0.0.0.0")<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `pimRouteMapPol` object. |
| <a name="output_name"></a> [name](#output\_name) | Multicast Route Map name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest_managed.pimRouteMapEntry](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.pimRouteMapPol](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
<!-- END_TF_DOCS -->