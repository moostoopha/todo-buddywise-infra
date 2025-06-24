# ==== Outputs ====
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the ECS security group"
  value       = aws_security_group.ecs_sg.id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "alb_dns_name" {
  description = "Public DNS of the ALB"
  value       = aws_lb.app.dns_name
}

output "frontend_target_group_arn" {
  description = "ARN of the frontend target group"
  value       = aws_lb_target_group.frontend.arn
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend.arn
}

output "route_table_association_id" {
  description = "Subnet to route table association ID"
  value       = aws_route_table_association.public_subnet.id
}

output "frontend_listener_rule_arn" {
  description = "ARN of the frontend ALB listener rule"
  value       = aws_lb_listener_rule.frontend.arn
}

output "backend_listener_rule_arn" {
  description = "ARN of the backend ALB listener rule"
  value       = aws_lb_listener_rule.backend.arn
}