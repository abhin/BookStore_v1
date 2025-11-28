output "ecr_backend_url" {
  description = "ECR backend repository URL"
  value       = module.ecr_backend.repository_url
}

output "ecr_frontend_url" {
  description = "ECR frontend repository URL"
  value       = module.ecr_frontend.repository_url
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = module.rds_postgres.endpoint
}

output "redis_endpoint" {
  description = "ElastiCache Redis endpoint"
  value       = module.redis.configuration_endpoint
}

output "kafka_bootstrap_brokers" {
  description = "Kafka bootstrap brokers"
  value       = module.kafka.bootstrap_brokers
}

output "ecs_backend_cluster" {
  value = module.ecs_backend.ecs_cluster_name
}

output "ecs_frontend_cluster" {
  value = module.ecs_frontend.ecs_cluster_name
}

output "s3_images_bucket" {
  value = module.s3_images.bucket_name
}

output "prometheus_logs" {
  value = module.monitoring.prometheus_log_group
}

output "grafana_logs" {
  value = module.monitoring.grafana_log_group
}

output "alertmanager_logs" {
  value = module.monitoring.alertmanager_log_group
}
