resource "linode_nodebalancer" "talos_cluster" {
  label                = "talos-controlplane"
  region               = "ca-central"
  client_conn_throttle = 20
  tags                 = ["talos"]
}

resource "linode_nodebalancer_config" "talos_cluster" {
  nodebalancer_id = linode_nodebalancer.talos_cluster.id
  port            = 443
  protocol        = "tcp"
  check           = "connection"
}

resource "linode_nodebalancer_node" "talos_controlplane_1" {
  count           = "1"
  nodebalancer_id = linode_nodebalancer.talos_cluster.id
  config_id       = linode_nodebalancer_config.talos_cluster.id
  address         = "${linode_instance.talos_controlplane_1.private_ip_address}:6443"
  label           = linode_instance.talos_controlplane_1.label
  weight          = 100

  lifecycle {
    // Tell Terraform to implicitly recreate the NodeBalancer node when
    // the target instance has been marked for recreation.
    // See: https://github.com/linode/terraform-provider-linode/issues/1224
    replace_triggered_by = [linode_instance.talos_controlplane_1.id]
  }
}

resource "linode_nodebalancer_node" "talos_controlplane_2" {
  count           = "1"
  nodebalancer_id = linode_nodebalancer.talos_cluster.id
  config_id       = linode_nodebalancer_config.talos_cluster.id
  address         = "${linode_instance.talos_controlplane_2.private_ip_address}:6443"
  label           = linode_instance.talos_controlplane_2.label
  weight          = 100

  lifecycle {
    // Tell Terraform to implicitly recreate the NodeBalancer node when
    // the target instance has been marked for recreation.
    // See: https://github.com/linode/terraform-provider-linode/issues/1224
    replace_triggered_by = [linode_instance.talos_controlplane_2.id]
  }
}
resource "linode_nodebalancer_node" "talos_controlplane_3" {
  count           = "1"
  nodebalancer_id = linode_nodebalancer.talos_cluster.id
  config_id       = linode_nodebalancer_config.talos_cluster.id
  address         = "${linode_instance.talos_controlplane_3.private_ip_address}:6443"
  label           = linode_instance.talos_controlplane_3.label
  weight          = 100

  lifecycle {
    // Tell Terraform to implicitly recreate the NodeBalancer node when
    // the target instance has been marked for recreation.
    // See: https://github.com/linode/terraform-provider-linode/issues/1224
    replace_triggered_by = [linode_instance.talos_controlplane_3.id]
  }
}