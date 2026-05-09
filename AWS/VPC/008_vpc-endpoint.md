# 1. VPC endpoint
 - AWS VPC Endpoints enable private, secure connections between your Virtual Private Cloud (VPC) and supported AWS services or PrivateLink-powered services without requiring an internet gateway, NAT device, or VPN.
 - They keep traffic within the AWS network, enhancing security and reducing latency.

### 2. Key Types of VPC Endpoints
 - **Interface Endpoints**: Powered by AWS PrivateLink, these use Elastic Network Interfaces (ENIs) with private IP addresses to connect to services.
 - **Gateway Endpoints**: Act as a target for specific traffic in your route table, specifically for Amazon S3 and DynamoDB

### 3. Create VPC Endpoint
 - Open AWS Console --> Navigate to the **VPC Dashboard**
 - Click **Endpoints** in the left navigation pane Under **PrivateLink and Lattice**
 - Click **Create endpoint** Button Right Top Side pane.
 - Under **Endpoint settings**
    - Name tag - optional =
    - Type = Select **AWS Services**
  
 - Service Region = Don't Tick -- For Private Endpoint
 - Under **Services**
    - Service Name = Select **com.amazonaws.ap-south-1.s3**
    - Owner = amazon
    - Type = Interface
  
 - Under **Network settings**
    - VPC = Select the VPC from Drag Menu
  
 - Under **Additional settings**
    - Private DNS name = Tick **Enable private DNS name**
    - DNS record IP type = Tick **IPv4**
  
 - Under **Subnets**
    - Availability Zone = Select all AZ's + Select Require Subnet
    - IP address type = **IPv4**
  
 - Under **Security groups**
    - Select The Security Group --> This SG must require 443 allow from Entire VPC CIDR
  
 - Policy = **Full Access**

 - Tags = Enter the Require Tags

 - Click **Create endpoint**
