variable "region" {
  type    = string
  default = "us-west-2"
}

variable "environment" {
  type    = string
  default = "staging"
}

variable "cluster_name" {
  type    = string
  default = "platform-staging"
}

variable "kubernetes_version" {
  type    = string
  default = "1.30"
}

variable "admin_principal_arns" {
  description = "IAM roles (for example an SSO admin role) that get cluster-admin."
  type        = list(string)
  default     = []
}
