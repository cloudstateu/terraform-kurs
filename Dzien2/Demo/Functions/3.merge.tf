# https://developer.hashicorp.com/terraform/language/functions/merge
# https://developer.hashicorp.com/terraform/language/functions/flatten

locals {
  policies = {
    general = [
      "policy1",
      "policy2",
      "policy3"
    ]
    network = [
      "policy1",
      "policy2",
      "policy3"
    ]
  }

  final = {
    "general_policy1" = {
      name     = "policy1"
      category = "general"
    }
    "general_policy2" = {
      name     = "policy2"
      category = "general"
    }
    "general_policy3" = {
      name     = "policy3"
      category = "general"
    }
    "network_policy1" = {
      name     = "policy1"
      category = "network"
    }
    "network_policy2" = {
      name     = "policy2"
      category = "network"
    }
    "network_policy3" = {
      name     = "policy3"
      category = "network"
    }
  }
}

locals {
  temp1 = [
    for policy_category, policies in local.policies : [
      for policy_name in policies : {
        "${policy_category}_${policy_name}" = {
          name     = policy_name
          category = policy_category
        }
      }
    ]
  ]
}

output "temp" {
  value = merge(flatten(local.temp1)...)
}
