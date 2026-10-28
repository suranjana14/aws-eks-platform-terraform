locals {
  tags = {
    Project     = "eks-platform"
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name               = "${var.cluster_name}-vpc"
  cidr_block         = "10.20.0.0/16"
  az_count           = 3
  single_nat_gateway = true # one NAT keeps staging cost down; set false in prod
  cluster_name       = var.cluster_name
  tags               = local.tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name           = var.cluster_name
  kubernetes_version     = var.kubernetes_version
  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnet_ids
  endpoint_public_access = false
  admin_principal_arns   = var.admin_principal_arns

  node_instance_types = ["m6i.large", "m6a.large"]
  node_capacity_type  = "SPOT"
  node_min_size       = 2
  node_desired_size   = 2
  node_max_size       = 6

  tags = local.tags
}
