
# 1. Internet Gateway
 - An AWS Internet Gateway (IGW) is a horizontally scaled, redundant, and highly available VPC component that enables two-way communication between a Virtual Private Cloud (VPC) and the internet.
 - It enables public subnets to route traffic to the internet, supports IPv4/IPv6.
 - An internet gateway enables resources in your public subnets (such as EC2 instances) to connect to the internet if the resource has a public IPv4 address or an IPv6 address.
 - There is no charge for an internet gateway, but there are data transfer charges for EC2 instances that use internet gateways.
 - To use an internet gateway, you must attach it to a VPC and configure routing.
 - If a subnet is associated with a route table that has a route to an internet gateway, it's known as a public subnet.
 - If a subnet is associated with a route table that does not have a route to an internet gateway, it's known as a private subnet.
 -  Internet Gateway diagram
   
    <img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/VPC/internet-gateway.png" width="600" />

### 2. how to Convert Private Subnet to Public Subnet
 - Following Steps are to convert private subnet to public subnet
    - Assign the Public IP to Private Subnet
    - Create Internet Gateway
    - Attach the Internet Gateway to VPC
    - Create Route Table
    - Update Route Table
    - Associate Subnet to a Route Table

#### 2.1. Assign the Public IP to Private Subnet
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Click **Subnets** in the left navigation pane Under **Virtual private cloud**
 - Select Subnet --> Click **Action** --> Click **Edit subnet settings**
 - Under **Auto-assign IP settings**
    - Tick Mark on **Enable auto-assign public IPv4 address**
  
 - Click **Save**

#### 2.2. Create the Internet Gateway
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Click **Internet Gateways** in the left navigation pane Under **Virtual private cloud**
 - Click **Create internet gateway** Button Right Top Side pane.
 - Uner **Internet gateway settings**
    - Name = **hbl-aws-aps1-appname-igt**
  
 - Tags - optional = Enter Require Tags
 - Click **Create internet gateway**

#### 2.3. Attach the Internet Gateway to VPC
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Click **Internet Gateways** in the left navigation pane Under **Virtual private cloud**
 - Select the created internet gateway (**hbl-aws-aps1-appname-igt**) --> Click **Action** --> Click **Attach to VPC** --> Select **VPC**(hbl-aws-aps1-appname-prod-vpc) --> Click **Attach**

#### 2.4. Create a Route Table for the Public Subnet 
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Navigate to **Route Tables** in the left navigation pane Under **Virtual private cloud**
 - Click **Create route table** Button Right Top Side pane.
 - Under **Route table settings**
    - Name - optional = **hbl-aws-aps1-appname-prod-public-rtb**
    - VPC = Select the VPC from Drag Menu in which route table need to create.
  
 - Tags  = Enter Require Tags
 - Click **Create route table**


#### 2.5. Update a Route Table for the Public Subnet
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Navigate to **Route Tables** in the left navigation pane Under **Virtual private cloud**
 - Select the route table (**hbl-aws-aps1-appname-prod-public-rtb**) --> Click **Action** --> Click **Edit route**
 - Click **Add route** and 2 route as below
    - 1st route - for Local **VPC CIDR**
       - Destination = 10.211.0.0/16 --> Enter **VPC CIDR Range**
       - Target = Select **local**
  
    - 2nd route - for **internet gateway**
       - Destination = 0.0.0.0/0
       - Target = Select **Internet Gateway** -- Select **igt-06317a47e92e0111e** from Drag
  
 - Click **Save Changes**

#### 2.6. Associate Subnet to a Route Table to make subnet as Public Subnet
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Navigate to **Route Tables** in the left navigation pane Under **Virtual private cloud**
 - Select the route table (hbl-aws-aps1-appname-prod-public-rtb) --> Click **Action** --> Click **Edit subnet associations**
 - Under **Available subnets**
    - Select the Subnet which need to convert as Public
  
 - Click **Save Associations**
