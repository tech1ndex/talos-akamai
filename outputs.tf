//Export this cluster's attributes
output "talos_cluster_api_endpoint" {
  value = linode_nodebalancer.talos_cluster.ipv4
}