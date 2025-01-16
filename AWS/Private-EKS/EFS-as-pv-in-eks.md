#  EFS as Persistent Volume in AWS EKS
## 1. Create EFS Role.
####  1.1.  Create Custom EFS Policy
 - Sign in to the AWS Management Console and open the IAM console at **https://console.aws.amazon.com/iam/**
 - In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Policies__, and then choose __Create policy__.
 - Click on JSON
 - Copy and paste the Policy from https://github.com/mevasaroj/CLOUD/blob/main/AWS/IAM/06_01_efs-as-pv-in-eks-policy.tf
 - Replace the **KMS Key ARN** at line no. 76 and 77
 - Click __Next__
 - Under **Review and create**
    - Policy Name : **efs-as-pv-in-eks-policy**
    - Description : **efs-as-pv-in-eks-policy**
    - Add Tags : Add require tags
 - Click __Create Policy__

####  1.2.  Create Create EFS Role
 - Sign in to the AWS Management Console and open the IAM console at https://console.aws.amazon.com/iam/
 - In the navigation pane of the IAM console, Expand __Access management__ (Left panel) choose __Roles__, and then choose __Create role__.
 - Under : **Select Trusted entity type**
    - Trusted entity type : **AWS service**
    - Use cases : type __"ec2"__ --> Select __"ec2"__ --> First Option
    - Click __Next__
 - Under **Add permission** --> Type **efs-as-pv-in-eks-policy** & Check Mark it --> Click __Next__
 - Under **Name, review, and create**
    - Role Name : **efs-as-pv-in-eks-role**
    - Description : **efs-as-pv-in-eks-role**
    - Step 1: Select trusted entities : __No Changes__
    - Step 2: Add permissions: __No Changes__
    - Step 3: Add Tags : Add the require tags
 - Click **create role**
  
####  1.3.  Update the Trust relationship
 - Sign in to the AWS Management Console and open the IAM console at **https://console.aws.amazon.com/iam/**
 - Below __Access management__ (Left Pane) --> Click **Roles**
 - Select **efs-as-pv-in-eks-role** from list
 - Click **Trust relationships**
 - Copy and paste the content from https://github.com/mevasaroj/CLOUD/blob/main/AWS/IAM/06_02_efs-as-pv-in-eks-trust-relation.tf

### 2. Add EFS Add-Ons.
 - Open the [ **Amazon EKS console.** ](https://console.aws.amazon.com/eks/home#/clusters)
 - In the left navigation pane, choose **Clusters**.
 - Choose the name of the cluster that you want to create the add-on for.
 - Choose the **Add-ons** tab.
 - Choose **Get more add-ons**.
 - On the **Select add-ons** page, choose **Amazon EFS CSI driver** --> Click **Next**
 - On the **Configure selected add-ons settings** page
    - Version = **Select Latest Version**
    - At **Add-on acces** = Select **IAM roles for service accounts (IRSA)**
    - At **Select IAM role** = Select **efs-as-pv-in-eks-role** from list
    - Expand **Optional configuration Settings**
       - No Chnage at **Add-on configuration schema**
       - No Chnage at **Configuration value**
       - At **Conflict resolution method** = Tick **Override** --> Click **Next**
 - Review and Click **Create**

### 3. Create **com.amazonaws.ap-south-1.elasticfilesystem** VPC endpoint
  - Open the Amazon VPC console at https://console.aws.amazon.com/vpc/
  - In the navigation pane, choose **Endpoints** under __PrivateLink and Lattice__
  - Choose **Create endpoint**
  - Choose the Following on page __Create endpoint__
     - Name  : **efs-endpoint**
     - For **Type**, choose **AWS services**
       
     - Under **Services** :
       - Type **elasticfilesystem** hit enter
       - Select **com.amazonaws.ap-south-1.elasticfilesystem** from **Service Name**
       
     - Under **Network setting**
       - VPC **Select the require vpc**
         
       - under **Additional settings**
         - DNS Name : Check Mark **Enable DNS name**
         - DNS record IP type : Select **Ipv4**
           
     - Under **Subnets**
       - Select 1 subnet from each zone
  
     - Under **Security groups**
       - Select : **vpc-endpoint-sg** created above
      
     - Under **Policy**
       - Select **Full Access**
      
     -   Under Tags : Add require tags
     -   Click **Create endpoint**

### 4. Create EFS from AWS Console

### 5. Create Storage Class
 - Create a StorageClass to define how volumes will be provisioned from EFS.
   ```hcl
   # vi efs-storage.yaml
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: efs-sc
   provisioner: efs.csi.aws.com
   parameters:
     directoryPerms: "700"
     fileSystemId: fs-0400ac090973d0a92
     provisioningMode: efs-ap
     basePath: "/"
   reclaimPolicy: Retain
   volumeBindingMode: WaitForFirstConsumer
   ```
 - Apply the file

   **$ kubectl apply -f efs-storage.yaml**
   
### 6. Create a PersistentVolume
 - to create a PersistentVolume (PV) that maps to the EFS file system.
 - Use the below yaml to create PV
   ```hcl
   # vi efs-pv.yaml
   apiVersion: v1
   kind: PersistentVolume
   metadata:
    name: efs-pv
   spec:
   capacity:
    storage: 5Gi
   volumeMode: Filesystem
   accessModes:
    - ReadWriteMany
   persistentVolumeReclaimPolicy: Retain
   storageClassName: efs-sc
   csi:
    driver: efs.csi.aws.com
    volumeHandle: fs-0400ac090973d0a92
   ```
 - Apply the file

   **$ kubectl apply -f efs-pv.yaml**


### 7. Create a PersistentVolumeClaim
 - create a PersistentVolumeClaim (PVC) that your pods will use to request storage
   ```hcl
   # vi efs-pvc.yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: efs-pvc
   spec:
   accessModes:
    - ReadWriteMany
   storageClassName: efs-sc
   resources:
    requests:
      storage: 5Gi
   ```
 - Apply this YAML file

   **$ kubectl apply -f efs-pvc.yaml**


### 8. Mount the PVC in Pod
 - Below is an example pod configuration that mounts the EFS-backed PVC
   ```hcl
   # vi efs-app-pod.yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: efs-app
   spec:
   containers:
   - name: app
     image: nginx
     volumeMounts:
     - name: efs-storage
       mountPath: /usr/share/nginx/html
   volumes:
   - name: efs-storage
     persistentVolumeClaim:
       claimName: efs-pvc
   ```
 - Deploy the pod

   **$ kubectl apply -f efs-app-pod.yaml**
 
### 9. Validation
 - Run the belwo command:

   **$ kubectl exec -it efs-app -- df -h**




 
