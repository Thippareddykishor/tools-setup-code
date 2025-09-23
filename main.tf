module "tool_infra" {
  source         = "./module-infra"
  for_each = var.tools

  ami_id         = var.ami_id        # Replace with your AMI ID
  name           = each.key    # Replace with your instance name
  zone_id        = var.zone_id       # Replace with your zone ID
  instance_type  = each.value["instance_type"]             # Replace with your instance type
  port           = each.value["port"] 
  iam_policy = each.value["iam_policy"]                    # Replace with your required port
  root_block_device = each.value["root_block_device"]
}