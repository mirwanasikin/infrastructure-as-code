variable "region" {
  description = "AWS Region"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "ami_id" {
  description = "Amazon Linux"
  type        = string
}

variable "key_name" {
  description = "Key name for SSH"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for Public Subnet"
  type        = string
}
