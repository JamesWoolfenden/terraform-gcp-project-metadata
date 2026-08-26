output "metadata" {
  value       = google_compute_project_metadata.main.metadata
  description = "Effective project-wide Compute Engine metadata"
}

output "startup_script_id" {
  value       = try(google_compute_project_metadata_item.startup_script[0].id, null)
  description = "ID of the project-wide startup-script metadata item, null when no startup script is set"
}
