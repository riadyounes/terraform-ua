terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
  profile = "user-terraform"
  region  = var.aws_region
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = var.rds_database
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = false
}

resource "aws_instance" "my_app" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  connection {
    type    = "ssh"
    host    = self.public_ip
    user    = "ubuntu"
    timeout = "4m"
  }

  tags = {
    name = "Entrega 4 Terraform"
  }

  user_data = <<-EOF
        #!/bin/bash
        set -ex # -e  Exit immediately if a command exits with a non-zero status.
                # -x  Print commands and their arguments as they are executed.
        sudo apt update
        curl -fsSL https://get.docker.com | sh
        sudo usermod -a -G docker ubuntu
        sudo curl -L https://github.com/docker/compose/releases/download/2.6.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        sudo docker pull jonasxpx/projeto4:latest
        sudo docker run -e HOST=${aws_db_instance.default.address} -e PASS=${var.rds_password} -e DB=${var.rds_database} -e PORT=${aws_db_instance.default.port} -e USER=${var.rds_username} jonasxpx/projeto4:1
    EOF

}
