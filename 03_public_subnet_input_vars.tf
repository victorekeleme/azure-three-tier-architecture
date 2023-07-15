# Public subnet name
variable "public_subnet_name" {
  description = "Public subnet name"
  type        = string
  default     = "public_subnet"
}

# Public subnet count
variable "public_subnet_count" {
  description = "Public subnet count"
  type        = number
  default     = 1
}

# Public subnet address space
variable "public_subnet_address_space" {
  description = "Public subnet address space"
  type        = list(string)
  default     = ["10.0.40.0/24"]
}


# Network security group public inbound priorty:port for public subnet
variable "public_subnet_inbound_ports" {
  description = "Public subnet inbound ports"
  type        = list(string)
  default     = ["80", "443", "22"]
}