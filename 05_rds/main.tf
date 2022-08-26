resource "aws_rds_cluster_instance" "rdsinstance" {

  #first character of "identifier" must be a letter
  identifier = format(
    "rds-%s-instance-1",
    var.tags
  )

  cluster_identifier = aws_rds_cluster.rdscluster.id
  db_parameter_group_name = "default.aurora-mysql5.7"
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.rdscluster.engine
  engine_version     = aws_rds_cluster.rdscluster.engine_version
  availability_zone  = var.rdsinstance_availability_zone
  apply_immediately = true
  auto_minor_version_upgrade = false
  # performance_insights_enabled = true

  # monitoring_interval = 30
  # monitoring_role_arn = "arn:aws:iam::444204824859:role/rds-monitoring-role"
    
  # performance_insights_retention_period = 7

}

resource "aws_rds_cluster" "rdscluster" {

  cluster_identifier = var.cluster_identifier
  db_subnet_group_name = var.db_subnet_group_name
  deletion_protection = false
  vpc_security_group_ids = var.vpc_security_group_ids
  # db_cluster_parameter_group_name = "sm-tw-live-ards-clusterparamgroup"
  engine_mode = "provisioned"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.10.2"
  availability_zones = var.rdscluster_availability_zones
  # database_name      = "mydb"
  master_username    = "admin"
  master_password    = "IrKdRaxV0(bL)="
  skip_final_snapshot = true

  # enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  # preferred_backup_window = "18:00-18:30"
  # preferred_maintenance_window = "Tue:19:00-Tue:19:30"


  lifecycle {
    ignore_changes = [
      availability_zones,
      master_username,
      master_password,
    ]
  }
}

