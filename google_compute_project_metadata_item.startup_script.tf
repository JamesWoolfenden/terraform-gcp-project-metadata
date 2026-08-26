resource "google_compute_project_metadata_item" "startup_script" {
  count = var.startup_script == "" ? 0 : 1

  project = var.project
  key     = "startup-script"
  value   = var.startup_script
}
