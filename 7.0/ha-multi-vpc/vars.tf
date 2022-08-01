# GCP resourcers prefix description
variable "prefix" {
  type    = string
  default = "terraform"
}
# GCP project name
variable "project" {
  type    = string
  default = "<Project Name>"
}
# GCP oauth access token
variable "token" {
  type    = string
  default = "<ACCESS TOKEN>"
}
# GCP region
variable "region" {
  type    = string
  default = "europe-west4" #Default Region
}
# GCP zone
variable "zone" {
  type    = string
  default = "europe-west4-a" #Default Zone
}

# FortiGate Image name
# 7.0.5 payg is projects/fortigcp-project-001/global/images/fortinet-fgtondemand-705-20220211-001-w-license
# 7.0.5 byol is projects/fortigcp-project-001/global/images/fortinet-fgt-705-20220211-001-w-license
variable "image" {
  type    = string
  default = "projects/fortigcp-project-001/global/images/fortinet-fgtondemand-705-20220211-001-w-license"
}

# VM test Image name
variable "image-vm" {
  type    = string
  default = "projects/debian-cloud/global/images/debian-11-bullseye-v20220719"
}

// HTTPS Port
variable "adminsport" {
  type    = string
  default = "8443"
}

# GCP instance machine type
variable "machine" {
  type    = string
  default = "n1-standard-8"
}
# GCP instance machine type for testing vm
variable "machine-vm" {
  type    = string
  default = "e2-micro"
}
# VPC CIDR
variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}
# Public Subnet CIDR
variable "public_subnet" {
  type    = string
  default = "172.16.1.0/24"
}
# Private Subnet CIDR
variable "private_subnet" {
  type    = string
  default = "172.16.2.0/24"
}
# MGMT Subnet CIDR
variable "mgmt_subnet" {
  type    = string
  default = "172.16.3.0/24"
}
# Spoke1 Subnet CIDR
variable "spoke1_subnet" {
  type    = string
  default = "172.16.4.0/24"
}
# Spoke2 Subnet CIDR
variable "spoke2_subnet" {
  type    = string
  default = "172.16.5.0/24"
}
# license file for active
variable "licenseFile" {
  type    = string
  default = "license1.lic"
}
# license file for passive
variable "licenseFile2" {
  type    = string
  default = "license2.lic"
}

# hamgmt gateway ip, depends on your mgmt subnet cidr
variable "mgmt_gateway" {
  type    = string
  default = "172.16.3.1"
}
variable "mgmt_mask" {
  type    = string
  default = "255.255.255.0"
}

# Public gateway ip
variable "public_gateway" {
  type    = string
  default = "172.16.1.1"
}
variable "public_mask" {
  type    = string
  default = "255.255.255.0"
}

# active interface VM test ip assignments
variable "vm_spoke1_ip" {
  type    = string
  default = "172.16.4.4"
}
variable "vm_spoke2_ip" {
  type    = string
  default = "172.16.5.4"
}

# active interface ip assignments
# active Public IP
variable "active_port1_ip" {
  type    = string
  default = "172.16.1.2"
}
variable "active_port1_mask" {
  type    = string
  default = "24"
}
# active Private IP
variable "active_port2_ip" {
  type    = string
  default = "172.16.2.2"
}
variable "active_port2_mask" {
  type    = string
  default = "24"
}
# active MGMT-HA IP
variable "active_port3_ip" {
  type    = string
  default = "172.16.3.2"
}
variable "active_port3_mask" {
  type    = string
  default = "24"
}
# active spoke1 IP
variable "active_port4_ip" {
  type    = string
  default = "172.16.4.2"
}
variable "active_port4_mask" {
  type    = string
  default = "24"
}
# active spoke2 IP
variable "active_port5_ip" {
  type    = string
  default = "172.16.5.2"
}
variable "active_port5_mask" {
  type    = string
  default = "24"
}

# passive interface ip assignments
# passive Public IP
variable "passive_port1_ip" {
  type    = string
  default = "172.16.1.3"
}
variable "passive_port1_mask" {
  type    = string
  default = "24"
}
# passive Private IP
variable "passive_port2_ip" {
  type    = string
  default = "172.16.2.3"
}
variable "passive_port2_mask" {
  type    = string
  default = "24"
}
# passive MGMT-HA IP
variable "passive_port3_ip" {
  type    = string
  default = "172.16.3.3"
}
variable "passive_port3_mask" {
  type    = string
  default = "24"
}
# passive spoke1 IP
variable "passive_port4_ip" {
  type    = string
  default = "172.16.4.3"
}
variable "passive_port4_mask" {
  type    = string
  default = "24"
}
# passive spoke2 IP
variable "passive_port5_ip" {
  type    = string
  default = "172.16.5.3"
}
variable "passive_port5_mask" {
  type    = string
  default = "24"
}

