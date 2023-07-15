variable "private_vmss_name" {
  description = "private vmss name"
  type        = string
  default     = "private-vmss"
}

variable "private_admin_username" {
  description = "admin username"
  type        = string
  default     = "azureuser"
}

variable "private_key_path" {
  description = "private key path"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Network security group private vmss inbound priorty:port for private vmss 
variable "private_vmss_inbound_ports" {
  description = "private vmss inbound ports"
  type        = list(string)
  default     = ["80", "443", "22"]
}