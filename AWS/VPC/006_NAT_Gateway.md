# 1. NAT Gateway
 - An AWS NAT Gateway is a managed Network Address Translation service that enables instances(EC2) in a private subnet to connect to the internet or other VPCs, while preventing unsolicited inbound connections.
 - A NAT Gateway is deployed in a public subnet and acts as a bridge between instances in the private subnet and the internet.
 - When an instance in a private subnet sends a request to the internet, the request is forwarded to the NAT Gateway, which replaces the instance’s private IP address with the NAT Gateway’s public IP address and sends the request to the internet.
 - NAT Gateway can allow instances in a private subnet to access resources on the internet, such as software updates, patches.
 - NAT Gateway diagram
   
    <img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/VPC/nat_gateway.png" width="700" />

### 2. How to Enable Internet Access to Private Subnet
 - Following Steps are require to allow access to Private Subnet
    - Create NAT Gateway in Public Subnet
    - Create Private Route Table
    - Associate Private Subnet to NAT Route Table
    - Update the route table
  
#### 2.1. Create NAT Gateway in Public Subnet
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Click **NAT gateways** in the left navigation pane Under **Virtual private cloud**
 - Click **Create NAT gateway** Button Right Top Side pane.
 - Under **NAT gateway settings**
    - Name - optional = hbl-aws-aps1-appname-outbound-prod-natgw-aza
    - Availability mode = **Regional - new**
    - VPC = Select the VPC
    - Connectivity type = **Public**
    - Method of Elastic IP (EIP) allocation = **Automatic**
  
 - Tags = Enter the Require Tags
 - Click **Create NAT gateway**

#### 2.2. Create Private Route Table
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Navigate to **Route Tables** in the left navigation pane Under **Virtual private cloud**
 - Click **Create route table** Button Right Top Side pane.
 - Under **Route table settings**
    - Name - optional = hbl-aws-aps1-appname-prod-private-rtb
    - VPC = Select the VPC from Drag Menu in which route table need to create.
  
 - Tags  = Enter Require Tags
 - Click **Create route table**

#### 2.3. Associate Private Subnet to NAT Route Table
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Navigate to **Route Tables** in the left navigation pane Under **Virtual private cloud**
 - Select the route table (hbl-aws-aps1-appname-prod-private-rtb) --> Click **Action** --> Click **Edit subnet associations**
 - Under **Available subnets**
    - Select the Subnet which need to attach
  
 - Click **Save Associations**

#### 2.4. Update the route table
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Navigate to **Route Tables** in the left navigation pane Under **Virtual private cloud**
 - Select the route table (hbl-aws-aps1-appname-prod-public-rtb) --> Click **Action** --> Click **Edit route**
 - Click **Add route** and 2 route as below
    - 1st route - for Local **VPC CIDR**
       - Destination = 10.211.0.0/16 --> Enter VPC CIDR Range
       - Target = Select **local**
  
    - 2nd route - for **NAT gateway**
       - Destination = 0.0.0.0/0
       - Target = Select **Internet Gateway** -- Select **nat-89767a47e92e0321w** from Drag
  
 - Click **Save Changes**
