# Create log disk for active
resource "google_compute_disk" "logdisk_passive" {
  name = "${var.prefix}-log-disk-passive-${random_string.random_name_post.result}"
  size = 30
  type = "pd-standard"
  zone = var.zone
}

########### Instance Related

# active userdata pre-configuration
data "template_file" "setup-passive" {
  template = file("${path.module}/config-passive.conf")
  vars = {
    adminsport = var.adminsport
    port1_ip   = var.passive_port1_ip
    port1_mask = var.passive_port1_mask
    port1_net  = var.public_subnet
    port1_gw   = google_compute_subnetwork.public-subnet.gateway_address
    port2_ip   = var.passive_port2_ip
    port2_mask = var.passive_port2_mask
    port2_net  = var.private_subnet
    port2_gw   = google_compute_subnetwork.private-subnet.gateway_address
    port3_ip   = var.passive_port3_ip
    port3_mask = var.passive_port3_mask
    port3_net  = var.mgmt_subnet
    port3_gw   = google_compute_subnetwork.mgmt-subnet.gateway_address
    port4_ip   = var.passive_port4_ip
    port4_mask = var.passive_port4_mask
    port4_net  = var.spoke1_subnet
    port4_gw   = google_compute_subnetwork.spoke1-subnet.gateway_address
    port5_ip   = var.passive_port5_ip
    port5_mask = var.passive_port5_mask
    port5_net  = var.spoke1_subnet
    port5_gw   = google_compute_subnetwork.spoke2-subnet.gateway_address 
    peer_hb_ip        = var.active_port3_ip // acitve hb ip
    clusterip         = "${var.prefix}-cluster-ip"
    privateroute      = "${var.prefix}-private-route"
    spoke1route       = "${var.prefix}-spoke1-route"
    spoke2route       = "${var.prefix}-spoke2-route"
    spoke1-subnet     = google_compute_subnetwork.spoke1-subnet.name
    spoke2-subnet     = google_compute_subnetwork.spoke2-subnet.name
    private-subnet    = google_compute_subnetwork.private-subnet.name
  }
}

# Create static active instance management ip
resource "google_compute_address" "static-passive-mgmt" {
  name = "${var.prefix}-passivemgmt-ip"
}

# Create FGTVM compute passive instance
resource "google_compute_instance" "fgt-passive" {
  name           = "${var.prefix}-fgt-passive"
  machine_type   = var.machine
  zone           = var.zone
  can_ip_forward = "true"

  tags = ["${var.prefix}-t-fwr-ftg-mgmt","${var.prefix}-t-fwr-ftg-public","${var.prefix}-t-fwr-fgt-private","${var.prefix}-t-fwr-fgt-spoke1","${var.prefix}-t-fwr-fgt-spoke2", "${var.prefix}-t-fwr-ftg-ha"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  attached_disk {
    source = google_compute_disk.logdisk_passive.name
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public-subnet.name
    network_ip = var.passive_port1_ip
  }
  network_interface {
    subnetwork = google_compute_subnetwork.private-subnet.name
    network_ip = var.passive_port2_ip
  }
  network_interface {
    subnetwork = google_compute_subnetwork.mgmt-subnet.name
    network_ip = var.passive_port3_ip
    access_config {
      nat_ip = google_compute_address.static-passive-mgmt.address
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.spoke1-subnet.name
    network_ip = var.passive_port4_ip
  }
  network_interface {
    subnetwork = google_compute_subnetwork.spoke2-subnet.name
    network_ip = var.passive_port5_ip
  }

  metadata = {
    user-data = "${data.template_file.setup-passive.rendered}"
    license   = fileexists("${path.module}/${var.licenseFile}") ? "${file(var.licenseFile)}" : null
  }
  service_account {
    scopes = ["userinfo-email", "compute-rw", "storage-ro", "cloud-platform"]
  }
  scheduling {
    preemptible       = true
    automatic_restart = false
  }
}