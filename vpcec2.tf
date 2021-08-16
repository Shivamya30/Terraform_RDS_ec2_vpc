resource "aws_instance" "myec2" {
       ami = "ami-0277b52859bac6f4b"
       instance_type = "t2.micro"
       subnet_id = "${aws_subnet.My-subnet-public-1.id}"
       vpc_security_group_ids = [aws_security_group.TerraformEc2_security.id]
       key_name       =  "demo"
   tags = {

       Name = "Terraform-ec2"
     }
}

resource "aws_vpc" "My-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" 
    enable_dns_hostnames = "true" 
    enable_classiclink = "false"
    instance_tenancy = "default"    
    
    tags = {
        Name = "My-vpc"
    }
}


resource "aws_subnet" "My-subnet-public-1" {
    vpc_id = "${aws_vpc.My-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2a"
    tags = {
        Name = "My-subnet-public-1"
    }

}

resource "aws_subnet" "My-subnet-private-1" {
    vpc_id = "${aws_vpc.My-vpc.id}"
    cidr_block = "10.0.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2b"
    tags = {
        Name = "My-subnet-private-1"
    }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.My-vpc.id}"
  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = "${aws_vpc.My-vpc.id}"
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
tags = {
    Name = "rout-table"
  }
}

resource "aws_route_table_association" "route_table_association" {
    subnet_id      = aws_subnet.My-subnet-public-1.id
    route_table_id = aws_route_table.rtb_public.id
}
