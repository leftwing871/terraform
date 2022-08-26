general_tags = "terraform101"


ec2-sm-tw-ldbgw-list = [
	"ec2-sm-tw-ldbgw-005",
	"ec2-sm-tw-ldbgw-006",
	"ec2-sm-tw-ldbgw-007",
  ]

rds-logdb-list = {
  "1st" = {
    name = "rds-sm-tw-logdb-001",
    rds_master_username = "master",
    rds_master_password = "Master123!@#",
    instance_class     = "db.r5.xlarge",
    switch = 1,
  },
  "2nd" = {
    name = "rds-sm-tw-logdb-002",
    rds_master_username = "master",
    rds_master_password = "Master123!@#",
    instance_class     = "db.r5.xlarge",
    switch = 1,
  },
  "3rd" = {
    name = "rds-sm-tw-logdb-003",
    rds_master_username = "master",
    rds_master_password = "Master123!@#",
    instance_class     = "db.r5.xlarge",
    switch = 1,
  },
  "4th" = {
    name = "rds-sm-tw-logdb-004",
    rds_master_username = "master",
    rds_master_password = "Master123!@#",
    instance_class     = "db.r5.2xlarge",
    switch = 0,
  },
  "5th" = {
    name = "rds-sm-tw-logdb-005",
    rds_master_username = "master",
    rds_master_password = "Master123!@#",
    instance_class     = "db.r5.2xlarge",
    switch = 1,
  },  
}
