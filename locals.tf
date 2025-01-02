locals {
  # resources_name = "${var.project_name}-${var.envinronment}"
  resources_name = lower(replace("${var.project_name}-${var.envinronment}", "[^a-z0-9_-]", ""))
  az_names = slice(data.aws_availability_zones.available.names, 0,2)
#   subnet_name = "${local.resources_name}-private-${local.az_names[count.index]}"
}