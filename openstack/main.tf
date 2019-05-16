# Provider
provider "openstack" {
  user_name = "${var.user_name}"
  password = "${var.user_password}"
  tenant_name = "${var.tenant_name}"
  tenant_id = "${var.tenant_id}"
  auth_url = "${var.auth_url}"
  region = "${var.region}"
}

resource "openstack_blockstorage_volume_v2" "gvol1" {
  name = "gvol1"
  size = 50
}

# Network
resource "openstack_networking_network_v2" "terralab" {
  name = "terralab"
}

# Subnet
resource "openstack_networking_subnet_v2" "terralab" {
  name       = "terralab"
  network_id = "${openstack_networking_network_v2.terralab.id}"
  cidr       = "10.10.0.0/24"
}

# External network reference
data "openstack_networking_network_v2" "ext_net" {
  name = "${var.ext_net}"
}

/* CYBERA doesn't expose Routers or Load balancers

# Router
resource "openstack_networking_router_v2" "terralab" {
  name                = "terralab"
  external_network_id = "${data.openstack_networking_network_v2.ext_net.id}"
}

# Router port
resource "openstack_networking_router_interface_v2" "terralab" {
  router_id = "${openstack_networking_router_v2.terralab.id}"
  subnet_id = "${openstack_networking_subnet_v2.terralab.id}"
}
*/

# Image
resource "openstack_images_image_v2" "cirros" {
  name             = "cirros"
  image_source_url = "https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
}

# Instance
resource "openstack_compute_instance_v2" "terralab" {
  name        = "terralab"
  image_id    = "${openstack_images_image_v2.cirros.id}"
  flavor_name = "m1.micro"

  network {
    uuid = "${openstack_networking_network_v2.terralab.id}"
  }
}

# Floating IP
resource "openstack_compute_floatingip_v2" "terralab" {
  pool = "${data.openstack_networking_network_v2.ext_net.name}"
}

# Floating IP assoctiation
resource "openstack_compute_floatingip_associate_v2" "terralab" {
  floating_ip = "${openstack_compute_floatingip_v2.terralab.address}"
  instance_id = "${openstack_compute_instance_v2.terralab.id}"
}
