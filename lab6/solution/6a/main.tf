/*
module "network" {
 source = "../../artifacts/local-modules/network"
}

module "compute" {
 source = "../../artifacts/local-modules/compute"
}
*/

#/*
module "network" {
  source               = "../../artifacts/published-modules/network/v1.0.0"
  prefix               = local.prefix
  base_tags            = local.base_tags
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  subnet_cidrs         = var.subnet_cidrs
  allow_groups         = var.allow_groups
  security_group_rules = var.security_group_rules
}


module "compute" {
  source            = "../../artifacts/published-modules/compute/v1.0.0"
  instances         = var.instances
  subnet_id         = module.network.app_subnet_id
  security_group_id = module.network.security_group_id
  prefix            = local.prefix
  base_tags         = local.base_tags
}
#*/
