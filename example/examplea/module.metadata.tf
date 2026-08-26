# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
# holden:ignore:HLD_TF_065: for expansion
module "metadata" {
  source  = "../../"
  project = data.google_project.current.project_id

  additional_metadata = {
    "enable-guest-attributes" = "FALSE"
    "vmdnssetting"            = "ZonalPreferred"
  }

  startup_script = <<-EOT
    #!/bin/bash
    set -euo pipefail
    logger -t terraform-gcp-project-metadata "project-wide startup script ran"
  EOT
}
