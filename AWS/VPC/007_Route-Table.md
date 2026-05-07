# 1. Route Tables 
 -  A route table is a set of rules (called routes) that determine where network traffic from your subnets or gateways is directed.
 -  It acts as a traffic controller for your Virtual Private Cloud (VPC), ensuring data packets reach the correct destination based on their IP address. 

### 2. Core Concepts
 - **Destination**: The range of IP addresses (in CIDR notation) where you want traffic to go.
 - **Target**: The gateway, network interface, or connection through which to send the traffic (e.g., an Internet Gateway or NAT Gateway).
 - **Local Route**: A default rule automatically added to every route table that allows internal communication between all resources within the VPC.


### 3. Types of Route Tables
 - **Main Route Table**: Automatically created with your VPC. It controls routing for any subnet that isn't explicitly associated with another table.
 - **Custom Route Table**: A table you create manually to gain granular control over specific subnets.
 - **Gateway Route Table**: Associated with an Internet Gateway or Virtual Private Gateway to control traffic entering your VPC.
 - **Transit Gateway Route Table**: Used with an AWS Transit Gateway to manage traffic between multiple VPCs and on-premises networks.
