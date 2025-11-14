resource "time_sleep" "wait" {
  create_duration  = "${var.wait}s"
  destroy_duration = "${var.wait}s"
}

resource "random_uuid" "vpc_id" {
  depends_on = [time_sleep.wait]
}

resource "random_uuid" "public_subnet_id" {
  depends_on = [time_sleep.wait]
}

resource "random_uuid" "private_subnet_id" {
  depends_on = [time_sleep.wait]
}
