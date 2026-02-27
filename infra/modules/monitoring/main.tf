resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name_prefix}-law"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_monitor_diagnostic_setting" "vmss_diag" {
  name                       = "${var.name_prefix}-vmss-diag"
  target_resource_id         = var.vmss_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "lb_diag" {
  name                       = "${var.name_prefix}-lb-diag"
  target_resource_id         = var.lb_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = "${var.name_prefix}-autoscale"
  resource_group_name = var.rg_name
  location            = var.location
  target_resource_id  = var.vmss_id

  profile {
    name = "cpu-profile"

    capacity {
      default = 2
      minimum = 2
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.vmss_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.vmss_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}



resource "azurerm_monitor_action_group" "cpu_alert_group" {
  name                = "${var.name_prefix}-actiongroup"
  resource_group_name = var.rg_name
  short_name          = "cpualert"

  email_receiver {
    name          = "admin"
    email_address = "providencegoma@gmail.com"
  }
}



resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "${var.name_prefix}-cpu-alert"
  resource_group_name = var.rg_name
  scopes              = [var.vmss_id]
  description         = "Alert when CPU > 80%"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.cpu_alert_group.id
  }
}

