variable "aws_region" {
  default = "sa-east-1"
}

variable "ami_id" {
  default = "ami-0d8c29083d0808e2d"
}

variable "key_name" {
  default = "exam_sandbox-brasil"
}

variable "ec2_instance_type" {
  default = "t3a.small"
}

variable "allowed_ssh_cidr" {
  default = "200.189.22.171/32"  
}

variable "vpc_id" {
  default = "vpc-28010c4c"
}

variable "public_subnet_id" {
  default = "subnet-452bcd0c"
}