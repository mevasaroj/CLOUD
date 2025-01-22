### How to Create Profile for AWS CLI Command on Jump Server
 - Create a config file at user home directory
 - $ vi /home/username/.aws/config
    ```hcl
    [default]
    region = ap-south-1
    output = text

    [profile hdfcbank]
    region = ap-south-1
    role_arn = arn:aws:iam::xxxxxxxxxxxxxxx:role/eks-cluster-role
    credential_source = Ec2InstanceMetadata
    output = text
    ```
 - Validate a configuration
 - $ aws configure list
 - $ aws configure list-profiles
 - $ aws sts get-caller-identity
   
### How to Connect to EKS Cluster
###### Command
 - $ aws eks --region ap-south-1 update-kubeconfig --name hbl-aws-aps1-dlm-uat-cluster
###### Example  
 - $ aws eks --region ap-south-1 update-kubeconfig --name hbl-aws-aps1-appname-prod-cluster
 - $ aws eks --region ap-south-1 update-kubeconfig --name hbl-aws-aps1-appname-prod-bottlerocket-cluster
 - $ aws eks --region ap-south-1 update-kubeconfig --name hbl-aws-aps1-appname-prod-amazonlinux2023-cluster
   
### How to remove add-ons from Jump Server
###### Command
 - $ aws eks delete-addon --cluster-name cluster-name --addon-name add-ons-name
###### Example 
 - $ aws eks delete-addon --cluster-name aws-appname-prod-app-cluster --addon-name aws-efs-csi-driver
 - $ aws eks delete-addon --cluster-name aws-appname-dev-app-cluster --addon-name vpc-cni
 - $ aws eks delete-addon --cluster-name aws-appname-uat-app-cluster --addon-name coredns
 - $ aws eks delete-addon --cluster-name aws-appname-prod-data-cluster --addon-name kube-proxy
 - $ aws eks delete-addon --cluster-name aws-appname-prod-log-cluster --addon-name aws-ebs-csi-driver


