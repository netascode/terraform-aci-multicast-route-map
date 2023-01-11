resource "aci_rest_managed" "pimRouteMapPol" {
  dn         = "uni/tn-${var.tenant}/rtmap-${var.name}"
  class_name = "pimRouteMapPol"
  content = {
    name = var.name
  }
}

resource "aci_rest_managed" "pimRouteMapEntry" {
  for_each   = { for entry in var.multicast_route_map_entries : entry.order => entry }
  dn         = "${aci_rest_managed.pimRouteMapPol.id}/rtmapentry-${each.key}"
  class_name = "pimRouteMapEntry"
  content = {
    action = each.value.action
    grp    = each.value.group_ip
    order  = each.value.order
    rp     = each.value.rp_ip
    src    = each.value.source_ip
  }
}