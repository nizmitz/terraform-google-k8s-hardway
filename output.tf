output "project_id" {
  value = var.project_id
}

output "zone" {
  value = "${var.region}-${var.zone}"
}

output "ssh_user" {
  value = var.ssh_user
}

output "ssh_private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "private_ip" {
  value = {
    "worker"        = google_compute_instance.this_worker.*.network_interface.0.network_ip,
    "control_plane" = google_compute_instance.this_control_plane.network_interface.0.network_ip
  }
}