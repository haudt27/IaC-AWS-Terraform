output "private_ip" {
  description = "private ip address"
  value       = aws_instance.mongodb-instance.private_ip
}