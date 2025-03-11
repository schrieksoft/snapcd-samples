resource "random_pet" "username" {}
resource "random_password" "password" {
  length  = 12
  upper   = false
  lower   = true
  numeric = true
  special = false
}

output "username" {
  value = random_pet.username.id
}

output "password" {
  value     = random_password.password.result
  sensitive = true
}
