resource "aws_ecs_task_definition" "task_todo" {
  family                   = "gptfree"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/role-acesso-ssm"
  task_role_arn            = "arn:aws:iam::${var.aws_account_id}:role/role-acesso-ssm"

  container_definitions = jsonencode([
    {
      name      = "gptfree"
      image     = "${var.ecr_uri}/gptfree:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DEPLOYMENT_TIME"
          value = timestamp()  # Adiciona um timestamp para forçar a criação de uma nova versão da tarefa
        }
      ]
    }
  ])
}