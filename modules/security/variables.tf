variable "resource_group_name" {}
variable "location" {}
variable "keyvault_name" {}

variable "secrets" {
  type = map(string)
  sensitive = true
}
