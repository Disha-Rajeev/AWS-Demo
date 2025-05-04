provider "aws" {
  region = "us-east-1" # AWS region
}

# Create a key pair for SSH access
resource "aws_key_pair" "key-pair" {
  key_name   = "terraform-demo"                     # Key pair name
  public_key = file("/home/ubuntu/.ssh/id_rsa.pub") # Path to your public key
}

# Create a custom VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr # Use CIDR from variables file
}

# Create a public subnet in the VPC
resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.vpc.id # Attach to VPC
  cidr_block              = "10.0.0.0/24"  # Subnet range
  availability_zone       = "us-east-1a"   # AZ
  map_public_ip_on_launch = true           # Auto-assign public IP
}

# Create an internet gateway for internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id # Attach to VPC
}

# Create a route table with a default route to the internet
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"                 # Route all traffic
    gateway_id = aws_internet_gateway.igw.id # Send via IGW
  }
}

# Associate subnet with the route table
resource "aws_route_table_association" "rta-1" {
  subnet_id      = aws_subnet.subnet-1.id # Subnet to associate
  route_table_id = aws_route_table.RT.id  # Route table to use
}

# Create a security group for HTTP and SSH access
resource "aws_security_group" "SG" {
  name   = "demo"         # Security group name
  vpc_id = aws_vpc.vpc.id # Attach to VPC

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound
  }

  tags = {
    Name = "Demo-SG" # Tag for easier identification
  }
}

# Launch an EC2 instance and deploy Flask app
resource "aws_instance" "server" {
  instance_type          = "t3.micro"                     # Free tier instance
  ami                    = "ami-0c1ac8a41498c1a9c"        # Ubuntu AMI
  key_name               = aws_key_pair.key-pair.key_name # Use created key
  vpc_security_group_ids = [aws_security_group.SG.id]     # Assign SG
  subnet_id              = aws_subnet.subnet-1.id         # Launch in subnet

  connection {
    type        = "ssh"
    user        = "ubuntu"                         # EC2 login user
    private_key = file("/home/ubuntu/.ssh/id_rsa") # Private key path
    host        = self.public_ip                   # Use public IP
  }

  # Copy local app.py to EC2 instance
  provisioner "file" {
    source      = "app.py"              # Local file
    destination = "/home/ubuntu/app.py" # Remote path
  }

  # Install packages and run Flask app
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",     # Test message
      "sudo apt update -y",                        # Update package list
      "sudo apt-get install -y python3-pip",       # Install pip
      "cd /home/ubuntu",                           # Go to app dir
      "sudo pip3 install flask",                   # Install Flask
      "nohup sudo python3 app.py > app.log 2>&1 &" # Run app in background
    ]
  }
}
