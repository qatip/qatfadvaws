output "deployment_summary" {
  description = "Summary of the deployed environment and module versions"
  value = {
    environment = var.env
    modules = {
      network = module.network.module_version
      compute = module.compute.module_version
    }
  }
}

