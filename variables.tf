variable "vpc_subnet_ids" {
  description = "List of VPC Subnet ID's to map ASG to. (SHOULD BE PUBLIC!)"
  type        = "list"
}

variable "internal_cidr" {
  description = "CIDR of internal IP space to allow ALB to communicate with"
  default     = "10.0.0.0/8"
}

variable "vpc_id" {
  description = "VPC ID to place ALB"
}

variable "name" {
  description = "name of ALB"
}

variable "dns_name" {
  description = "DNS name for ALB"
}

variable "dns_zone_id" {
  description = "Route53 Zone ID for DNS entry"
}
