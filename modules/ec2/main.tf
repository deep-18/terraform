# https://github.com/deep-18/E-commerce-Clothing.git

//Creation of ec2
resource "aws_instance" "website" {
  ami           = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"
  subnet_id     = var.pub_sub_1a_id
#   user_data = filebase64("../ec2/config.sh")
  security_groups = [ var.sg ]
  key_name = var.key_name
  tags = {
    Name = "website-main"
  }
}

# Get the root volume ID of the EC2 instance
data "aws_ebs_volume" "root_volume" {
  filter {
    name   = "attachment.instance-id"
    values = [aws_instance.website.id]
  }

  filter {
    name   = "attachment.device"
    values = ["/dev/xvda"]  # Change if different root device
  }
}

# Create a snapshot of the root volume
resource "aws_ebs_snapshot" "web_snapshot" {
  volume_id = data.aws_ebs_volume.root_volume.id
  tags = {
    Name = "web-snapshot"
  }
}

resource "aws_ami" "web_ami" {
  name               = "website-ami"
  description        = "AMI created from Terraform"
  root_device_name   = "/dev/xvda"

  ebs_block_device {
    device_name = "/dev/xvda"
    snapshot_id = aws_ebs_snapshot.web_snapshot.id
  }

  tags = {
    Name = "web-ami"
  }
}
