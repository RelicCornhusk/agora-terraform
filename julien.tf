resource "aws_launch_template" "terraform-demo" {
  name_prefix   = "terraform-demo"
  image_id      = "ami-04b4f1a9cf54c11d0"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.sec_group_1.id]

#   user_data = filebase64("${path.module}/instance_config.sh")
  user_data = base64encode(templatefile("${path.module}/instance_config.sh.tpl", {
    token = var.github_secret
  }))
#   user_data = <<EOT
# mkdir actions-runner && cd actions-runner
# curl -o actions-runner-linux-x64-2.322.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.322.0/actions-runner-linux-x64-2.322.0.tar.gz
# echo "b13b784808359f31bc79b08a191f5f83757852957dd8fe3dbfcc38202ccf5768  actions-runner-linux-x64-2.322.0.tar.gz" | shasum -a 256 -c
# tar xzf ./actions-runner-linux-x64-2.322.0.tar.gz
# ./config.sh --url https://github.com/RelicCornhusk/agora-terraform --token ${var.github_secret}
# ./run.sh
# EOT
}

resource "aws_autoscaling_group" "demo-asg" {
  availability_zones = local.availability_zone
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.terraform-demo.id
    version = "$Latest"
  }
}

