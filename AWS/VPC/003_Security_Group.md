# 1. Security Group
 - A security group acts as a virtual, stateful firewall for cloud resources (like EC2 instances), controlling inbound and outbound traffic at the instance level rather than the subnet level.
 - It uses allow-rules to determine permitted traffic, with all denied by default.
 - Security groups are highly flexible, allowing multiple, attachable sets of rules to protect instances.

#### 2. Key Features of Security Groups
 - **Stateful Inspection**: If an inbound request is allowed, the outbound response is automatically allowed, regardless of outbound rules.
 - **Permissive Rules Only**: You can only create rules that allow traffic (whitelist); you cannot create rules that specifically deny access.
 - **Instance-Level Protection**: Unlike network ACLs (NACLs) that operate on subnets, security groups are applied directly to instances.
 - **Default Behavior**: By default, new security groups restrict all inbound traffic and allow all outbound traffic.

#### 3. Create a Security Group
 - Open the **AWS Console**: Go to the Amazon VPC console.
 - In the navigation pane from Left Side, choose **Security groups** under Security
 - Click **Create security group** Button at Right Side Pane top.
 - Under : **Basic details**
    - Security group name = Enter Name (up to 255 characters, cannot start with "sg-") Ex. hbl-aws-aps1-appname-prod-rds-sg
    - Description  = Enter the Description
    - VPC = Select the VPC in which Security need to Create from Drag Menu
  
 - Inbound rules - Example for Port 22 - SSH
    - Type = SSH
    - Protocol = TCP - Default as per Type Selected
    - Port Range = 22 - Default as per Type Selected
    - Source = Custom - Type your IP Range of IP Address to allow
       - 10.211.1.0/24 --> For IP Range
       - 10.211.1.1/32 --> For Single IP.
      
 - Outbound rules = no Change - By Default it will allow all traffic
 - Tags - optional = Enter the Require Tags
 - Click **Create security group**
