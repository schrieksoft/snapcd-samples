variable "username" {}
variable "password" { sensitive = true}

resource local_file sensitive {
  content  = "Using username \"${var.username}\" and password \"${var.password}\""
  filename = "${path.module}/this.txt"
}
