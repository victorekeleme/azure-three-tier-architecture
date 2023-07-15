# database subnet name
variable "database_subnet_name" {
  description = "database subnet name"
  type        = string
  default     = "database_subnet"
}

# database subnet count
variable "database_subnet_count" {
  description = "database subnet count"
  type        = number
  default     = 1
}

# database subnet address space
variable "database_subnet_address_space" {
  description = "database subnet address space"
  type        = list(string)
  default     = ["10.0.100.0/24"]
}


# Network security group database inbound priorty:port for database subnet
variable "database_subnet_inbound_ports" {
  description = "database subnet inbound ports"
  type        = list(string)
  default     = ["80", "443", "22"]
}