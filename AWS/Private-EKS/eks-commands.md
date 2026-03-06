# AWS EKS - Commands
####  How to delete EKS AddOns from CLI
 - Delete aws-efs-csi-driver AddOns
```hcl
# aws eks delete-addon --cluster-name hbl-aws-aps1-lentra-prod-app-cluster --addon-name aws-efs-csi-driver
```
 - Delete  aws-ebs-csi-driver AddOns
```hcl
# aws eks delete-addon --cluster-name hbl-aws-aps1-lentra-prod-app-cluster --addon-name aws-ebs-csi-driver
```
 - Delete vpc-cni AddOns
```hcl
# aws eks delete-addon --cluster-name hbl-aws-aps1-dlm-prod-cluster --addon-name vpc-cni
```
 - Delete coredns AddOns
```hcl
# aws eks delete-addon --cluster-name hbl-aws-aps1-dlm-prod-cluster --addon-name coredns
```
 - Delete  kube-proxy AddOns
```hcl
# aws eks delete-addon --cluster-name hbl-aws-aps1-lentra-prod-app-cluster --addon-name kube-proxy
```
   
