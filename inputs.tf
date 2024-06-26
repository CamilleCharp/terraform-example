variable "ec2_front_instance_type" {
  description = "The type of EC2 instance"
  type = string
  default = "t2.nano"
}

variable "ec2_back_instance_type" {
  description = "The type of EC2 instance"
  type = string
  default = "t2.micro"
}

variable "deployment_region" {
    description = "The AWS region where the deployment should occur"
    type = string
    default = "eu-west-3"
}

data "aws_caller_identity" "current" {}