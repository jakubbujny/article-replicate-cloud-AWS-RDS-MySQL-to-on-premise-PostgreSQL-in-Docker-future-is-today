resource "aws_db_instance" "default" {
  apply_immediately = true
  publicly_accessible = false
  skip_final_snapshot = true
  identifier = "mymysql"
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "mymysql"
  password             = "mysqlmysql"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.rds.name}"
}

resource "aws_db_subnet_group" "rds" {
  name = "rds"
  subnet_ids = ["${aws_subnet.rds.id}"]
}