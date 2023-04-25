resource "azurerm_log_analytics_workspace" "log" {
  name                = "${local.prefix}-log"
  location            = data.azurerm_resource_group.studentXX.location
  resource_group_name = data.azurerm_resource_group.studentXX.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

data "azurerm_monitor_diagnostic_categories" "kv_ds_categories" {
  resource_id = azurerm_key_vault.chmstudentXXkv.id
}

resource "azurerm_monitor_diagnostic_setting" "log_ds" {
  name                       = "${local.prefix}-log-kv-ds"
  target_resource_id         = azurerm_key_vault.chmstudentXXkv.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log.id

  # enabled_log {
  #   category = "AuditEvent"
  # }

  # enabled_log {
  #   category = "AzurePolicyEvaluationDetails"
  # }

  # metric {
  #   enabled  = true
  #   category = "AllMetrics"
  # }

   dynamic "enabled_log" {
     for_each = data.azurerm_monitor_diagnostic_categories.kv_ds_categories.log_category_types
     content {
       category = enabled_log.value
     }
   }
  
   dynamic "metric" {
     for_each = data.azurerm_monitor_diagnostic_categories.kv_ds_categories.metrics
     content {
       enabled  = true
       category = metric.value
     }
   }
}
