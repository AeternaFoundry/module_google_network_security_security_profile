resource "google_network_security_security_profile" "network_security_security_profiles" {
  for_each = var.network_security_security_profiles

  name            = each.value.name
  type            = each.value.type
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  labels          = each.value.labels
  location        = each.value.location
  parent          = each.value.parent

  dynamic "custom_intercept_profile" {
    for_each = each.value.custom_intercept_profile != null ? [each.value.custom_intercept_profile] : []
    content {
      intercept_endpoint_group = custom_intercept_profile.value.intercept_endpoint_group
    }
  }

  dynamic "custom_mirroring_profile" {
    for_each = each.value.custom_mirroring_profile != null ? [each.value.custom_mirroring_profile] : []
    content {
      mirroring_deployment_groups = custom_mirroring_profile.value.mirroring_deployment_groups
      mirroring_endpoint_group    = custom_mirroring_profile.value.mirroring_endpoint_group
    }
  }

  dynamic "threat_prevention_profile" {
    for_each = each.value.threat_prevention_profile != null ? [each.value.threat_prevention_profile] : []
    content {
      dynamic "antivirus_overrides" {
        for_each = threat_prevention_profile.value.antivirus_overrides != null ? threat_prevention_profile.value.antivirus_overrides : []
        content {
          action   = antivirus_overrides.value.action
          protocol = antivirus_overrides.value.protocol
        }
      }
      dynamic "severity_overrides" {
        for_each = threat_prevention_profile.value.severity_overrides != null ? threat_prevention_profile.value.severity_overrides : []
        content {
          action   = severity_overrides.value.action
          severity = severity_overrides.value.severity
        }
      }
      dynamic "threat_overrides" {
        for_each = threat_prevention_profile.value.threat_overrides != null ? threat_prevention_profile.value.threat_overrides : []
        content {
          action    = threat_overrides.value.action
          threat_id = threat_overrides.value.threat_id
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "url_filtering_profile" {
    for_each = each.value.url_filtering_profile != null ? [each.value.url_filtering_profile] : []
    content {
      dynamic "url_filters" {
        for_each = url_filtering_profile.value.url_filters != null ? url_filtering_profile.value.url_filters : []
        content {
          filtering_action = url_filters.value.filtering_action
          priority         = url_filters.value.priority
          urls             = url_filters.value.urls
        }
      }
    }
  }
}

