data "aws_availability_zones" "available" {
    # List of availability zones that do not support EKS
    exclude_names = ["us-east-1e", "us-west-1b"]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "azs" {
    state = "available"

}