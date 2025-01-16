{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "BaseAppPermissions",
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "cloudwatch:*",
                "secretsmanager:*",
                "logs:*",
                "glue:*",
                "s3:ReplicateObject",
                "s3:UntagResource",
                "s3:Put*",
                "s3:Describe*",
                "s3:TagResource",
                "s3:List*",
                "s3:Get*",
                "s3:RestoreObject",
                "s3:Update*",
                "s3:Create*",
                "s3-object-lambda:*",
                "redshift:DescribeClusters",
                "redshift:DescribeClusterSubnetGroups",
                "iam:List*",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "rds:DescribeDBInstances",
                "rds:DescribeDBClusters",
                "rds:DescribeDBSubnetGroups",
                "cloudformation:ListStacks",
                "cloudformation:DescribeStacks",
                "cloudformation:GetTemplateSummary",
                "dynamodb:ListTables",
                "kms:ListAliases",
                "kms:DescribeKey",
                "cloudwatch:GetMetricData",
                "cloudwatch:ListDashboards",
                "databrew:ListRecipes",
                "databrew:ListRecipeVersions",
                "databrew:DescribeRecipe"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "AllowAWSPasssroleActions",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::385089911239:role/hbl-aws-cam-role-glue-lentra-prod"
            ]
        },
        {
            "Sid": "AllowKMSPolicy",
            "Effect": "Allow",
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": [
                "arn:aws:kms:ap-south-1:911372318716:key/3226efbd-778f-4e56-be5d-e777a438c733"
            ]
        },
        {
            "Sid": "AllowS3ObjectPolicy",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::hbl-aws-aps1-lentra-nonpcidss-prod-transferx-ldp-data-s3-01",
                "arn:aws:s3:::hbl-aws-aps1-lentra-nonpcidss-prod-transferx-ldp-data-s3-01/*"
            ]
        },
        {
            "Sid": "SSMAccess",
            "Effect": "Allow",
            "Action": [
                "ssm:SendCommand",
                "ssm:ListCommands",
                "ssm:UpdateAssociation",
                "ssm:ListInstanceAssociations",
                "ssm:GetParameter",
                "ssm:DescribeParameters",
                "ssm:AddTagsToResource",
                "ssm:DescribeInstanceAssociationsStatus",
                "ssm:DescribeInstanceProperties",
                "ssm:DescribeAssociation",
                "ssm:GetConnectionStatus",
                "ssm:PutResourcePolicy",
                "ssm:GetParameters",
                "ssm:DescribeInstanceInformation",
                "ssm:CreateAssociation",
                "ssm:ModifyDocumentPermission",
                "ssm:ListTagsForResource",
                "ssm:ListCommandInvocations",
                "ssm:ListAssociations"
            ],
            "Resource": "*"
        }
    ]
}
