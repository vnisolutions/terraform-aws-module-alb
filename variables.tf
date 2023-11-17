variable "region" {
  description = "The region for create resource aws"
  type        = string
}

variable "env" {
  description = "Enviroment for application such as prod, stg, dev"
  type        = string
}

variable "project_name" {
  description = "Project name application"
  type        = string
}

variable "sg_ingress" {
  description = "Security group will be allow access inbound ALB"
  type        = list(string)
  default     = null
}

variable "cidr_ingress" {
  description = "Rangle list ip allow access inbound ALB"
  type        = list(string)
  default     = null
}

variable "alb_type" {
  description = "Type alb will be create. Internal is true and internet is false"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "The subnets will be asign to create ALB"
  type        = list(string)
}

variable "is_https" {
  description = "Enable https"
  type        = bool
  default     = true
}

variable "certificate_arn" {
  description = "Path arn certificate https"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC will be used"
  type        = string
}
