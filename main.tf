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
publicly_accessible    = true
skip_final_snapshot  = true
}


data "aws_db_snapshot" "test" {
  db_instance_identifier = aws_db_instance.default.id
  db_snapshot_identifier = "testsnapshot1234"
}

resource "aws_db_instance" "dev" {
  instance_class      = "db.t2.micro"
  name                = "mydbdev"
  snapshot_identifier = data.aws_db_snapshot.test.id

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}





