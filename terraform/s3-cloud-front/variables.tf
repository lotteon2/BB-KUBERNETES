provider "aws" {
  profile = "prod"
  region  = "ap-northeast-2"
}

locals {
  cluster_name = "bb-msa"

  external_dns_arn  = "arn:aws:route53:::hostedzone/Z0411201U1BFBOFR3YH3"  # 개인용 Route53 HostingZone
  external_cert_arn = "arn:aws:acm:ap-northeast-2:661371928731:certificate/96a95d7a-1e0f-41bf-b79e-127cfb23c321"
  tags              = {
    CreatedBy = "Terraform"
  }
}
