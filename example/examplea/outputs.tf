output "metadata" {
  value       = module.metadata.metadata
  description = "Effective project-wide Compute Engine metadata"
}

output "startup_script_id" {
  value       = module.metadata.startup_script_id
  description = "ID of the project-wide startup-script metadata item"
}
