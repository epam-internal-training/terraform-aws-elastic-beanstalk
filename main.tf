data "aws_iam_policy_document" "ec2" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }

  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "ec2" {

  name               = "iam-role-eb-ec2"
  assume_role_policy = join("", data.aws_iam_policy_document.ec2[*].json)
}



resource "aws_iam_instance_profile" "ec2" {

  name = "iam-instance-profile-eb-ec2"
  role = join("", aws_iam_role.ec2[*].name)
}


resource "aws_elastic_beanstalk_application" "main" {
  name = var.application_name
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
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = join("", aws_iam_instance_profile.ec2[*].name)
    resource  = ""
  }

}