aws_region   = "eu-west-2"
project_name = "advtf"
environment  = "dev"
vpc_cidr     = "10.0.0.0/16"
subnet_cidr  = "10.0.1.0/24"


# Phase 1
security_groups = ["web", "app"]

# Phase 2
#security_groups = ["web","app","db"]

# Phase 3
#security_groups = ["admin","web","app","db"]


/*
# Phase 4
 security_groups = [
  # { name        = "admin",description = "Administration security group"},
   { name        = "web", description = "Web tier security group"},
   { name        = "app", description = "Application tier security group"},
   { name        = "db",description = "Database tier security group"}
 ]
*/


/*
# Phase 5 initial example
security_groups = {
  web = { description = "Web tier security group" }
  app = { description = "Application tier security group" }
  db  = { description = "Database tier security group" }
}
*/


/*
# Phase 6 reorder example (should produce no diff)
security_groups = {
  db  = { description = "Database tier security group" }
  web = { description = "Web tier security group" }
  app = { description = "Application tier security group" }
}
*/


/*
# Phase 6 add example (should produce no churn)
security_groups = {
  db    = { description = "Database tier security group" }
  web   = { description = "Web tier security group" }
  app   = { description = "Application tier security group" }
  admin = { description = "Administration security group" }
}
*/