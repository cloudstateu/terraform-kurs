variable "azure_private_zones" {
  type = map(string)
  default = {
    "privatelink.azure-automation.net"            = true
    "privatelink.database.windows.net"            = true
    "privatelink.sql.azuresynapse.net"            = true
    "privatelink.dev.azuresynapse.net"            = true
    "privatelink.azuresynapse.net"                = true
    "privatelink.blob.core.windows.net"           = true
    "privatelink.file.core.windows.net"           = true
    "privatelink.table.core.windows.net"          = true
    "privatelink.queue.core.windows.net"          = true
    "privatelink.web.core.windows.net"            = true
    "privatelink.dfs.core.windows.net"            = true
    "privatelink.documents.azure.com"             = true
    "privatelink.mongo.cosmos.azure.com"          = true
    "privatelink.cassandra.cosmos.azure.com"      = true
    "privatelink.gremlin.cosmos.azure.com"        = true
    "privatelink.table.cosmos.azure.com"          = true
    "privatelink.batch.azure.com"                 = true
    "privatelink.postgres.database.azure.com"     = true
    "privatelink.mysql.database.azure.com"        = true
    "privatelink.mariadb.database.azure.com"      = true
    "privatelink.vaultcore.azure.net"             = true
    "privatelink.managedhsm.azure.net"            = true
    "azmk8s.io"                                   = true
    "privatelink.search.windows.net"              = true
    "privatelink.azconfig.io"                     = true
    "privatelink.backup.windowsazure.com"         = true
    "privatelink.siterecovery.windowsazure.com"   = true
    "privatelink.servicebus.windows.net"          = true
    "privatelink.azure-devices.net"               = true
    "privatelink.eventgrid.azure.net"             = true
    "privatelink.azurewebsites.net"               = true
    "privatelink.api.azureml.ms"                  = true
    "privatelink.notebooks.azure.net"             = true
    "privatelink.service.signalr.net"             = true
    "privatelink.monitor.azure.com"               = true
    "privatelink.oms.opinsights.azure.com"        = true
    "privatelink.ods.opinsights.azure.com"        = true
    "privatelink.agentsvc.azure-automation.net"   = true
    "privatelink.cognitiveservices.azure.com"     = true
    "afs.azure.net"                               = true
    "privatelink.datafactory.azure.net"           = true
    "privatelink.adf.azure.com"                   = true
    "privatelink.redis.cache.windows.net"         = true
    "privatelink.redisenterprise.cache.azure.net" = true
    "privatelink.purview.azure.com"               = true
    "privatelink.purviewstudio.azure.com"         = true
    "privatelink.digitaltwins.azure.net"          = true
    "privatelink.azurehdinsight.net"              = true
    "privatelink.his.arc.azure.com"               = true
    "privatelink.guestconfiguration.azure.com"    = true
    "privatelink.media.azure.net"                 = true
    "kusto.windows.net"                           = true
    "privatelink.azurestaticapps.net"             = true
    "privatelink.prod.migration.windowsazure.com" = true
    "privatelink.azure-api.net"                   = true
    "privatelink.developer.azure-api.net"         = true
    "privatelink.analysis.windows.net"            = true
    "privatelink.pbidedicated.windows.net"        = true
    "privatelink.tip1.powerquery.microsoft.com"   = true
    "privatelink.botplinks.botframework.com"      = true
    "privatelink.bottoken.botframework.com"       = true
  }
}

resource "azurerm_private_dns_zone" "dns-priv-endpoint" {
  for_each            = { for zone, enabled in var.azure_private_zones : zone => enabled if enabled == true }
  name                = each.key
  resource_group_name = azurerm_resource_group.rg-hub-dns.name
}

locals {
  one = [for s in var.list : upper(s)]

  two = [for k, v in var.map : length(k) + length(v)]

  three = [for i, v in var.list : "${i} is ${v}"]
  
  four = [for s in var.list : upper(s) if s != ""]
}