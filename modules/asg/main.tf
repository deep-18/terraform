resource "aws_launch_template" "launch_template" {
  name          = "${var.project_name}-tpl"
  image_id      = var.ami
  instance_type = t2.micro
  key_name      = var.key_name
  user_data     = filebase64("../modules/ec2/config.sh")


  vpc_security_group_ids = [var.alb_sg]
  tags = {
    Name = "${var.project_name}-tpl"
  }
}

resource "aws_autoscaling_group" "asg_name" {

  name                      = "${var.project_name}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_cap
  health_check_grace_period = 300
  health_check_type         = var.asg_health_check_type #"ELB" or default EC2
  vpc_zone_identifier = [var.pri_sub_4b_id,var.pri_sub_3a_id]
#   target_group_arns   = [var.tg_arn] #var.target_group_arns

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = aws_launch_template.launch_template.latest_version 
  }
}