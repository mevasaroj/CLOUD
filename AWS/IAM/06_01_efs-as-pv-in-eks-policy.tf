{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowDescribe",
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:DescribeAccessPoints",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:DescribeMountTargets",
                "ec2:DescribeAvailabilityZones"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowCreateAccessPoint",
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:CreateAccessPoint"
            ],
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:RequestTag/efs.csi.aws.com/cluster": "false"
                },
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": "efs.csi.aws.com/cluster"
                }
            }
        },
        {
            "Sid": "AllowTagNewAccessPoints",
            "Effect": "Allow",
            "Action": [
                "elasticfilesystem:TagResource"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "elasticfilesystem:CreateAction": "CreateAccessPoint"
                },
                "Null": {
                    "aws:RequestTag/efs.csi.aws.com/cluster": "false"
                },
                "ForAllValues:StringEquals": {
                    "aws:TagKeys": "efs.csi.aws.com/cluster"
                }
            }
        },
        {
            "Sid": "AllowDeleteAccessPoint",
            "Effect": "Allow",
            "Action": "elasticfilesystem:DeleteAccessPoint",
            "Resource": "*",
            "Condition": {
                "Null": {
                    "aws:ResourceTag/efs.csi.aws.com/cluster": "false"
                }
            }
        },
		{
            "Sid": "KMSAccess",
            "Effect": "Allow",
            "Action": [
                "kms:ListGrants",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey",
                "kms:GenerateDataKeyWithoutPlaintext",
                "kms:DescribeKey",
                "kms:CreateGrant",
                "kms:ListAliases"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx",
                "arn:aws:kms:ap-south-1:xxxxxxxxxxxxxxx:key/xxxxxxxxxxxxxxx"
            ],
        }
    ]
}
