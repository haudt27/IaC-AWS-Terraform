variable "instance_type" {
  type = string
  description = "choose instance type"
}
variable "ami" {
  type = string
  description = "choose ami"
}
variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
  description = "vpc id"
}

variable "public_subnets" {
  type = list(any)
}

variable "private_subnets" {
  type = list(any)
}

variable "webserver_sg_id" {
  type = string
  description = "webserver security group id"
}

variable "alb_sg_id" {
  type = string
  description = "application load balancer id"
}

variable "mongodb_ip" {
  type = string
  description = "mongodb database id"
}

variable "asg_desired" {
  type    = number
  default = 2
  description = "auto scaling group desired instane number"
}
variable "asg_max_size" {
  type    = number
  default = 2
  description = "auto scaling group max size"
}
variable "asg_min_size" {
  type    = number
  default = 2
  description = "auto scaling group min size"
}
