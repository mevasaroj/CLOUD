 - 1. **What are the logging and monitoring options in Azure?**
   2. Azure Monitor, Log Analytics, Application Insights, Activity Logs, Diagnostic Logs.

- 2. What are the options to connect PaaS services in Azure?
     - Public Endpoint, Private Endpoint, Service Endpoint, VNET Integration.
3.	Can a user with Contributor/Owner access on subscription access the storage data?
No, requires Storage Blob Data Reader/Contributor.
4.	If VNET A is peered with VNET B and VNET B with VNET C, can A access C?
No, VNET peering is not transitive.
5.	Most secure authentication for accessing storage from a VM?
Managed Identity with RBAC.
6.	Most secure storage networking option for VM access?
Private Endpoint.
7.	Common cost saving strategies?
Right sizing, Spot VMs, Reservations, AHUB, Savings Plans, Autoscaling, Start/Stop automation, Lifecycle policies, AMD SKUs.
8.	Have you worked on DB deployment?
Yes.
9.	Which DB deployments have you worked on?
SQL DB, PostgreSQL DB, Cosmos DB.
10.	Can you enable Azure Hybrid Benefit on SQL DB with DTU or Serverless?
No.
11.	VNET Integration or Private Endpoint for PostgreSQL DB and why?
VNET Integration is free; Private Endpoint is more secure but adds cost.
12.	What are the DR options for Azure SQL DB?
Geo Replication or Auto Failover Groups.
13.	What are the DR options for Azure PostgreSQL DB?
Geo replicas or cross region deployment using Flexible Server HA.
14.	Can we identify RU usage per query in Cosmos DB (Mongo API)?
Yes, via the x ms request charge header.
15.	Have you worked on AKS?
Yes.
16.	Purpose of System node pool and User node pool?
System pool runs core AKS components; user pool runs application workloads.
17.	Types of Nodepools?
VMSS based, VM based, NAP based.
18.	How many subnets required for Azure CNI Overlay?
One for nodes; POD and Service CIDRs are virtual.
19.	Important points for AKS subnet IP planning?
Ensure enough IPs, avoid overlaps, plan for scaling and future node pools.
20.	Setting needed for AKS API server to have private IP?
Enable Private Cluster (Private API server).
21.	Which subnet does API server pick private IP from?
From the AKS private cluster delegated subnet, also known as the node subnet.
22.	How AKS authenticates to create backend resources in managed RG?
Using its Managed Identity.
23.	What basic resources get created in AKS managed resource group?
Load balancers, Route tables, Managed Identity, Public IPs (if used), supporting infra.
24.	Where is the A record of API server hosted?
Azure Private DNS Zone (private cluster) or Azure managed DNS (public cluster).
25.	What things to check if nslookup is not giving private IP of storage?
Verify VM DNS configuration, ensure VM’s VNET is linked with the private DNS zone, confirm the private DNS zone has the storage A record, and check that the storage account has a Private Endpoint configured.
26.	Have you worked on Terraform development?
Yes.
27.	If asked to develop a module live, can you do it?
Yes.
28.	What Terraform provider is used for Azure?
Azurerm.
29.	If 20 VMs are created using loop, can you modify just one VM? How?
Yes, by using for_each instead of count.
30.	Can I use output of one Terraform module as input for another?
Yes.
