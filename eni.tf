resource "aws_network_interface" "az0" {
  count           = var.enable_static_ip ? lookup(var.node_count, element(var.aws_zones, 0)) : 0
  subnet_id       = lookup(var.subnets, element(var.aws_zones, 0))
  security_groups = var.sg_ids
  description     = var.name

  tags = {
    Name              = var.name
    Stack             = var.name
    Inventory         = "${var.name}-${element(var.aws_zones, 0)}-${count.index}"
    Availability_Zone = element(var.aws_zones, 0)
  }
}

resource "aws_network_interface" "az1" {
  count           = lookup(var.node_count, element(var.aws_zones, 1))
  subnet_id       = lookup(var.subnets, element(var.aws_zones, 1))
  security_groups = var.sg_ids
  description     = var.name

  tags = {
    Name              = var.name
    Stack             = var.name
    Inventory         = "${var.name}-${element(var.aws_zones, 1)}-${count.index}"
    Availability_Zone = element(var.aws_zones, 1)
  }
}

resource "aws_network_interface" "az2" {
  count           = lookup(var.node_count, element(var.aws_zones, 2))
  subnet_id       = lookup(var.subnets, element(var.aws_zones, 2))
  security_groups = var.sg_ids
  description     = var.name

  tags = {
    Name              = var.name
    Stack             = var.name
    Inventory         = "${var.name}-${element(var.aws_zones, 2)}-${count.index}"
    Availability_Zone = element(var.aws_zones, 2)
  }
}
