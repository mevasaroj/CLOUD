# 1. Subnet
 - A subnet is a range of IP addresses in your VPC.
 - Partition creation inside VPC called Subnet.
 - It is a subdivision of a VPC. Breaking the network down into smaller networks (subnets) is called subnetting.
 - By default all subnets created inside VPC are in private network.
 - AWS not allow to change the size of a subnet after creation.
 - All AWS resources can only create in specific subnets. such as EC2 instances(IAAS), RDS(PAAS).

### 2. Key Characteristics of Subnet
 - **Availability Zone (AZ) Specific**: Every subnet must reside entirely within one Availability Zone and cannot span across multiple zones.
 - **Subnet IP Range**: Each subnet is defined by a CIDR block (e.g., 10.0.1.0/24) that must be a subset of the overall VPC CIDR block.
 - **Reserved Addresses**: AWS reserves the first four and the last one IP addresses in every subnet for internal networking purposes (e.g., the VPC router and DNS).

### 3. Subnet Types
 - **Public Subnet**: Has a direct route to an Internet Gateway. Resources here can be accessed directly from the public internet if they have a public IP.
 - **Private Subnet**: Does not have a direct route to the internet. Resources here use a NAT Gateway (located in a public subnet) to initiate outbound connections while remaining hidden from inbound internet traffic.
 - **VPN-only Subnet**: A subnet whose traffic is routed to a Site-to-Site VPN connection via a Virtual Private Gateway (VGW).
 - **Isolated Subnet**: A special type of private subnet with no routing to the internet or any VPN, often used for strictly internal traffic.

##### 3.1. Subnet IP address range
 - Subnet require to specify its IP range during subnet creation depending on the configuration of the VPC.
    - **IPv4 only** – The subnet has an IPv4 CIDR block but does not have an IPv6 CIDR block. Resources in an IPv4-only subnet must communicate over IPv4.
    - **IPv6 only** – The subnet has an IPv6 CIDR block but does not have an IPv4 CIDR block. The VPC must have an IPv6 CIDR block. Resources in an IPv6-only subnet must communicate over IPv6.
    - **Dual stack** – The subnet has both an IPv4 CIDR block and an IPv6 CIDR block. The VPC must have both an IPv4 CIDR block and an IPv6 CIDR block. Resources in a dual-stack subnet can communicate over IPv4 and IPv6.


##### 3.2. Subnet diagram

  <img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/VPC/subnet-diagram.png" width="600" />


### 4. How to create Subnet.
 - Log in to the **AWS Management Console** and navigate to the **VPC Dashboard** --> Click **Subnets** under Virtual private cloud
 - Click the **Create Subnet** button.
 - Under **VPC**
    - VPC ID = Select the existing vpc
  
 - Under **Subnet Settings**
    - Subnet name = hbl-aws-aps1-appname-uat-infra-subnet-aza
    - Availability Zone = Select **ap-south-1a**
    - IPv4 VPC CIDR block = 10.211.0.0/16 - It will auto reflect
    - IPv4 subnet CIDR block = Define the Subnet CIDR - It must within VPC CIDR Block (Example - 10.211.1.0/24, 10.211.2.0/24)
    - Tags - optional = Define Tags
  
 - Click **Create Subnet**
 
