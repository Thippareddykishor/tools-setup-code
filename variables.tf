variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "zone_id" {
  default = "Z05764853PUNNX41R0FK9"
}

variable "tools" {
  default = {
    vault={
        instance_type="t3.micro"
        ports= {
          vault =8200
        }
        root_block_device=20
        iam_policy= {
          Action=[]
          Resource=[]
        }
    }
   github-runner = {
    instance_type= "t3.micro"
    ports = {} #dummy port
    root_block_device=30
    iam_policy={
      Action=["*"]
      Resource=[]
    }
   }
    

    elk-stack = {
      instance_type = "i3.large"
      ports = {
        elasticsearch =9200
        kibana= 80
      }
      root_block_device = 30
      iam_policy = {
        Action=[]
          Resource=[]
      }
    }
  }
  
}

