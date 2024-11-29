
output "private_instance_ids" {
  value = [
    aws_instance.private_1.id,
    aws_instance.private_2.id,
    aws_instance.private_3.id,
    aws_instance.private_4.id
  ]
  description = "List of private EC2 instance IDs"
}


