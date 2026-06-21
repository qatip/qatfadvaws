module "network" {
 source = "./modules/network"
 prefix = local.prefix
 base_tags = local.base_tags
 region = var.region
 vpc_cidr = var.vpc_cidr
 subnet_cidrs = var.subnet_cidrs
 allow_groups = var.allow_groups
 security_group_rules = var.security_group_rules
}

module "compute" {
 source = "./modules/compute"
 instances = var.instances
 subnet_id = module.network.app_subnet_id
 security_group_id = module.network.security_group_id
 prefix = local.prefix
 base_tags = local.base_tags
}