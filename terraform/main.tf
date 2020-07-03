provider "google" {
  project = "apollo-task-282212"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  name         = "apollo-tt-instance"
  machine_type = "f1-micro"

  tags = ["test-webserver"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = google_compute_network.vpc_network.self_link
    access_config {
    }
  }

  metadata = {
    ssh-keys = "apollo:${file("~/.ssh/apollo.pub")}"
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "apollo-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "apollo-tt-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "22"]
  }

  target_tags = ["test-webserver"]
  source_ranges = ["104.56.114.248/32","198.144.216.128/32","103.129.121.173/32","192.195.81.38/32","103.253.151.66/32"]
}