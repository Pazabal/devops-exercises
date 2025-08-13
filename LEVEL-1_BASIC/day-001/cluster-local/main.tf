provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "ssh"
  vpc_id      = var.vpc_id

  ingress {
    description = "ssh ip local"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true 
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_instance_profile.name

  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }

  tags = {
    Name    = "test"
    Cluster = "exam"
  }
}

 resource "aws_iam_instance_profile" "ec2_s3_instance_profile" {
   name = "ec2_s3_instance_profile"
   role = aws_iam_role.ec2_s3_role.name
 }

 resource "aws_iam_role" "ec2_s3_role" {
   name = "ec2_s3_read_role"
   assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [{
       Effect = "Allow"
       Principal = {
         Service = "ec2.amazonaws.com"
       }
       Action = "sts:AssumeRole"
     }]
   })
 }

 resource "aws_iam_policy" "s3_read_policy" {
   name = "ec2_s3_read_policy"
   policy = jsonencode({
     Version = "2012-10-17"
     Statement = [{
       Effect = "Allow"
       Action = [
         "s3:GetObject",
         "s3:ListBucket"
       ]
       Resource = [
         "arn:aws:s3:::jamcity-exam",
         "arn:aws:s3:::jamcity-exam/*"
       ]
     }]
   })
 }

 resource "aws_iam_role_policy_attachment" "attach_policy" {
   role       = aws_iam_role.ec2_s3_role.name
   policy_arn = aws_iam_policy.s3_read_policy.arn
}