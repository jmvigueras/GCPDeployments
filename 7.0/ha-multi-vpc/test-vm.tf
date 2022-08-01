# Create log disk for vm spoke1
resource "google_compute_disk" "logdisk-vm-spoke1" {
  name = "${var.prefix}-log-disk-vm-spoke1-${random_string.random_name_post.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone
}

# Create log disk for vm spoke2
resource "google_compute_disk" "logdisk-vm-spoke2" {
  name = "${var.prefix}-log-disk-vm-spoke2-${random_string.random_name_post.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone
}

# Create VM test spoke1
resource "google_compute_instance" "vm-spoke1" {
  name           = "${var.prefix}-vm-spoke1"
  machine_type   = var.machine-vm
  zone           = var.zone

  tags = ["${var.prefix}-t-fwr-vm-spoke1","${var.prefix}-t-route-vm-spoke1"]

 boot_disk {
    initialize_params {
      image = var.image-vm
    }
  }
  attached_disk {
    source = google_compute_disk.logdisk-vm-spoke1.name
  }
  network_interface {
    subnetwork = google_compute_subnetwork.spoke1-subnet.name
    network_ip = var.vm_spoke1_ip
  }
    service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-ro", "cloud-platform"]
  }
  scheduling {
    preemptible       = true
    automatic_restart = false
  }
}

# Create VM test spoke2
resource "google_compute_instance" "vm-spoke2" {
  name           = "${var.prefix}-vm-spoke2"
  machine_type   = var.machine-vm
  zone           = var.zone

  tags = ["${var.prefix}-t-fwr-vm-spoke2","${var.prefix}-t-route-vm-spoke2"]

 boot_disk {
    initialize_params {
      image = var.image-vm
    }
  }
  attached_disk {
    source = google_compute_disk.logdisk-vm-spoke2.name
  }
  network_interface {
    subnetwork = google_compute_subnetwork.spoke2-subnet.name
    network_ip = var.vm_spoke2_ip
  }
    service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-ro", "cloud-platform"]
  }
  scheduling {
    preemptible       = true
    automatic_restart = false
  }
}
