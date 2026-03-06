# AWS EKS - Commands
####  How to delete EKS AddOns from CLI
``hcl
# aws eks delete-addon --cluster-name hbl-aws-aps1-lentra-prod-app-cluster --addon-name aws-efs-csi-driver
# aws eks delete-addon --cluster-name hbl-aws-aps1-dlm-prod-cluster --addon-name vpc-cni
# aws eks delete-addon --cluster-name hbl-aws-aps1-dlm-prod-cluster --addon-name coredns
# aws eks delete-addon --cluster-name hbl-aws-aps1-lentra-prod-app-cluster --addon-name kube-proxy
# aws eks delete-addon --cluster-name hbl-aws-aps1-lentra-prod-app-cluster --addon-name aws-ebs-csi-driver
```
