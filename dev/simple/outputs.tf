output "vpc_id" {
  description = "ID of the VPC"
  value       = random_uuid.vpc_id.result
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = random_uuid.public_subnet_id.result
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = random_uuid.private_subnet_id.result
}

output "public_subnet_cidr" {
  description = "CIDR block of the public subnet"
  value       = var.public_subnet_cidr
}

output "private_subnet_cidr" {
  description = "CIDR block of the private subnet"
  value       = var.private_subnet_cidr
}