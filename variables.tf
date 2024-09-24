variable "project_name" {
    type = string  
}

variable "envinronment" {
    type = string
}

variable "common_tags" {
    default = {}
}

variable "vpc_tags" {
    default = {}
}

variable "cidr_block" {
    default =  "10.0.0.0/24" 
}

variable "dns_hostnames" {
    default = true  
}

variable "igw_tags" {
  default = {}
}

variable "public_subnet_cidrblocks" {
  type = list
  validation {
    condition = length(var.public_subnet_cidrblocks) == 2
    # condition = length(var.public_subnet_cidrblocks) => 2
    error_message = "Please provide valid two public subnet CIDR blocks"
  }
}

variable "public_subnet_tags" {
  default = {}
}

variable "private_subnet_cidrblocks" {
  type = list
  validation {
    condition = length(var.private_subnet_cidrblocks) == 2
    # condition = length(var.private_subnet_cidrblocks) => 2
    error_message = "Please provide valid two private subnet CIDR blocks"
  }
}

variable "private_subnet_tags" {
  default = {}
}

variable "database_subnet_cidrblocks" {
  type = list
  validation {
    condition = length(var.database_subnet_cidrblocks) == 2
    # condition = length(var.database_subnet_cidrblocks) => 2
    error_message = "Please provide valid two database subnet CIDR blocks"
  }
}

variable "database_subnet_tags" {
  default = {}
}