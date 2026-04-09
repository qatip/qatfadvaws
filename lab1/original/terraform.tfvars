aws_region   = "eu-west-2"
project_name = "advtf"
environment  = "dev"
vpc_cidr     = "10.0.0.0/16"
subnet_cidr  = "10.0.1.0/24"



# Phase 1, 2 and 3
security_groups = ["web", "app"]
#security_groups = ["web","app","db"]
#security_groups = ["admin","web","app","db"]
#security_groups = ["admin","app","db"]
#security_groups = []

# Phase 4 
#security_groups = {"web"="Web SG","app"="App SG"}
#security_groups = {"web"="Web SG","db"="Database SG","app"="App SG"}
#security_groups = { db = "Database SG", app = "App SG", web = "Web SG" }
#security_groups = {}
