variable "public_vmss_name" {
  description = "public vmss name"
  type        = string
  default     = "public-vmss"
}

variable "admin_username" {
  description = "admin username"
  type        = string
  default     = "azureuser"
}

variable "public_key_path" {
  description = "public key path"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Network security group public vmss inbound priorty:port for public vmss 
variable "public_vmss_inbound_ports" {
  description = "public vmss inbound ports"
  type        = list(string)
  default     = ["80", "443", "22"]
}