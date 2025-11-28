output "repository_url" {
  description = "Full repository URL (for pushing images)"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.this.name
}
