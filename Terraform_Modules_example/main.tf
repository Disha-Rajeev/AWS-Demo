provider "aws" {
  region = "eu-north-1"
}

module "ec2-instance" {
  source              = "./modules/ec2-instance"
  ami_value           = ""         # Mention your AMI_ID here
  instance_type_value = "t3.micro" # Free of use
}
