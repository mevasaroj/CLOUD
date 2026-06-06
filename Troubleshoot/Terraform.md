Q1. how does terraform handle state lock, and what happen if the lock is lost mid-appy
 - Terraform prevents simultaneous state modifications by automatically acquiring a lock on your state backend before running operations like plan or apply.
 - If the lock is lost mid-apply (e.g., pipeline cancellation), Terraform halts, the remote lock remains, and your infrastructure state may become temporarily inconsistent

2. why terraform start modifying when plan shows no changes

Q3. how do you safely manage terraform state across multiple teams and environments
   - To manage terraform state across multiple apply least privilege to access keys and identity bindings using IAM Role, Restrict access to S3 bucket to respective engineer.
   - To manage multiple environment use separate workspace for each environment like 1 workspace for prod and another workspace for uat.
      
5. what problem arise when multiple modules reference the same resources and how do you design around it

Q6. What is difference between count and for_each 
 - count loops through numbers (indices) - Creates multiple instances based on an integer (e.g., N = 3). Resources are tracked by numbers.
 - for_each loops through strings (keys) - Creates multiple instances based on a map or set of strings. Resources are tracked by unique keys.
   
Q7. why resource destroying by switching between from count to for_each
 - Terraform is managing the lifecycle of infrastructure in immutable State Addresses and if it change then resources will destroy and re-create.

Q8. How do you handle secrets in terraform without exposing them in state first.
--> 

Q9. What is depends_on in terraform
 - The depends_on is used in Terraform to explicitly control the execution order of resources or modules.
 - It instructs Terraform to fully create declared dependency before processing the resource that defines the depends_on statement
   ```hcl
   # 1. Create the Custom VPC
   resource "aws_vpc" "app_vpc" {
       cidr_block           = "10.0.0.0/16"
       enable_dns_support   = true
   tags = {
       Name = "main-vpc"
   }
   }

   # 2. Create the Subnet with explicit dependency
   resource "aws_subnet" "public_subnet" {
   # Explicitly tells Terraform to wait until the VPC is fully created
   depends_on = [
      aws_vpc.app_vpc
   ]
   # Implicit link: references the ID attribute of the VPC resource
   vpc_id                  = aws_vpc.custom_vpc.id
   cidr_block              = "10.0.1.0/24"
   availability_zone       = "ap-south-1a"
   map_public_ip_on_launch = true
   tags = {
      Name = "public-subnet-1a"
   }
   }
   ```

Q10. what is implicit dependency in terraform
 - An implicit dependency in Terraform is a relationship that Terraform automatically discovers when one resource references an attribute of another resource
 - Example
   ```hcl
   # Parent Resource
   resource "aws_vpc" "main" {
       cidr_block = "10.0.0.0/16"
   }

   # Dependent Resource
   resource "aws_subnet" "public" {
   # This reference creates the implicit dependency
       vpc_id     = aws_vpc.main.id
       cidr_block = "10.0.1.0/24"
   }   
   ```

12.
13.
14.
15. a

16. 
17.
18.
19.
20.
21.
22.
23. a
- 
- 2. 
  3.
  4.
  5.
  6.
  7.
  8.
  9.
  10.
  11. a
