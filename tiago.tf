resource "aws_security_group" "sec_group_1" {
  name        = "ec2-security-group"
  description = "Security group for ec2 instances"
  vpc_id      = aws_vpc.main.id  # Replace with your VPC ID

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ASG-SG"
    made_by = "tiagzor"
  }
}