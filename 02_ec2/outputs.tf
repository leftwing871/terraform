output "vpc_id" {
  value = aws_instance.this.private_ip
}

output "ec2_dns" {
  value = aws_instance.this.private_dns
}

output "lb_dns" {
  value = aws_lb.alb.dns_name
}