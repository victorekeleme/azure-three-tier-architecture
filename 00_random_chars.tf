# Random character creation resource
resource "random_string" "random" {
  length  = 5
  numeric = false
  upper   = false
  special = false
  lower   = true
}