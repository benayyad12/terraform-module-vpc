variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
}
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
variable "az" {
  description = "The availability zone for the subnet"
  type        = string
}

variable "subnet_public" {
  description = "Whether the subnet is public. If true, creates an Internet Gateway + public route table and assigns public IPs on launch."
  type        = bool
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}