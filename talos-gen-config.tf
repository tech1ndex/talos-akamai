resource "null_resource" "talosconfig_controlplane" {
  provisioner "local-exec" {
    command = "talosctl gen config talos-kubernetes-akamai https://${self.triggers.nodebalancer_ip} --with-examples=false"

  }

  triggers = {
    nodebalancer_ip = linode_nodebalancer.talos_cluster.ipv4
  }
}


