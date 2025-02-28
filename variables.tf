variable "region" {
    type = string
    default = "us-east-2" 
}

locals {
  availability_zone = "${var.region}a"
}

variable "github_secret" {
    type = string
}