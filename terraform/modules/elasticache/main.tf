resource "aws_elasticache_cluster" "this" {
  cluster_id           = var.name
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = "default.redis${var.engine_version}"
  subnet_group_name    = var.subnet_group_name != "" ? var.subnet_group_name : null
  security_group_ids   = length(var.security_group_ids) > 0 ? var.security_group_ids : null
  tags                 = var.tags

  lifecycle {
    create_before_destroy = true
  }
}
