provider "openstack" {
    cloud = "openstack"  
}

resource "openstack_compute_instance_v2" "hello-world" {
    name="hello-world"
    image_id="ad3d29f6-a8ab-41cd-bc09-bc9d2e65ae2a"
    flavor_id="a0d604a8-7678-4460-a7d1-60eca9bc48bb"
    key_pair="DevOpsKey"
    network {
        name = "DevOps"
    }
    security_groups = ["default"]

    user_data = file("${path.module}/cloud-init")

    
}

resource "openstack_networking_floatingip_v2" "fip_hello-world" {
    pool = "ntnu-internal"
    depends_on = [openstack_compute_instance_v2.hello-world]  
}

resource "openstack_compute_floatingip_associate_v2" "fip_hello-world" {
    floating_ip = openstack_networking_floatingip_v2.fip_hello-world.address
    instance_id = openstack_compute_instance_v2.hello-world.id
    depends_on = [openstack_networking_floatingip_v2.fip_hello-world]
}

output "floating_ip_address" {
  value = openstack_networking_floatingip_v2.fip_hello-world.address
}