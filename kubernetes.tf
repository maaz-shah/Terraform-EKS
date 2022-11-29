resource "kubernetes_secret" "mysecret" {
      data = {
    SECRET_KEY = var.secret_key
    ACCESS_KEY = var.access_key
    S3_BUCKET_NAME = var.bucketname
  }
    type      = "Opaque"

    metadata { 
       name             = "mysecret"
        namespace        = "default"
     }
}
resource "kubernetes_service_v1" "myservice" {
   
    metadata {
        annotations      = {
            "service.beta.kubernetes.io/aws-load-balancer-internal" = "true"
        }
        labels           = {
            "app" = "myapp"
        }
        name             = "myservice"
        namespace        = "default"
    }

    spec {
        allocate_load_balancer_node_ports = true
        load_balancer_source_ranges       = []
        type   = "LoadBalancer"
        selector   = {
            "app" = "myapp"
        }
        port {
      name        = "http"      
      port        = 5000
      target_port = 5000
       }
    }

}
resource "kubectl_manifest" "myapp" {
    yaml_body = <<YAML
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "myapp"
  labels:
    app: "myapp"
spec:
  selector:
    matchLabels:
      app: "myapp"
  replicas: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:      
      labels:
        app: "myapp"
    spec:
      containers:
      - name: "myapp"
        image: mazishah/python-enumrate-api:0.1.0
        imagePullPolicy: Always
        ports:
        - containerPort: 5000
        envFrom:
        - secretRef:
            name: mysecret

YAML
}