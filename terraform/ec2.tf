# Key
resource "aws_key_pair" "key" {
  key_name   = "awesomekey"
  public_key = file("awesomekey.pub")
}

# Public에 Bastion Instance 생성
resource "aws_instance" "bastion" {
  ami                    = coalesce(data.aws_ami.amzlinux2.id, var.image_id)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_security.id]
  subnet_id              = aws_subnet.pub_sub_c.id

  tags = {
    Name = "awesome-bastion"
  }
}

# Public에 Jenkins Instance 생성
resource "aws_instance" "jenkins" {
  ami                    = coalesce(data.aws_ami.amzlinux2.id, var.image_id)
  instance_type          = "t2.medium"
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_security.id]
  subnet_id              = aws_subnet.pub_sub_a.id

  tags = {
    Name = "awesome-jenkins"
  }
}

data "aws_ami" "amzlinux2" {
  most_recent = true
  owners      = ["amazon"]
  name_regex  = "^amzn2-"

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}