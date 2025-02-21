terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "example_instance1" {
  ami           = "ami-053a45fff0a704a47"
  instance_type = "t2.micro"

  tags = {
    Name = "ArasuExample"
  }
  user_data = <<-EOF
              #cloud-boothook
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "<h1>Hello friend! This is $(hostname -f)</h1>" | sudo tee /var/www/html/index.html > /dev/null
              EOF
}
