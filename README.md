# terraform-eks
Launch EKS cluster using terraform


## FAQ
1. Error creating Cluster
```
Error: error creating EKS Cluster (my-cluster): UnsupportedAvailabilityZoneException: Cannot create cluster 'my-cluster' because us-west-1b, the targeted availability zone, does not currently have sufficient capacity to support the cluster. Retry and choose from these availability zones: us-west-1a, us-west-1c
```
This happens when AWS does not have enough resources to launch the cluster in the specific zone, you can exclude zone in `data.tf` 
```
exclude_names = ["us-east-1e", "us-west-1b"]
```