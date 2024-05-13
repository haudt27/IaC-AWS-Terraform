output "public_ip" {
  description = "bastion public ip address"
  value       = aws_instance.bastion.public_ip
}