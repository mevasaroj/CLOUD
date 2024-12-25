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
 - 

