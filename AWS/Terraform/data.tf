#=================================
# Variable inputs for Locals
#=================================
locals {
  org		= "hbl"
  csp		= "aws"
  region	= "aps1"
  vpcname	= "nonpcidss"
  env		= "uat"
  account	= "ee"
  date      = timestamp()
  subnet_az_map = {
    az_1  = "ap-south-1a",
    az_2  = "ap-south-1b",
    az_3  = "ap-south-1c"
 } 
}
