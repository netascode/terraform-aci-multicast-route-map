<!-- BEGIN_TF_DOCS -->
# Multicast Route Map Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

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
<!-- END_TF_DOCS -->