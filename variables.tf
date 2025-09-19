variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "zone_id" {
  default = "Z083667010VF45PN3K92D"
}

variable "tools" {
  default = {
    vault={
        instance_type="t3.micro"
        port= 8200
        iam_policy= {
          Action=[]
          Resource=[]
        }
    }
   github-runner = {
    instance_type= "t3.micro"
    port = 443 #dummy port
    iam_policy={
      Action=["*"]
      Resource=[]
    }
   }
    
  }
  
}

