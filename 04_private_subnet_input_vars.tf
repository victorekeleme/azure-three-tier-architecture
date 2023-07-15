# private subnet name
variable "private_subnet_name" {
  description = "private subnet name"
  type        = string
  default     = "private_subnet"
}

# private subnet count
variable "private_subnet_count" {
  description = "private subnet count"
  type        = number
  default     = 1
}

# private subnet address space
variable "private_subnet_address_space" {
  description = "private subnet address space"
  type        = list(string)
  default     = ["10.0.70.0/24"]
}


# Network security group private inbound priorty:port for private subnet
variable "private_subnet_inbound_ports" {
  description = "private subnet inbound ports"
  type        = list(string)
  default     = ["80", "443", "22"]
}