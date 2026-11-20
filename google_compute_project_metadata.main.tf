resource "google_compute_project_metadata" "main" {
  project = var.project

  metadata = merge(
    {
      "enable-oslogin"             = "TRUE"
      "enable-oslogin-2fa"         = "TRUE"
      "block-project-ssh-keys"     = "TRUE"
      "serial-port-logging-enable" = "TRUE"
    },
    var.additional_metadata,
  )

  lifecycle {
    # startup-script is owned by google_compute_project_metadata_item.startup_script;
    # without this the authoritative map deletes it on every apply.
    ignore_changes = [metadata["startup-script"]]
  }
}
