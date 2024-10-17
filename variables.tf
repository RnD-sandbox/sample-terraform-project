variable "ibmcloud_api_key" {
  description = "IBM Cloud API key."
  type        = string
  sensitive   = true
}

variable "pi_zone" {
  description = "The PowerVS zone."
  type        = string
}

variable "pi_workspace_name" {
  description = "The Power Virtual Server Workspace name."
  type        = string
}

variable "pi_tags" {
  description = "Tags for the resources."
  type        = list(string)
  default     = null
}
