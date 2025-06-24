# ==== ECS Cluster & IAM ====
resource "aws_ecs_cluster" "main" {
  name = "buddywise-cluster"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ==== Frontend Task & Service ====
resource "aws_ecs_task_definition" "frontend" {
  family                   = "buddywise-frontend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "frontend",
    image     = "nginx:latest", ### Update your frontend image here
    essential = true,
    portMappings = [{
      containerPort = 3000,
      hostPort      = 3000,
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "frontend" {
  name            = "buddywise-frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend.arn
    container_name   = "frontend"
    container_port   = 3000
  }

  depends_on = [
    aws_lb_listener_rule.frontend,
    aws_lb_listener_rule.backend
  ]
}

# ==== Backend Task & Service ====
resource "aws_ecs_task_definition" "backend" {
  family                   = "buddywise-backend-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "backend",
    image     = "nginx:latest",  ### Update your backend image here
    essential = true,
    portMappings = [{
      containerPort = 8000,
      hostPort      = 8000,
      protocol      = "tcp"
    }]
  }])
}

resource "aws_ecs_service" "backend" {
  name            = "buddywise-backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.public.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend.arn
    container_name   = "backend"
    container_port   = 8000
  }

  depends_on = [
    aws_lb_listener_rule.frontend,
    aws_lb_listener_rule.backend
  ]
}
