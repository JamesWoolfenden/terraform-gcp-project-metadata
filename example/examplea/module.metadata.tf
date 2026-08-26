# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
# holden:ignore:HLD_TF_065: for expansion
module "metadata" {
  source  = "../../"
  project = data.google_project.current.project_id
}
