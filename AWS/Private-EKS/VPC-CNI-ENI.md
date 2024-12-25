# VPC CNi - ENi
### 1. What is VPC CNI
 - The Amazon VPC CNI plugin for Kubernetes add-on is deployed on each Amazon EC2 node in your Amazon EKS cluster.
 - The add-on creates elastic network interfaces and attaches them to your Amazon EC2 nodes.
 - The add-on also assigns a private IPv4 or IPv6 address from your VPC to each Pod.
 - The CNI plugin manages Elastic Network Interfaces (ENI) on the node. When a node is provisioned, the CNI plugin automatically allocates a pool of slots (IPs or Prefix's) from the node's subnet to the primary ENI.

##### Diagram VPC-EKS-CNi
<img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/Private-EKS/Diagram-Images/VPC-CNI.jpg" width="600" />


### 2. What is VPC-EKS-ENi
 - An elastic network interface is a logical networking component in a VPC that represents a virtual network card.
 - By default, Amazon VPC CNI will assign Pods an IP address selected from the primary subnet.
 - If the subnet CIDR is too small, the CNI may not be able to acquire enough secondary IP addresses to assign to your Pods.
 - Custom networking is one solution to this problem.
 - Custom networking is assigning the node and Pod IPs from secondary VPC address spaces (CIDR).
 - When custom networking is enabled, the VPC CNI creates secondary ENIs in the subnet defined under ENIConfig. The CNI assigns Pods an IP addresses from a CIDR range defined in a ENIConfig CRD.

##### Diagram VPC-EKS-ENi
<img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/Private-EKS/Diagram-Images/VPC-EKS-ENI.jpg" width="600" />


### 3. Enable the VPC CNI
 - Validate the Latest Plugins must be installed.
 
   **$ kubectl describe daemonset aws-node --namespace kube-system | grep Image | cut -d "/" -f 2**
   ```hcl
   amazon-k8s-cni-init:v1.18.5-eksbuild.1
   amazon-k8s-cni:v1.18.5-eksbuild.1
   amazon
   ```

   
 - Set the **AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG** environment variable to **true** in the aws-node[.noloc]`DaemonSet.
 
   **$ kubectl set env daemonset aws-node -n kube-system AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG=true**


   
 - Set the **AWS_VPC_K8S_CNI_EXTERNALSNAT** environment variable to **false** to allow outside traffic

   **$ kubectl set env daemonset aws-node -n kube-system AWS_VPC_K8S_CNI_EXTERNALSNAT=false**


   
 - Validation

   **$ kubectl describe daemonset aws-node --namespace kube-system |grep AWS_VPC_K8S**
   ```hcl
   AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG:     **[true]**
   AWS_VPC_K8S_CNI_EXTERNALSNAT:           **false**
   AWS_VPC_K8S_CNI_LOGLEVEL:               DEBUG
   AWS_VPC_K8S_CNI_LOG_FILE:               /host/var/log/aws-routed-eni/ipamd.log
   AWS_VPC_K8S_CNI_RANDOMIZESNAT:          prng
   AWS_VPC_K8S_CNI_VETHPREFIX:             eni
   AWS_VPC_K8S_PLUGIN_LOG_FILE:            /var/log/aws-routed-eni/plugin.log
   AWS_VPC_K8S_PLUGIN_LOG_LEVEL:           DEBUG
   ```
   
 - Set the **ENI_CONFIG_LABEL_DEF** environment variable to **topology.kubernetes.io/zone** to allow outside traffic.
   
   **$ kubectl set env daemonset aws-node -n kube-system ENI_CONFIG_LABEL_DEF=topology.kubernetes.io/zone**
  
 - Validation

   **$ kubectl describe daemonset aws-node --namespace kube-system |grep ENI_CONFIG**
   ```hcl
   ENI_CONFIG_LABEL_DEF:                   topology.kubernetes.io/zone
   ```

    
### 4. VPC-EKS-CNI Custom Configuration
 - Create the yaml configuration file as below.
```hcl
apiVersion: crd.k8s.amazonaws.com/v1alpha1
kind: ENIConfig
metadata:
 name: ap-south-1a
spec:
  securityGroups: 
    - sg-xxxxxxxxxxxxxxx # All Port Must allow from Self-SG
  subnet: subnet-xxxxxxxxxxxxx  # Secondary Subnet which having 100.x.x.x cidr
---
apiVersion: crd.k8s.amazonaws.com/v1alpha1
kind: ENIConfig
metadata:
 name: ap-south-1b
spec:
  securityGroups: 
    - sg-xxxxxxxxxxxxx # All Port Must allow from Self-SG
  subnet: subnet-xxxxxxxxxxx # Secondary Subnet which having 100.x.x.x cidr
---
apiVersion: crd.k8s.amazonaws.com/v1alpha1
kind: ENIConfig
metadata:
 name: ap-south-1c
spec:
  securityGroups: 
    - sg-xxxxxxxxxxxxxxx # All Port Must allow from Self-SG
  subnet: subnet-xxxxxxxxxxxx # Secondary Subnet which having 100.x.x.x cidr
```

 - Apply the ENi Custom configuration

   **$ kubectl apply -f eniconfig.yaml**
   ```hcl
   eniconfig.crd.k8s.amazonaws.com/ap-south-1a created
   eniconfig.crd.k8s.amazonaws.com/ap-south-1b created
   eniconfig.crd.k8s.amazonaws.com/ap-south-1c created
   ```
 - Validate the configuration

   **$ kubectl get eniconfig**
   ```hcl
   NAME          AGE
   ap-south-1a   81s
   ap-south-1b   81s
   ap-south-1c   81s
   ```


### 4. Enable Custom COnfiguration at EKS Node
 - Kubernetes will now automatically apply the corresponding ENIConfig matching the nodes AZ, and no need to manually annotate the new EC2 instance with ENIConfig.

   **$ kubectl set env daemonset aws-node -n kube-system ENI_CONFIG_LABEL_DEF=failure-domain.beta.kubernetes.io/zone**
   ```hcl
   daemonset.apps/aws-node env updated
   ```

   **$ kubectl set env daemonset aws-node -n kube-system ENI_CONFIG_LABEL_DEF=topology.kubernetes.io/zone**


### 5. Restart & Rollout configuration
 - Terminate the EKS-node from console and rollout and restart with below command.

   **$ kubectl rollout restart ds aws-node -n kube-system**
   ```hcl
   daemonset.apps/aws-node restarted
   ```

