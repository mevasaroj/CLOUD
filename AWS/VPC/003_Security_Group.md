# 1. Security Group
 - A security group acts as a virtual, stateful firewall for cloud resources (like EC2 instances), controlling inbound and outbound traffic at the instance level rather than the subnet level.
 - It uses allow-rules to determine permitted traffic, with all denied by default.
 - Security groups are highly flexible, allowing multiple, attachable sets of rules to protect instances.

#### 2. Key Features of Security Groups
 - **Stateful Inspection**: If an inbound request is allowed, the outbound response is automatically allowed, regardless of outbound rules.
 - **Permissive Rules Only**: You can only create rules that allow traffic (whitelist); you cannot create rules that specifically deny access.
 - **Instance-Level Protection**: Unlike network ACLs (NACLs) that operate on subnets, security groups are applied directly to instances.
 - **Default Behavior**: By default, new security groups restrict all inbound traffic and allow all outbound traffic.

