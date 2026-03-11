output "instance_public_ip" {
  value = aws_instance.ec2.public_ip 
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/test_1.pem ec2-user@${aws_instance.ec2.public_ip}"
}
