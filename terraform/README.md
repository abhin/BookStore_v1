# Terraform Infrastructure-as-Code for BookStore

This directory contains Terraform modules and root configurations to deploy the BookStore application and its microservices to AWS.

## Architecture Overview

The BookStore infrastructure is modularized for reusability and clarity:

- **modules/** - Reusable Terraform modules for individual services and resources
- **environments/** - Environment-specific root modules (dev, staging, prod)

## Modules

### 1. ECR (Elastic Container Registry)
Creates Docker image repositories for storing backend and frontend images.

**Location:** `modules/ecr/`

**Variables:**
- `name` - Repository name
- `tags` - Resource tags

**Outputs:**
- `repository_url` - Full repository URL for pushing images
- `repository_name` - Repository name

### 2. RDS (Relational Database Service)
Creates a managed PostgreSQL database instance.

**Location:** `modules/rds/`

**Variables:**
- `name` - Database instance identifier
- `username` - Master username (default: postgres)
- `password` - Master password (required, sensitive)
- `instance_class` - DB instance type (default: db.t3.micro)
- `allocated_storage` - Storage in GB (default: 20)
- `subnet_ids` - VPC subnet IDs (optional)
- `vpc_security_group_ids` - Security groups (optional)

**Outputs:**
- `address` - RDS endpoint address
- `endpoint` - Full endpoint (host:port)
- `port` - Database port

### 3. ElastiCache (Redis)
Creates a Redis cluster for session/cache storage.

**Location:** `modules/elasticache/`

**Variables:**
- `name` - Cluster name
- `node_type` - Node instance type (default: cache.t3.micro)
- `engine_version` - Redis version (default: 7)
- `num_cache_nodes` - Number of nodes (default: 1)
- `security_group_ids` - Security groups (optional)

**Outputs:**
- `configuration_endpoint` - Redis endpoint address
- `port` - Redis port (default: 6379)

### 4. MSK (Managed Streaming for Kafka)
Creates a managed Kafka cluster for event streaming.

**Location:** `modules/msk/`

**Variables:**
- `name` - Cluster name
- `kafka_version` - Kafka version (default: 2.8.1)
- `broker_instance_type` - Instance type (default: kafka.m5.large)
- `number_of_broker_nodes` - Number of brokers (default: 1)
- `subnet_ids` - VPC subnet IDs
- `security_groups` - Security groups

**Outputs:**
- `cluster_arn` - MSK cluster ARN
- `bootstrap_brokers` - Bootstrap brokers string

### 5. ECS (Elastic Container Service)
Creates an ECS cluster, task definition, and service to run containerized applications (backend/frontend).

**Location:** `modules/ecs/`

**Variables:**
- `name` - Service name
- `container_image` - Docker image URI
- `container_port` - Container port (default: 80)
- `desired_count` - Number of tasks (default: 1)
- `cpu` - Task CPU units (default: 256)
- `memory` - Task memory MB (default: 512)
- `subnet_ids` - VPC subnet IDs (optional)
- `security_group_ids` - Security groups (optional)

**Outputs:**
- `ecs_cluster_name` - ECS cluster name
- `ecs_service_name` - ECS service name

### 6. S3 (Simple Storage Service)
Creates an S3 bucket with versioning and encryption for storing book images.

**Location:** `modules/s3/`

**Variables:**
- `name` - Bucket name prefix
- `tags` - Resource tags

**Outputs:**
- `bucket_name` - S3 bucket name
- `bucket_arn` - S3 bucket ARN

### 7. Monitoring
Creates CloudWatch log groups and S3 state bucket for Prometheus, Grafana, and AlertManager.

**Location:** `modules/monitoring/`

**Variables:**
- `name` - Name prefix
- `tags` - Resource tags

**Outputs:**
- `prometheus_log_group` - CloudWatch log group name for Prometheus
- `grafana_log_group` - CloudWatch log group name for Grafana
- `alertmanager_log_group` - CloudWatch log group name for AlertManager
- `alertmanager_bucket` - S3 bucket for AlertManager state

## Environments

### Development (dev)

**Location:** `environments/dev/`

Minimal setup for local development. Single-instance resources, 20GB RDS storage, 1 Kafka broker.

**Quick Start:**

```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values, especially db_password
terraform init
terraform plan
terraform apply
```

### Staging

**Location:** `environments/staging/`

Higher availability setup. 2 ECS tasks per service, larger RDS (50GB), 2 Kafka brokers, improved caching.

**Quick Start:**

```bash
cd terraform/environments/staging
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars
terraform init
terraform plan
terraform apply
```

## Remote State (Recommended)

Instead of storing state locally, use S3 + DynamoDB for team collaboration and safety.

### Setup Remote State Backend

1. Create S3 bucket for state:

```bash
aws s3api create-bucket \
  --bucket bookstore-tf-state-$(date +%s) \
  --region us-east-1
```

2. Create DynamoDB table for locking:

```bash
aws dynamodb create-table \
  --table-name bookstore-tf-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

3. Initialize with backend config:

```bash
cd terraform/environments/dev
terraform init \
  -backend-config="bucket=bookstore-tf-state-XXXXXXX" \
  -backend-config="key=dev/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=bookstore-tf-locks"
```

## Workflow

### Plan Infrastructure Changes

```bash
cd terraform/environments/dev
terraform plan -var-file=terraform.tfvars
```

### Apply Changes

```bash
terraform apply -var-file=terraform.tfvars
```

### Destroy Resources

```bash
terraform destroy -var-file=terraform.tfvars
```

## Important Notes

1. **Sensitive Values:** Never commit `terraform.tfvars` to version control. Use `.gitignore` to exclude it:
   ```
   terraform/*.tfvars
   terraform/**/*.tfvars
   terraform/**/.terraform/
   terraform/**/.terraform.lock.hcl
   ```

2. **Database Password:** Change the default password in `terraform.tfvars` before applying.

3. **Image URIs:** ECR repositories are created but images must be pushed separately:
   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ECR_URI>
   docker build -t <ECR_URI>:latest .
   docker push <ECR_URI>:latest
   ```

4. **VPC & Subnets:** The example modules assume default VPC. For production, customize with explicit VPC and subnet configurations.

5. **Security Groups:** Add security group rules to allow communication between services (RDS, Redis, Kafka, ECS).

## Scaling and Customization

- **Auto-scaling:** Add `aws_appautoscaling_target` and `aws_appautoscaling_policy` for ECS services.
- **Load Balancing:** Integrate ALB with ECS services for HTTP/HTTPS routing.
- **Multi-AZ:** Update RDS and MSK configurations for HA.
- **Monitoring:** Extend monitoring module to include CloudWatch alarms.

## Troubleshooting

**Error: "could not read password from stdin"**
- Ensure AWS credentials are properly configured: `aws configure`

**Error: "Error creating ECR repository"**
- Ensure the repository name is unique within the AWS account and region.

**Error: "Invalid RDS instance class"**
- Verify the instance class is available in your region: `aws rds describe-orderable-db-instance-options`

## Further Reading

- [AWS Terraform Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Best Practices](https://www.terraform.io/docs/language/index.html)

