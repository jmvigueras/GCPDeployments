########### Network Related ########### 
### VPC ###
resource "google_compute_network" "vpc-mgmt" {
  name                    = "${var.prefix}-vpc-mgmt"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc-public" {
  name                    = "${var.prefix}-vpc-public"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc-private" {
  name                    = "${var.prefix}-vpc-private"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc-spoke1" {
  name                    = "${var.prefix}-vpc-spoke1"
  auto_create_subnetworks = false
}

resource "google_compute_network" "vpc-spoke2" {
  name                    = "${var.prefix}-vpc-spoke2"
  auto_create_subnetworks = false
}

### HA MGMT SYNC Subnet ###
resource "google_compute_subnetwork" "mgmt-subnet" {
  name          = "${var.prefix}-mgmt-subnet"
  region        = var.region
  network       = google_compute_network.vpc-mgmt.name
  ip_cidr_range = var.mgmt_subnet
}
### Public Subnet ###
resource "google_compute_subnetwork" "public-subnet" {
  name                     = "${var.prefix}-public-subnet"
  region                   = var.region
  network                  = google_compute_network.vpc-public.name
  ip_cidr_range            = var.public_subnet
  private_ip_google_access = true
}
### Private Subnet ###
resource "google_compute_subnetwork" "private-subnet" {
  name          = "${var.prefix}-private-subnet"
  region        = var.region
  network       = google_compute_network.vpc-private.name
  ip_cidr_range = var.private_subnet
}
### Spoke1 Subnet ###
resource "google_compute_subnetwork" "spoke1-subnet" {
  name          = "${var.prefix}-spoke1-subnet"
  region        = var.region
  network       = google_compute_network.vpc-spoke1.name
  ip_cidr_range = var.spoke1_subnet
}
### Spoke2 Subnet ###
resource "google_compute_subnetwork" "spoke2-subnet" {
  name          = "${var.prefix}-spoke2-subnet"
  region        = var.region
  network       = google_compute_network.vpc-spoke2.name
  ip_cidr_range = var.spoke2_subnet
}

