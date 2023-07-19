resource "aws_elastic_beanstalk_application" "main" {
  name        = var.application_name
  tags = var.tags
}

resource "aws_elastic_beanstalk_environment" "main" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.main.name
  solution_stack_name = var.solution_stack_name
  tier                = var.tier

  tags = var.tags

  dynamic "setting" {
    for_each = var.settings
    content {
      namespace = setting.value["namespace"]
      name = setting.value["name"]
      value = setting.value["value"]
    }
  }
}