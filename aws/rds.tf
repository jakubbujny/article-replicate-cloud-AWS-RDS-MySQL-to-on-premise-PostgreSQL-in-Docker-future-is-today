resource "aws_db_instance" "default" {
  apply_immediately = true
  publicly_accessible = false
  skip_final_snapshot = true
  identifier = "mymysql"
  availability_zone = "${local.region}a"
  allocated_storage    = 5
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "mymysql"
  password             = "mysqlmysql"
  db_subnet_group_name = "${aws_db_subnet_group.rds.name}"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  backup_retention_period = 1
  parameter_group_name = "rds"
}



resource "aws_db_subnet_group" "rds" {
  name = "rds"
  subnet_ids = ["${aws_subnet.rds_a.id}","${aws_subnet.rds_b.id}"]
}