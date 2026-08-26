output "metadata" {
  value       = google_compute_project_metadata.main.metadata
  description = "Effective project-wide Compute Engine metadata"
}
