
variable "cidr" {}

variable "subnet_cidrs" {
  type = list(string)
}
variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for subnets"
}

variable "name" {}