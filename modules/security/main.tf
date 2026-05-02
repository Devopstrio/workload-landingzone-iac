variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

resource "aws_security_group" "app_sg" {
  name        = "sg-app-${var.environment}"
  description = "Security group for application layer"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_kms_key" "main" {
  description             = "KMS key for environment ${var.environment}"
  deletion_window_in_days = 7
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}

output "kms_key_arn" {
  value = aws_kms_key.main.arn
}
