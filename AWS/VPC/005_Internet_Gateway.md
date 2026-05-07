
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
