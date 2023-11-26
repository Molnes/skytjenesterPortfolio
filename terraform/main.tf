provider "openstack" {
    cloud = "openstack"  
}

resource "openstack_compute_instance_v2" "hello-world" {
    name="hello-world"
    image_id="7f2988c1-03a3-45c5-9967-a14d451d4dba"
    flavor_id="a0d604a8-7678-4460-a7d1-60eca9bc48bb"
    key_pair="DevOpsKey"
    network {
        name = "DevOps"
    }
    security_groups = ["default"]
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

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
  
}