locals {
  resources_name = "${var.project_name}-${var.envinronment}"
  az_names = slice(data.aws_availability_zones.available.names, 0,2)
#   subnet_name = "${local.resources_name}-private-${local.az_names[count.index]}"
}