variable "user_name" {
  type = "string"
  description = "probably your email"
}
variable "user_password" {
  type = "string"
}
variable "tenant_name" {
  type="string"
  description = "likely the same as your username"
}
variable "tenant_id" {}
variable "auth_url" {}
variable "region" {}

# Cybera assigns one external network - use for the singal floating ip
variable "ext_net" {
  default = "public"
  type = "string"
  description = "the single external network"
}
