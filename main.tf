provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "ccs-web1" {
  ami           = "ami-0e2c8caa4b6378d8c" # Ubuntu 20.04 LTS (us-east-1)
  instance_type = "t2.micro"
  key_name      = "ccs" # Ganti dengan nama keypair Anda

  tags = {
    Name = "ccs-web1"
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_instance" "ccs-web2" {
  ami           = "ami-0e2c8caa4b6378d8c" # Ubuntu 20.04 LTS (us-east-1)
  instance_type = "t2.micro"
  key_name      = "ccs" # Ganti dengan nama keypair Anda

  tags = {
    Name = "ccs-web2"
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_instance" "loadbalancer" {
  ami           = "ami-0e2c8caa4b6378d8c" # Ubuntu 20.04 LTS (us-east-1)
  instance_type = "t2.micro"
  key_name      = "ccs" # Ganti dengan nama keypair Anda

  tags = {
    Name = "loadbalancer"
  }

  vpc_security_group_ids = [aws_security_group.lb_sg.id]
}

resource "aws_security_group" "web_sg" {
  name_prefix = "ccs-web-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "lb_sg" {
  name_prefix = "ccs-lb-sg"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web1_ip" {
  value = aws_instance.ccs-web1.public_ip
}

output "web2_ip" {
  value = aws_instance.ccs-web2.public_ip
}

output "loadbalancer_ip" {
  value = aws_instance.loadbalancer.public_ip
}