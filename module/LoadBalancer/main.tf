resource "aws_lb" "alb" {
  load_balancer_type = "application"
  internal = false
  security_groups = [var.alb_sg]
  subnets = values(var.public_subnet_ids)

}


resource "aws_lb_target_group" "alb_tg" {
  vpc_id = var.vpc_id
  target_type = "instance"
  protocol = "HTTP"
  health_check {
    path = "/"
  }
  port = 80
  protocol_version = "HTTP1"
  tags = {
    Name = ""
  }
}



resource "aws_lb_target_group_attachment" "alb_tg_attach" {
  for_each         = { for idx, id in var.private_instance_ids : idx => id }
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = each.value
  port             = 80
}




resource "aws_lb_listener" "alb_listner" {
  protocol = "HTTP"
  port = 80
  load_balancer_arn = aws_lb.alb.arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }

}

