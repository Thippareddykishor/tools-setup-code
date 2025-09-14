resource "aws_iam_role" "main" {
  name= "${var.name}-role"

  assume_role_policy = jsonencode({
    version = "2012-10-17"
    Statement = [
        {
            Action ="sts:AssumeRole"
            Effect = "Allow"
            sid= ""
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        },
    ]
  })
}