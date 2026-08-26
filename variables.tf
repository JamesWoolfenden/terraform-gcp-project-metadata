variable "project" {
  type        = string
  description = "Project whose Compute Engine metadata is managed"

  validation {
    condition     = length(trimspace(var.project)) > 0
    error_message = "var.project must be a non-empty string"
  }
}

variable "additional_metadata" {
  type        = map(string)
  description = "Extra project-wide metadata entries merged over the hardening defaults"
  default     = {}

  validation {
    condition     = !anytrue([for k, v in var.additional_metadata : k == "enable-oslogin" && upper(v) != "TRUE"])
    error_message = "var.additional_metadata must not disable OS Login"
  }

  validation {
    condition     = !contains(keys(var.additional_metadata), "ssh-keys")
    error_message = "var.additional_metadata must not set project-wide ssh-keys, use OS Login instead"
  }
}

variable "startup_script" {
  type        = string
  description = "Project-wide startup script applied to every instance that does not override it. Empty to set none"
  default     = ""

  validation {
    condition     = var.startup_script == "" || length(var.startup_script) <= 262144
    error_message = "var.startup_script must be at most 256 KiB, the Compute Engine metadata value limit"
  }
}
