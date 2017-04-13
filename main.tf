# create our ALB
resource "aws_alb" "app" {
  name            = "${var.name}-alb"
  subnets         = ["${var.vpc_subnet_ids}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}

# external facing security group for ALB
resource "aws_security_group" "lb_sg" {
  description = "controls access to the application ELB"

  vpc_id = "${var.vpc_id}"
  name   = "${var.name}-lbsg"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 90
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "${internal_cidr}",
    ]
  }
}

# create DNS record for our LB in Route53
resource "aws_route53_record" "www" {
  zone_id = "${var.dns_zone_id}"
  name    = "${var.dns_name}"
  type    = "A"

  alias {
    name                   = "${aws_alb.app.dns_name}"
    zone_id                = "${aws_alb.app.zone_id}"
    evaluate_target_health = true
  }
}
