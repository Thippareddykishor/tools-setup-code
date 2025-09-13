variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "zone_id" {
  default = "Z10310253KPZLFJOC7YEK"
}

variable "tools" {
  default = {
    vault={
        instance_type="t3.micro"
        port= 8200
    }
  #  github-runner = {
  #   instance_type= "t3.micro"
  #   port = 443 #dummy port
  #  }
    
  }
  
}


module "tool_infra" {
  source         = "./module-infra"
  for_each = var.tools

  ami_id         = var.ami_id        # Replace with your AMI ID
  name           = each.key    # Replace with your instance name
  zone_id        = var.zone_id       # Replace with your zone ID
  instance_type  = each.value["instance_type"]             # Replace with your instance type
  port           = each.value["port"]                     # Replace with your required port
}