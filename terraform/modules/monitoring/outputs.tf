output "prometheus_log_group" {
  value = aws_cloudwatch_log_group.prometheus.name
}

output "grafana_log_group" {
  value = aws_cloudwatch_log_group.grafana.name
}

output "alertmanager_log_group" {
  value = aws_cloudwatch_log_group.alertmanager.name
}

output "alertmanager_bucket" {
  value = aws_s3_bucket.alertmanager.bucket
}
