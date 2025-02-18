################################################################################
#                                Network Segment                               #
################################################################################

resource "google_compute_network" "this" {
  name                    = "vpc"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name          = "subnet"
  project       = var.project_id
  ip_cidr_range = var.ip_cidr_range[0]
  region        = var.region
  network       = google_compute_network.this.self_link
}

################################################################################
#                                Firewall Segment                              #
################################################################################

resource "google_compute_firewall" "this_ssh_external" {
  name    = "allow-ssh"
  project = var.project_id
  network = google_compute_network.this.self_link
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["jumphost"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "this_all_internal" {
  name    = "allow-k8s"
  project = var.project_id
  network = google_compute_network.this.self_link
  allow {
    protocol = "all"
  }

  target_tags   = ["kubernetes"]
  source_ranges = var.ip_cidr_range
}

################################################################################
#                                Compute Segment                               #
################################################################################


resource "google_compute_address" "this_jumphost" {
  name    = "external-ip"
  project = var.project_id
  region  = var.region
}

data "google_compute_image" "this" {
  family  = var.os_family
  project = var.os_project
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "google_compute_instance" "this_jumphost" {
  name    = var.jumphost_instance.name
  project = var.project_id

  zone         = "${var.region}-${var.zone}"
  machine_type = var.jumphost_instance.machine_type
  description  = var.jumphost_instance.description
  tags         = var.jumphost_instance.network_tags
  boot_disk {
    initialize_params {
      image = data.google_compute_image.this.self_link
      size  = var.jumphost_instance.disk_size
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${tls_private_key.this.public_key_openssh}"
  }

  network_interface {
    network    = google_compute_network.this.self_link
    subnetwork = google_compute_subnetwork.this.self_link
    access_config {
      nat_ip = google_compute_address.this_jumphost.address
    }
  }
}

resource "google_compute_instance" "this_control_plane" {
  name         = var.control_plane_instance.name
  project      = var.project_id
  zone         = "${var.region}-${var.zone}"
  machine_type = var.control_plane_instance.machine_type
  description  = var.control_plane_instance.description
  tags         = var.control_plane_instance.network_tags
  boot_disk {
    initialize_params {
      image = data.google_compute_image.this.self_link
      size  = var.control_plane_instance.disk_size
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${tls_private_key.this.public_key_openssh}"
  }

  network_interface {
    network    = google_compute_network.this.self_link
    subnetwork = google_compute_subnetwork.this.self_link
    access_config {
      network_tier = var.network_tier
    }
  }
}

resource "google_compute_instance" "this_worker" {
  count        = 2
  name         = "${var.worker_instance.name}-${count.index}"
  project      = var.project_id
  zone         = "${var.region}-${var.zone}"
  machine_type = var.worker_instance.machine_type
  description  = var.worker_instance.description
  tags         = var.worker_instance.network_tags
  boot_disk {
    initialize_params {
      image = data.google_compute_image.this.self_link
      size  = var.worker_instance.disk_size
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${tls_private_key.this.public_key_openssh}"
  }

  network_interface {
    network    = google_compute_network.this.self_link
    subnetwork = google_compute_subnetwork.this.self_link
    access_config {
      network_tier = var.network_tier
    }
  }
}
