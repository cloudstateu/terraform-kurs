# condition ? true_val : false_val

# "Hello ${var.example}"

resource "azurerm_resource_group" "example" {
  name     = "Hello ${lower(var.example)}"
  location = var.is_production == true ? "West Europe" : "East US"
}

variable "is_production" {
  type = bool
  default = false
}
