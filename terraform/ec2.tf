resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type

  subnet_id     = aws_subnet.public.id

  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.sg.id 
  ]

  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
