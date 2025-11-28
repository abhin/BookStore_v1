output "cluster_arn" {
  value = aws_msk_cluster.this.arn
}

output "bootstrap_brokers" {
  value = aws_msk_cluster.this.bootstrap_brokers
}
