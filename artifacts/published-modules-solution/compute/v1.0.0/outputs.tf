output "module_version" {
  description = "Version of the compute module"
  value       = terraform_data.module_version.output.version
}
