# terraform-gcp-project-metadata

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-project-metadata/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-project-metadata)
[![Latest Release](https://img.shields.io/github/release/terraform-gcp-project-metadata.svg)](https://github.com/JamesWoolfenden/terraform-gcp-project-metadata/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-project-metadata.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-project-metadata/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Terraform module for project-wide Compute Engine metadata, defaulting to OS
Login with 2FA, blocked project SSH keys and serial port logging. Exercises
holden's google_compute_project_metadata and
google_compute_project_metadata_item policies.

## Usage

Add **module.metadata.tf** to your code:-

```terraform
module "metadata" {
  source  = "jameswoolfenden/project-metadata/gcp"
  version = "0.0.1"
  project = data.google_project.current.project_id
}
```

google_compute_project_metadata is **authoritative for the whole project**: it
replaces every project-wide metadata entry, so anything set outside Terraform
is deleted on the first apply. There can only be one of these per project.
Where you only want to own a single entry, use
google_compute_project_metadata_item instead — the startup script here is done
that way.

var.additional_metadata refuses to disable OS Login, to set project-wide
ssh-keys (or the legacy sshKeys) and to enable the interactive serial console
(serial-port-enable), which are the usual ways this resource is used to undo
hardening. It also refuses startup-script; use var.startup_script, which is
managed as a separate metadata item that the authoritative resource ignores.
The other defaults (enable-oslogin-2fa, block-project-ssh-keys and
serial-port-logging-enable) are overridable defaults, not enforced: setting
them to FALSE in var.additional_metadata turns them off.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_compute_project_metadata.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata) | resource |
| [google_compute_project_metadata_item.startup_script](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_metadata"></a> [additional\_metadata](#input\_additional\_metadata) | Extra project-wide metadata entries merged over the hardening defaults | `map(string)` | `{}` | no |
| <a name="input_project"></a> [project](#input\_project) | Project whose Compute Engine metadata is managed | `string` | n/a | yes |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | Project-wide startup script applied to every instance that does not override it. Empty to set none | `string` | `""` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | Effective project-wide Compute Engine metadata |
| <a name="output_startup_script_id"></a> [startup\_script\_id](#output\_startup\_script\_id) | ID of the project-wide startup-script metadata item, null when no startup script is set |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-gcp-project-metadata/issues).

## Copyrights

Copyright © 2019-2026 [Jim Woolfenden](https://github.com/JamesWoolfenden)

## License

See [LICENSE](LICENSE) for full details.
<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "compute.globalOperations.get",
    "compute.projects.get",
    "compute.projects.setCommonInstanceMetadata"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "compute.globalOperations.get",
    "compute.projects.get"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->
