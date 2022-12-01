
variable "region" {
    default = "us-west-1"
    description = "AWS region"
}
variable "access_key" { }
variable "secret_key" { }


variable "cluster_name" {
  default     = "my-cluster"
  description = "EKS Cluster name"
}

variable "cluster_version" {
  default     = "1.23"
  description = "Kubernetes version"
}

variable "instance_type" {
  default     = "t3.small"
  description = "EKS node instance type"
}

variable "instance_count" {
  default     = 2
  description = "EKS node count"
}

variable "node_groups" {
  description = "Number of nodes groups to create in the cluster"
  default     = 3
}
variable "bucketname" {
  default     = "atestbucket0210"
  description = "bucket name for the app"
}
