resource "aws_ecr_repository" "repository" {
  name                 = "auditions"
  image_tag_mutability = "IMMUTABLE"
}


resource "aws_route53_record" "simpsons" {
  zone_id = "Z02946672JE72JPDPF4XQ"
  name    = "simpsons.boise.jv-magic.com"
  type    = "A"

  alias {
    name                   = module.ecs-fargate.aws_lb_lb_dns_name
    zone_id                = module.ecs-fargate.aws_lb_lb_zone_id
    evaluate_target_health = true
  }
}

module "ecs-fargate" {
  source  = "cn-terraform/ecs-fargate/aws"
  version = "2.0.60"
  private_subnets_ids = ["subnet-058ce6089ddd8d578", "subnet-0d95ed5b0cef45d47", "subnet-0329cf55b9ca45343"]
  public_subnets_ids = ["subnet-000a95f93e1d65cc9","subnet-05d0dba328f4705e6","subnet-0bd76dd16c76b8e58"]
  vpc_id = "vpc-00634b116674cf4fb"
  lb_https_ports = {
    "default-https": {
      "listener_port": 443,
      "target_group_port": 4567
    }
  }
  lb_http_ports = {
    "default-http": {
      "listener_port": 80,
      "target_group_port": 4567
    }
  }
  port_mappings = [
    {
      "containerPort": 4567,
      "hostPort": 4567,
      "protocol": "tcp"
    }
  ]
  name_prefix = "auditions"
  container_image = "985261590842.dkr.ecr.us-east-1.amazonaws.com/auditions:latest"
  container_name = "auditions"
  default_certificate_arn = "arn:aws:acm:us-east-1:985261590842:certificate/a498a4be-b043-46fc-aba2-c4e375808d5d"
}