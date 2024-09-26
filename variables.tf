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
    default =  "10.0.0.0/16" 
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

variable "nat_gateway_tags" {
  default = {}
}

variable "public_routes_tags" {
  default = {}
}

variable "private_routes_tags" {
  default = {}
}

variable "database_routes_tags" {
  default = {}
}

variable "NAT_tags" {
  default = {}
}

variable "is_peering_required" {
  type = bool
  default = false
}

variable "vpc_peering_tags" {
  default = {}
}