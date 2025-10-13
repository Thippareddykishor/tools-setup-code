resource "aws_instance" "tool" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.tool_sg.id]
  iam_instance_profile = aws_iam_instance_profile.main.name  

  root_block_device {
    volume_size = var.root_block_device 
  }

  tags = {
    Name= var.name
    monitor = "true"
  }

  # instance_market_options {
  #   market_type = "spot"
  #   spot_options {
  #     instance_interruption_behavior = "stop"
  #     spot_instance_type = "persistent"
  #   }
  # }
}

resource "aws_security_group" "tool_sg" {
  name = "${var.name}-sg"
  description = "${var.name} Security group"

  tags = {
    Name = "${var.name}-sg"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.tool_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = "22"
  to_port = "22"
  ip_protocol = "tcp"
  description = "ssh"
}

resource "aws_vpc_security_group_ingress_rule" "app_port" {
  security_group_id = aws_security_group.tool_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = var.port
  to_port = var.port
  ip_protocol = "tcp"
  description = var.name
}

resource "aws_vpc_security_group_ingress_rule" "allow_all" {
  security_group_id = aws_security_group.tool_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "egress_allow_all" {
  security_group_id = aws_security_group.tool_sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_route53_record" "private" {
  ttl = 10
  name = "${var.name}-internal"
  records = [aws_instance.tool.private_ip]
  zone_id = var.zone_id
  type = "A"
}

resource "aws_route53_record" "public" {
  ttl = 10
  name = var.name
  records = [aws_instance.tool.public_ip]
  zone_id = var.zone_id
  type = "A"
}

