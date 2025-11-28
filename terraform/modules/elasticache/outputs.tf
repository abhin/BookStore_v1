output "configuration_endpoint" {
  value = aws_elasticache_cluster.this.cache_nodes[0].address
  description = "Primary endpoint for single-node cluster"
}

output "port" {
  value = aws_elasticache_cluster.this.port
}
