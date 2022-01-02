# Deploy key file for ssh connection
locals {
  public_key_file  = "../../.ssh/ecs_fargate_sample/${var.key_name}.id_rsa.pub"
  private_key_file = "../../.ssh/ecs_fargate_sample/${var.key_name}.id_rsa"
}

resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  filename = local.private_key_file
  content  = tls_private_key.keygen.private_key_pem

  provisioner "local-exec" {
    command = "chmod -x ${local.private_key_file}"
  }
}

resource "local_file" "public_key_openssh" {
  filename = local.public_key_file
  content  = tls_private_key.keygen.public_key_openssh

  # Disable execute permission
  provisioner "local-exec" {
    command = "chmod -x ${local.public_key_file}"
  }
}

output "key_name" {
  value = var.key_name
}

output "private_key_file" {
  value = local.private_key_file
}

output "private_key_pem" {
  value     = tls_private_key.keygen.private_key_pem
  sensitive = true
}

output "public_key_file" {
  value = local.public_key_file
}

output "public_key_openssh" {
  value = tls_private_key.keygen.public_key_openssh
}
