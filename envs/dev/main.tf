module "vpc" {
    
  source = "../../modules/vpc"

  cidr        = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  name        = "dev-vpc"

}

module "ec2" {
  source = "../../modules/ec2"

  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id
  name          = "dev-ec2"
}
