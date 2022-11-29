
resource "aws_security_group" "eks-node-group" {
    name_prefix = "eks-node-group"
    vpc_id = module.vpc.vpc_id
   
   ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true

    } 

 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = [
            "10.0.0.0/8"
        ]

  }
}

