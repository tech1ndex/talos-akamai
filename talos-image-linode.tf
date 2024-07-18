resource "linode_image" "talos_latest" {
  label       = "talos-latest"
  description = "Talos Image uploaded from Terraform!"
  region      = "ca-central"

  file_path = "akamai-amd64.raw.gz"
  file_hash = filemd5("akamai-amd64.raw.gz")
}