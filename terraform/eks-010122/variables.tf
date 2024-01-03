provider "aws" {
  profile = "prod"
  region  = "ap-northeast-2"
}

locals {
  cluster_name = "bb-msa"

  vpc_id     = module.vpc.vpc_id
  vpc_cidr   = "10.194.0.0/16"
  azs        = ["ap-northeast-2a", "ap-northeast-2c"]
  subnet_ids = module.vpc.public_subnets

  external_dns_arn  = "arn:aws:route53:::hostedzone/Z0411201U1BFBOFR3YH3"  # 개인용 Route53 HostingZone
  external_cert_arn = "arn:aws:acm:ap-northeast-2:661371928731:certificate/96a95d7a-1e0f-41bf-b79e-127cfb23c321"
  tags              = {
    CreatedBy = "Terraform"
  }
}
