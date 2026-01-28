output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}
output "subnet_id" {
  description = "The ID of the Subnet"
  value       = aws_subnet.main_subnet.id
}
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = length(aws_internet_gateway.gw) > 0 ? aws_internet_gateway.gw[0].id : null
}
output "route_table_id" {
  description = "The ID of the Route Table"
  value       = length(aws_route_table.rt) > 0 ? aws_route_table.rt[0].id : null
}
