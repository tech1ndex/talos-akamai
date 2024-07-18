resource "linode_instance" "talos_controlplane_3" {
  label      = "controlplane-3"
  region     = "ca-central"
  type       = "g6-standard-1"
  depends_on = [null_resource.talosconfig_controlplane, linode_image.talos_latest]
  metadata {
    user_data = base64encode(file("controlplane.yaml"))
  }
  tags       = ["talos-controlplane"]
  private_ip = true

}

resource "linode_instance_disk" "talos_boot_disk_3" {
  label     = linode_instance.talos_controlplane_3.label
  linode_id = linode_instance.talos_controlplane_3.id
  size      = 50000
  image     = linode_image.talos_latest.id
  root_pass = random_password.root_pass.result
}

resource "linode_instance_config" "talos_controlplane_3" {
  linode_id = linode_instance.talos_controlplane_3.id
  label     = linode_instance.talos_controlplane_3.label

  device {
    disk_id     = linode_instance_disk.talos_boot_disk_3.id
    device_name = "sda"
  }

  root_device = "/dev/sda" # Verify this against Linode's documentation
  kernel      = "linode/direct-disk"
  booted      = true
}
