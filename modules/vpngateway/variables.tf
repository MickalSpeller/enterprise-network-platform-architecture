variable "dh_group" {
  default = "DHGroup14"
}
variable "ike_encryption" {
  default = "AES256"
}
variable "ike_integrity" {
  default = "SHA256"
}
variable "ipsec_encryption" {
  default = "AES256"
}
variable "ipsec_integrity" {
  default = "SHA256"
}
variable "pfs_group" {
  default = "PFS1"
}
variable "resource_group_name" {

}
variable "location" {

}
variable "gateway_subnet_id" {

}
variable "onprem_gateway_ip" {
  default = "1.1.1.1"
}
variable "address_space" {
  type = list(string)
  default = ["192.168.0.0/16"]
}
variable "shared_key" {
  type = string
  sensitive = true
}