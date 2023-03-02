resource "helm_release" "csi-secrets-store" {
  name       = "csi-secrets-store"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace   = "kube-system"

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }
}

resource "helm_release" "aws-secrets-manager" {
  name       = "aws-secrets-manager"
  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  namespace   = "kube-system"

}