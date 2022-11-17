resource "aws_ecr_repository" "ecr" {
  name                 = "awesome-ecr"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    Name = "awesome-ecr"
  }
}