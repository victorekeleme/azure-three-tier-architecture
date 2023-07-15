# virtual network variables
variable "vnet_address_space" {
  description = "virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
