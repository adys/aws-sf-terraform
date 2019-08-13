### default values - start ###

variable "instance_type" {
  default = "t2.micro"
}

variable "ebs_type" {
  default = "gp2"
}

variable "ebs_size" {
  default = "20"
}

variable "ebs_encrypted" {
  default = "true"
}

variable "ebs_delete_on_termination" {
  default = "true"
}

variable "asg_extra_tags" {
  type = "list"
  default = [
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    }
  ]
}

variable "load_balancers" {
  type    = "list"
  default = []
}

variable "enable_static_ip" {
  default = true
}

### default values - end ###

variable "name" {}

variable "node_count" {
  description = "Number of nodes to launch in AZs."
  type        = "map"
}

variable "subnets" {
  description = "TODO"
  type        = "map"
}

variable "aws_zones" {
  type = "list"
}

variable "key_pair_id" {}
variable "vpc_id" {}
variable "aws_region" {}
variable "iam_instance_profile_id" {}
variable "ami" {}
variable "sg_ids" {
  type = "list"
}

variable "lambda_s3_bucket" {}
variable "lambda_s3_bucket_key" {}
