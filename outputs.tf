output "endpoint" {
  value       = aws_elastic_beanstalk_environment.main.cname
  description = "Fully qualified DNS name for the environment"
}