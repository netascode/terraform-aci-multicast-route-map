variable "name" {
  description = "Multicast Route Map name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "tenant" {
  description = "Multicast Route Map's Tenant Name."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.tenant))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "multicast_route_map_entries" {

  description = "Multicast Route Map Entries. `order` allowed range: `0-9999`. `action` allowed values: `permit` or `deny`. Default value `action`: `permit`"
  type = list(object({
    action    = optional(string, "permit")
    group_ip  = optional(string, "0.0.0.0")
    order     = number
    rp_ip     = optional(string, "0.0.0.0")
    source_ip = optional(string, "0.0.0.0")
  }))
  default = []

  validation {
    condition = alltrue([
      for entry in var.multicast_route_map_entries : entry.order >= 0 && entry.order <= 9999
    ])
    error_message = "`order`: Allowed range: `0-9999`."
  }

  validation {
    condition = alltrue([
      for entry in var.multicast_route_map_entries : try(contains(["permit", "deny"], entry.action), false)
    ])
    error_message = "`action`: Allowed values: `permit` or `deny`."
  }
}