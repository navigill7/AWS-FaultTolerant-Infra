output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "ec2_sg" {
  value = aws_security_group.ec2_sg.id
}