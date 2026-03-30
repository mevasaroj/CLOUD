Terraform module which creates an ebs volume and attached to instance on AWS.

[![SWUbanner](https://github.hdfcbank.com/HDFCBANK/terraform-aws-module/blob/master/docs/HDFC_Terraform.svg)](https://github.hdfcbank.com/HDFCBANK/terraform-aws-module/tree/master/docs/README.md)


<h1 align="center">
    HDFC BANK Terraform Aws EBS
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    This terraform module is used for requesting or importing SSL/TLS certificate with validation.
     </p>

<p align="center">

<a href="https://github.com/clouddrove/terraform-aws-acm/actions/workflows/tfsec.yml">
  <img src="https://github.com/clouddrove/terraform-aws-acm/actions/workflows/tfsec.yml/badge.svg" alt="tfsec">
</a>
<a href="https://github.com/clouddrove/terraform-aws-acm/actions/workflows/terraform.yml">
  <img src="https://github.com/clouddrove/terraform-aws-acm/actions/workflows/terraform.yml/badge.svg" alt="static-checks">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-acm'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+Aws+Acm&url=https://github.com/clouddrove/terraform-aws-acm'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+Aws+Acm&url=https://github.com/clouddrove/terraform-aws-acm'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-acm/releases).


Here are some examples of how you can use this module in your inventory structure:

  ### EBS
  ```hcl
  module "ebs" {
    source                = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-ebs"
    version               = "1.1.7"
    availability_zone = var.availability_zone
    size              = var.size
    snapshot_id       = var.snapshot_id
    type              = var.volume_type
    tags              = var.tags
    encrypted         = var.encrypted
    kms_key_id        = var.kms_key_id
  }
  ```

