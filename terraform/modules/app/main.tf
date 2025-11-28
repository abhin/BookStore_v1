resource "random_id" "suffix" {
  byte_length = 3
}

resource "aws_ecr_repository" "this" {
  name = "${var.name}-app"
  tags = var.tags
}

resource "aws_s3_bucket" "images" {
  bucket = "${var.name}-images-${random_id.suffix.hex}"
  acl    = "private"
  tags   = var.tags
}
