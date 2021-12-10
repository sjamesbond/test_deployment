module "sj-hw" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "sj-hw"
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.small"
  key_name               = "devops-sean"
  monitoring             = true
  associate_public_ip_address = true
  subnet_id             = "subnet-0a0982d2be6fc4d62"
  vpc_security_group_ids = [aws_security_group.allow_SJ.id]
  root_block_device      = [{volume_size = "30" }]
  user_data              = "${file("./files/bootstrap_instance.userdata")}"
  tags = {
    Name    = "sj-hw"
 }
}

resource "aws_security_group" "allow_SJ" {
  name        = "SJ"
  description = "SJ"
  vpc_id      = "vpc-03cdb8b1997d3e2e4"

  ingress {
    description = "SSH Access - SJames"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["73.122.201.212/32"]
  }

   ingress {
    description = "Web Access"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    description = "Internal Security Group Access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

