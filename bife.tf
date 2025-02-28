# /*
# Task #1: AMI with bootstrap

# Task #2: EC2 launch template
# - instance type t3.micro
# - debian/ubuntu 
# - only boot disk needed

# Task #3: VPC
# - see diagram for cidr

# Task #4 Subnets
# - see diagram for cidr

# Task #5: NAT Gateway
# mãe to
# na globo  !!!!!Task #8: Autoscaling group
# - manual autoscaling policy
# - 2 instances at all times
# - security group

# */
# # ?? quebrei o código
# resource "aws_vpc" "pimba" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_internet_gateway" "pimba_gw" {
#   vpc_id = aws_vpc.pimba.id
# }

# resource "aws_subnet" "public_pimba" {
#   vpc_id     = aws_vpc.pimba.id
#   cidr_block = "10.0.1.0/24"
# }

# resource "aws_subnet" "private_pimba" {
#   vpc_id     = aws_vpc.pimba.id
#   cidr_block = "10.0.2.0/24"
# }

# resource "aws_security_group" "pimba-sg" {
#   name = "pimba-sg"

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_nat_gateway" "pimba_ng" {
#   subnet_id  = aws_subnet.public_pimba.id

#   depends_on = [aws_internet_gateway.pimba_gw]
# }

# resource "aws_launch_template" "launch_pimba" {
#   name = "launch_pimba"

#   image_id = data.aws_ami.ubuntu.id

#   instance_initiated_shutdown_behavior = "terminate"

#   instance_market_options {
#     market_type = "spot"
#   }

#   instance_type = "t3.micro"

#   vpc_security_group_ids = ["${aws_security_group.pimba-sg.id}"]

#   user_data = <<-EOF
#               #!/bin/bash
#               apt-get update
#               apt-get install -y apache2
#               sed -i -e 's/80/8080/' /etc/apache2/ports.conf
#               echo "Hello World" > /var/www/html/index.html
#               systemctl restart apache2
#               EOF
# }

# resource "aws_autoscaling_group" "pimba-asg" {
#   name = "pimba-asg"

#   min_size         = 2
#   max_size         = 2
#   desired_capacity = 2

#   vpc_zone_identifier = [aws_subnet.private_pimba.id]

#   availability_zones = ["${var.region}a"]

#   launch_template {
#     id      = aws_launch_template.launch_pimba.id
#     version = "$Latest"
#   }
# }


