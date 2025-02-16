data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "test_instance" {
  source         = "github.com/je-munobia/terraform-in-depth//modules/ec2_instance"
  instance_count = 2
  subnet_id      = data.aws_subnets.default.ids[0]
  name_prefix    = "dev-ec2"
  tags           = { env = "dev" }
}

output "aws_instance_arn" {
  value = module.test_instance.aws_instance_arn
}