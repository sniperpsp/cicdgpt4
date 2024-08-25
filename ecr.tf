resource "aws_ecr_repository" "node_todo" {
  name                 = "gptfree"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = false
  }
}

output "aws_ecr_repository_url" {
  value = aws_ecr_repository.node_todo.repository_url
}