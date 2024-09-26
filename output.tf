output "vpc_id" {
    value =   aws_vpc.main.id
}

# output "az_info" {
#   value = data.aws_availability_zones.available
# }

# output "default_vpc_details" {
#   value = data.aws_vpc.default
# }

# output "dafault_route_table_id" {
#   value = data.aws_route_table.default
# }