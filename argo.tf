resource "helm_release" "argocd" {
  name  = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  version          = "5.22.1"
  create_namespace = true

# If something needs to be defined at the time of install
  values = [
    file("manifest/myapp/app.yaml")
  ]
}