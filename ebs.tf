resource "aws_ebs_volume" "az0" {
  count             = lookup(var.node_count, element(var.aws_zones, 0))
  availability_zone = element(var.aws_zones, 0)
  size              = var.ebs_size
  encrypted         = var.ebs_encrypted
  type              = var.ebs_type

  tags = {
    Name              = var.name
    Stack             = var.name
    Inventory         = element(aws_network_interface.az0.*.id, count.index)
    Availability_Zone = element(var.aws_zones, 0)
  }

}

resource "aws_ebs_volume" "az1" {
  count             = lookup(var.node_count, element(var.aws_zones, 1))
  availability_zone = element(var.aws_zones, 1)
  size              = var.ebs_size
  encrypted         = var.ebs_encrypted
  type              = var.ebs_type

  tags = {
    Name              = var.name
    Stack             = var.name
    Inventory         = element(aws_network_interface.az1.*.id, count.index)
    Availability_Zone = element(var.aws_zones, 1)
  }

}

resource "aws_ebs_volume" "az2" {
  count             = lookup(var.node_count, element(var.aws_zones, 2))
  availability_zone = element(var.aws_zones, 2)
  size              = var.ebs_size
  encrypted         = var.ebs_encrypted
  type              = var.ebs_type

  tags = {
    Name              = var.name
    Stack             = var.name
    Inventory         = element(aws_network_interface.az2.*.id, count.index)
    Availability_Zone = element(var.aws_zones, 0)
  }

}
