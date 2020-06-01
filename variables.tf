# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables.
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables must be set when using this module.
# ------------------------------------------------------------------------------

variable "policy" {
  type        = string
  description = "(Required, conflicts with policy_statements) The policy document. This is a JSON formatted string. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide "
  default     = null
}

variable "policy_statements" {
  type        = set(any)
  description = "(Required, conflicts with policy) A list of policy statements to build the policy document from."
  default     = []
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These variables have defaults, but may be overridden.
# ------------------------------------------------------------------------------

variable "description" {
  type        = string
  description = "(Optional, Forces new resource) Description of the IAM policy."
  default     = null
}

variable "name" {
  type        = string
  description = "(Optional, Forces new resource) The name of the policy. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = null
}

variable "path" {
  type        = string
  description = "(Optional, default /) Path in which to create the policy. See IAM Identifiers for more information."
  default     = "/"
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# See https://medium.com/mineiros/the-ultimate-guide-on-how-to-write-terraform-modules-part-1-81f86d31f024
# ------------------------------------------------------------------------------
variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is true."
  default     = true
}

variable "module_depends_on" {
  type        = list(any)
  description = "(Optional) A list of external resources the module depends_on. Default is []."
  default     = []
}
