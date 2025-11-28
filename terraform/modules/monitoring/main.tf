# CloudWatch log group for Prometheus metrics
resource "aws_cloudwatch_log_group" "prometheus" {
  name              = "/aws/monitoring/${var.name}-prometheus"
  retention_in_days = 7
  tags              = var.tags
}

# CloudWatch log group for Grafana
resource "aws_cloudwatch_log_group" "grafana" {
  name              = "/aws/monitoring/${var.name}-grafana"
  retention_in_days = 7
  tags              = var.tags
}

# CloudWatch log group for AlertManager
resource "aws_cloudwatch_log_group" "alertmanager" {
  name              = "/aws/monitoring/${var.name}-alertmanager"
  retention_in_days = 7
  tags              = var.tags
}

# S3 bucket for alertmanager state
resource "aws_s3_bucket" "alertmanager" {
  bucket = "${var.name}-alertmanager-state-${data.aws_caller_identity.current.account_id}"
  tags   = var.tags
}

data "aws_caller_identity" "current" {}
