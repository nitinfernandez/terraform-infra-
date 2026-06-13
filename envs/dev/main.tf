module "vpc" {
    
  source = "../../modules/vpc"

  cidr        = "10.0.0.0/16"

  
  subnet_cidr = "10.0.1.0/24"


  subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  name        = "dev-vpc"

}


module "sg" {
  source = "../../modules/security-group"

  name   = "dev-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  ]
}



module "alb" {
  source = "../../modules/alb"

  name               = "dev-alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.subnet_ids
  security_group_ids = [module.sg.id]
}

module "asg" {
  source = "../../modules/asg"

  name               = "dev-asg"
  ami                = "ami-xxxxxxxx"
  instance_type      = "t2.micro"
  subnet_ids         = module.vpc.subnet_ids
  security_group_ids = [module.sg.id]

  target_group_arns = [module.alb.target_group_arn]
}

