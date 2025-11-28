# Outputs for staging environment
output "ecr_backend_url" {
  value = module.ecr_backend.repository_url
}

output "ecr_frontend_url" {
  value = module.ecr_frontend.repository_url
}

output "rds_endpoint" {
  value = module.rds_postgres.endpoint
}

output "redis_endpoint" {
  value = module.redis.configuration_endpoint
}

output "kafka_bootstrap_brokers" {
  value = module.kafka.bootstrap_brokers
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
