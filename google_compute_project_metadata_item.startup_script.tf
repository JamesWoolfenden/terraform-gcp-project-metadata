resource "google_compute_project_metadata_item" "startup_script" {
  count = var.startup_script == "" ? 0 : 1

  # Referencing main orders the item after the authoritative map is written.
  project = google_compute_project_metadata.main.project
  key     = "startup-script"
  value   = var.startup_script
}
