variable "resource_group_name" {}
variable "environment_tag" {}
variable "location" {}
variable "admin_username" {}
variable "admin_password" {}
variable "prefix" {}








module "network" {
  source  = "app.terraform.io/JoeStack/network/azurerm"
  version = "2.0.0"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  tags                = {
                          environment = "${var.environment_tag}"
                        }
}

#module "ad-create" {
#  source  = "app.terraform.io/JoeStack/ad-create/azurerm"
#  version = "1.0.0"
#  admin_password = "${var.admin_password}"
#  admin_username = "${var.admin_username}"
#  location = "${var.location}"
#  prefix = "${var.prefix}"
##  #private_ip_address = "${cidrhost(module.network.subnet1, 10)}"
#  private_ip_address = "10.0.1.10"
#  resource_group_name = "${var.resource_group_name}"
#  subnet_id = "${module.network.azurerm_subnet.subnet.0.id}"
#  #subnet_id = "${module.network.azurerm_subnet.0.id}"
#}

output "sn_id" {
  value = "${data.azurerm_subnet.subnet.0.id}"
}
