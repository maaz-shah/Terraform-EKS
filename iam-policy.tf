resource "aws_iam_policy" "ekssecretsaccess" {

    name      = "ekssecretsaccess"
    path      = "/"
    policy    = jsonencode(
        {
            Statement = [
                {
                    Action   = [
                        "secretsmanager:GetSecretValue",
                        "secretsmanager:DescribeSecret",
                    ]
                    Effect   = "Allow"
                    Resource = var.secret_arn
                    Sid      = "VisualEditor1"
                },
            ]
            Version   = "2012-10-17"
        }
    )
    
    tags      = {
        "Name" = "terraform-eks"
    }
    tags_all  = {
        "Name" = "terraform-eks"
    }

}

resource "aws_iam_role" "aws-secrets" {
    assume_role_policy    = jsonencode(
        {
            Statement = [
                {
                    Action    = "sts:AssumeRoleWithWebIdentity"
                    Condition = {
                        StringLike = {
                            "${module.eks.oidc_provider}:aud" = "sts.amazonaws.com"
                            "${module.eks.oidc_provider}:sub" = "system:serviceaccount:*:aws-secrets"
                        }
                    }
                    Effect    = "Allow"
                    Principal = {
                        Federated = module.eks.oidc_provider_arn
                    }
                },
            ]
            Version   = "2012-10-17"
        }
    )
    
    force_detach_policies = false

    managed_policy_arns   = [
        aws_iam_policy.ekssecretsaccess.arn,
    ]
    max_session_duration  = 3600
    name                  = var.cluster_name
    path                  = "/"
    tags                  = {
        "cluster-name"                = var.cluster_name
        "team"      = "devops"
    }
    
}

resource "kubernetes_namespace" "namespaces" {
    count=length(var.srvaccount_namespace)
  metadata {
       
    name = var.srvaccount_namespace[count.index]
  }
}

resource "kubernetes_service_account" "aws-secrets" {
    automount_service_account_token = false
    count=length(var.srvaccount_namespace)
    

    metadata {
        annotations      = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.aws-secrets.arn
        }
        
        name             = "aws-secrets"
        namespace        = var.srvaccount_namespace[count.index]
        }



}