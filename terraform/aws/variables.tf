
////////////////////////////////
// AWS Connection

variable "aws_profile" {}

variable "aws_region" {
  default = "eu-west-1"
}

////////////////////////////////
// Tags

variable "tag_customer" {}

variable "tag_project" {}

variable "tag_name" {
  default = "hab-win-ws"
}

variable "tag_dept" {}

variable "tag_contact" {}

variable "tag_application" {
  default = "dotnetcore"
}

variable "tag_ttl" {}

variable "aws_key_pair_file" {}

variable "aws_key_pair_name" {}

variable "aws_centos_image_user" {
  default = "centos"
}

variable "admin_password" {
  default = "Cod3Can!"
}
