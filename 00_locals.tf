# General variables for project
locals {
  department          = var.department
  resource_group_name = var.resource_group_name
  resource_prefix     = "${local.department}-${local.resource_group_name}"

  common_tags = {
    environment = var.environment
  }
}

