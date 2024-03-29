resource "aws_lambda_function" "asg" {
  function_name = "${var.name}-asg"
  s3_bucket     = var.lambda_s3_bucket
  s3_key        = var.lambda_s3_bucket_key
  role          = aws_iam_role.lambda_asg.arn
  handler       = "main.handle"
  description   = "triggered by ASGs"
  memory_size   = 128
  runtime       = "python3.6"
  timeout       = 30

  tags = {
    Name = "${var.name}-asg"
  }

  environment {
    variables = {
      FILTER_TAG_KEY   = "Stack"
      FILTER_TAG_VALUE = var.name
    }
  }
}

resource "aws_iam_role_policy" "policy_lambda_asg" {
  name = "${var.name}-lambda"
  role = aws_iam_role.lambda_asg.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:*",
        "ec2:*",
        "autoscaling:CompleteLifecycleAction",
        "autoscaling:DescribeAutoScalingGroups"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda_asg" {
  name = "${var.name}-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "asg" {
  statement_id  = "${var.name}-AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.asg.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_asg.arn
}

resource "aws_cloudwatch_event_rule" "lambda_asg" {
  name          = "${var.name}-lambda-asg"
  description   = "Trigger a lambda function when an instance launches in the ASGs"
  event_pattern = data.template_file.aws_cloudwatch_event_rule_pattern.rendered
}

data "template_file" "aws_cloudwatch_event_rule_pattern" {
  template = "${file("${path.module}/templates/cloudwatch-event-rule.json.tpl")}"
  vars = {
    asg-arns = "${jsonencode(aws_autoscaling_group.default.*.name)}"
  }
}

resource "aws_cloudwatch_event_target" "lambda_asg" {
  rule = aws_cloudwatch_event_rule.lambda_asg.name
  arn  = aws_lambda_function.asg.arn
}
