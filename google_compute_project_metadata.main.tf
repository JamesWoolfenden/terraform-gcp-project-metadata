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
}
