# Project department
variable "department" {
  description = "project's department"
  type        = string
  default     = "acc"
}

# Project environment
variable "environment" {
  description = "project's environment"
  type        = string
  default     = "dev"
}

# Resource group variables
variable "resource_group_name" {
  description = "resource group name"
  type        = string
  default     = "dev"
}

variable "resource_group_location" {
  description = "resource group name"
  type        = string
  default     = "eastus"
}
