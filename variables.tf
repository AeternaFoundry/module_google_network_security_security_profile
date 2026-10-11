variable "network_security_security_profiles" {
  description = <<EOT
Map of network_security_security_profiles, attributes below
Required:
    - name
    - type
Optional:
    - deletion_policy
    - description
    - labels
    - location
    - parent
    - custom_intercept_profile (block):
        - intercept_endpoint_group (required)
    - custom_mirroring_profile (block):
        - mirroring_deployment_groups (optional)
        - mirroring_endpoint_group (required)
    - threat_prevention_profile (block):
        - antivirus_overrides (optional, block):
            - action (required)
            - protocol (required)
        - severity_overrides (optional, block):
            - action (required)
            - severity (required)
        - threat_overrides (optional, block):
            - action (required)
            - threat_id (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - url_filtering_profile (block):
        - url_filters (optional, block):
            - filtering_action (required)
            - priority (required)
            - urls (optional)
EOT

  type = map(object({
    name            = string
    type            = string
    deletion_policy = optional(string)
    description     = optional(string)
    labels          = optional(map(string))
    location        = optional(string)
    parent          = optional(string)
    custom_intercept_profile = optional(object({
      intercept_endpoint_group = string
    }))
    custom_mirroring_profile = optional(object({
      mirroring_deployment_groups = optional(list(string))
      mirroring_endpoint_group    = string
    }))
    threat_prevention_profile = optional(object({
      antivirus_overrides = optional(list(object({
        action   = string
        protocol = string
      })))
      severity_overrides = optional(list(object({
        action   = string
        severity = string
      })))
      threat_overrides = optional(list(object({
        action    = string
        threat_id = string
      })))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    url_filtering_profile = optional(object({
      url_filters = optional(list(object({
        filtering_action = string
        priority         = number
        urls             = optional(list(string))
      })))
    }))
  }))
  # Note: 7 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

