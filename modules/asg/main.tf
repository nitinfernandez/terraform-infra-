
esource "aws_launch_template" "this" {
  name_prefix   = var.name
  image_id      = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = var.security_group_ids
}

resource "aws_autoscaling_group" "this" {
  desired_capacity = 1
  max_size         = 2
  min_size         = 1

  vpc_zone_identifier = var.subnet_ids


  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arns
}

