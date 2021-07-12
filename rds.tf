resource "aws_db_subnet_group" "db_subnet_group" {
        
       subnet_ids  = [aws_subnet.My-subnet-public-1.id , aws_subnet.My-subnet-private-1.id]        
}
resource "aws_db_instance" "default" {
allocated_storage = 10
identifier = "testinstance"
storage_type = "gp2"
engine = "mysql"
engine_version = "5.7"
instance_class = "db.t3.micro"
name = "test"
username = "admin"
password = "Admin54132"
parameter_group_name = "default.mysql5.7"
db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.id
vpc_security_group_ids =  [aws_security_group.TerraformEc2_security.id]
publicly_accessible    = true
skip_final_snapshot  = true
}


resource "aws_db_snapshot" "test" {
  db_instance_identifier = aws_db_instance.default.id
  db_snapshot_identifier = "testsnapshot1234"
}

