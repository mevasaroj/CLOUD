# 1. VPC endpoint
 - AWS VPC Endpoints enable private, secure connections between your Virtual Private Cloud (VPC) and supported AWS services or PrivateLink-powered services without requiring an internet gateway, NAT device, or VPN.
 - They keep traffic within the AWS network, enhancing security and reducing latency.

### 2. Key Types of VPC Endpoints
 - **Interface Endpoints**: Powered by AWS PrivateLink, these use Elastic Network Interfaces (ENIs) with private IP addresses to connect to services.
 - **Gateway Endpoints**: Act as a target for specific traffic in your route table, specifically for Amazon S3 and DynamoDB
