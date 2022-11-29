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