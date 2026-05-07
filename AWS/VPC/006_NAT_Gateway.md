# 1. NAT Gateway
 - An AWS NAT Gateway is a managed Network Address Translation service that enables instances(EC2) in a private subnet to connect to the internet or other VPCs, while preventing unsolicited inbound connections.
 - A NAT Gateway is deployed in a public subnet and acts as a bridge between instances in the private subnet and the internet.
 - When an instance in a private subnet sends a request to the internet, the request is forwarded to the NAT Gateway, which replaces the instance’s private IP address with the NAT Gateway’s public IP address and sends the request to the internet.
 - NAT Gateway can allow instances in a private subnet to access resources on the internet, such as software updates, patches.
 - NAT Gateway diagram
   
    <img src="https://github.com/mevasaroj/CLOUD/blob/main/AWS/VPC/nat_gateway.png" width="700" />
