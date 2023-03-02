#####################################################################################################
#KEY PAIR    #Create key pair in EC2 and Store in Amazon S3
#####################################################################################################

# SSH keys for EC2 access
resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "aws_s3_bucket_object" "tls_key_bucket_object" {
  key     = var.key
  bucket  = var.bucket_name
  content = tls_private_key.tls.private_key_pem

}
resource "aws_key_pair" "aws_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.tls.public_key_openssh
}

#####################################################################################################

#####################################################################################################
#SECURITY GROUP 
#####################################################################################################

resource "aws_security_group" "demo-sg" {
  name = var.sg-name
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                 ####(-1 means ALL)####
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#####################################################################################################

#####################################################################################################
#EC2 INSTANCE
#####################################################################################################

resource "aws_instance" "ec2_instance" {
  count                     = var.instance_count
  ami                       = var.ami
  instance_type             = var.instance_type
  security_groups           = [resource.aws_security_group.demo-sg.name]
# subnet_id                 = "subnet-016669035a06fc853"
  key_name                  = resource.aws_key_pair.aws_key_pair.key_name
  tags                      = var.tags

  root_block_device {
    volume_size             = var.root_block_device
  }
}

#####################################################################################################

#####################################################################################################
#EBS VOLUME #Create EBS volume and Attach With instance
#####################################################################################################

resource "aws_ebs_volume" "example" {
  count             = var.instance_count
  availability_zone = resource.aws_instance.ec2_instance[count.index].availability_zone
  type              = var.ebs_volume_type
  size              = var.ebs_volume_size
#  iops              = 300
  tags              = var.tags
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_volume_attachment" "multi_ec2_ebs_att" {
  count        = var.instance_count
  device_name  = var.device_name
  volume_id    = aws_ebs_volume.example[count.index].id
  instance_id  = resource.aws_instance.ec2_instance[count.index].id
  force_detach = true
  stop_instance_before_detaching = true
}

#####################################################################################################


