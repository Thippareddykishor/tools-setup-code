variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "zone_id" {
  default = "Z098768411FUL8QFJIGI"
}

variable "tools" {
  default = {
    vault={
        instance_type="t3.micro"
        port= 8200
        root_block_device=20
        iam_policy= {
          Action=[]
          Resource=[]
        }
    }
   github-runner = {
    instance_type= "t3.micro"
    port = 443 #dummy port
    root_block_device=30
    iam_policy={
      Action=["*"]
      Resource=[]
    }
   }
    
  }
  
}

