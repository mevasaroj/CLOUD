{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com",
                "AWS": "arn:aws:iam::xxxxxxxxxxxx:role/<efs-as-pv-in-eks-role>"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "<CLUSTER_OIDC_ARN>"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.ap-south-1.amazonaws.com/id/<CLUSTER_OIDC_ID>:sub": [
                        "system:serviceaccount:kube-system:efs-csi-controller-sa",
                        "system:serviceaccount:kube-system:efs-csi-node-sa"
                    ],
                    "oidc.eks.ap-south-1.amazonaws.com/id/<CLUSTER_OIDC_ID>:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}

#============================================================================================================================
EXAMPLE
------------
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com",
                "AWS": "arn:aws:iam::xxxxxxxxxxxx:role/efs-as-pv-in-eks-role"
            },
            "Action": "sts:AssumeRole"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::xxxxxxxxxxxx:oidc-provider/oidc.eks.ap-south-1.amazonaws.com/id/A6A20B8F7F1690F755A1D372370FF5C4"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.ap-south-1.amazonaws.com/id/A6A20B8F7F1690F755A1D372370FF5C4:sub": [
                        "system:serviceaccount:kube-system:efs-csi-controller-sa",
                        "system:serviceaccount:kube-system:efs-csi-node-sa"
                    ],
                    "oidc.eks.ap-south-1.amazonaws.com/id/A6A20B8F7F1690F755A1D372370FF5C4:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
