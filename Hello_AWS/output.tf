output "instance_public_ip" {
  value = aws_eip.example_eip.public_ip
}
