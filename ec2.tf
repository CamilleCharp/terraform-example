# The EC2 instances and its access points

resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "MainVPC"
    }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = false
}

resource "aws_security_group" "web_server_sg" {
  vpc_id = aws_vpc.main_vpc.id

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

resource "aws_instance" "front-service" {
    ami = "ami-00c71bd4d220aa22a"
    instance_type = var.ec2_front_instance_type
    subnet_id = aws_subnet.public_subnet.id

    iam_instance_profile = aws_iam_instance_profile.bucket_reader_profile.name

    tags = {
        Name = "frontservice"
    }
}

resource "aws_instance" "back-service" {
    ami = "ami-00c71bd4d220aa22a"
    instance_type = var.ec2_back_instance_type
    subnet_id = aws_subnet.private_subnet.id

    iam_instance_profile = aws_iam_instance_profile.bucket_writer_profile.name

        tags = {
        Name = "backservice"
    }
}