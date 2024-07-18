resource "time_sleep" "wait_30_seconds" {
  depends_on = [linode_image.talos_latest,
    linode_instance.talos_controlplane_1,
    linode_instance.talos_controlplane_2,
    linode_instance.talos_controlplane_3,
    linode_instance_config.talos_controlplane_1,
    linode_instance_config.talos_controlplane_2,
    linode_instance_config.talos_controlplane_3,
    linode_instance_disk.talos_boot_disk,
    linode_instance_disk.talos_boot_disk_2,
    linode_instance_disk.talos_boot_disk_3,
    linode_nodebalancer.talos_cluster,
    linode_nodebalancer_node.talos_controlplane_1,
    linode_nodebalancer_node.talos_controlplane_2,
  linode_nodebalancer_node.talos_controlplane_3]
  create_duration = "30s"
}

resource "random_password" "root_pass" {
  length           = 16
  special          = true
  override_special = "_%@"
}


resource "null_resource" "talosctl_bootstrap_endpoint" {
  depends_on = [time_sleep.wait_30_seconds]

  provisioner "local-exec" {
    command = "talosctl --talosconfig talosconfig config endpoint ${self.triggers.endpoint}"

  }

  triggers = {
    endpoint = linode_instance.talos_controlplane_1.ip_address
  }
}

resource "null_resource" "talosctl_bootstrap_node" {
  depends_on = [null_resource.talosctl_bootstrap_endpoint]

  provisioner "local-exec" {
    command = "talosctl --talosconfig talosconfig config node ${self.triggers.node_ip}"

  }

  triggers = {
    node_ip = linode_instance.talos_controlplane_1.ip_address
  }
}

resource "terraform_data" "talosctl_bootstrap" {
  depends_on = [null_resource.talosctl_bootstrap_node]
  provisioner "local-exec" {
    command = "talosctl --talosconfig talosconfig bootstrap"
  }
}