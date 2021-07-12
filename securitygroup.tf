resource "aws_security_group" "TerraformEc2_security" {
  vpc_id      = "${aws_vpc.My-vpc.id}"
  name        = "TerraformEc2_security"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraformEc2_security"
    instance_name = "Terraform_EC2"
  }
}


resource "aws_security_group" "rds_sg" {
    vpc_id      = aws_vpc.My-vpc.id

    ingress {
        protocol        = "tcp"
        from_port       = 3306
        to_port         = 3306
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = [aws_security_group.TerraformEc2_security.id]
    }

    egress {
        from_port       = 0
        to_port         = 65535
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}
