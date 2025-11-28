# creates a simple single-AZ RDS instance. For production, prefer multi-AZ and more secure setup.
resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
  lifecycle {
    prevent_destroy = false
  }
  count = length(var.subnet_ids) > 0 ? 1 : 0
}

resource "aws_db_instance" "this" {
  identifier = var.name
  engine     = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  name      = var.name
  username  = var.username
  password  = var.password
  skip_final_snapshot = true
  publicly_accessible  = false
  vpc_security_group_ids = var.vpc_security_group_ids

  depends_on = [aws_db_subnet_group.this]

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}
