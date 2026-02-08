output "aws_lb_controller_role_arn" {
  value = module.aws_lb_controller_irsa.iam_role_arn
}