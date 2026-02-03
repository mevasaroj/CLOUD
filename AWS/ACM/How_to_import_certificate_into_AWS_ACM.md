# How_to_import_certificate_into_AWS_ACM
## 1. Prerequisite
- Following 4 files are require
   - domain.key
   - 'DigiCert Global Root G2.txt'
   - 'GeoTrust EV RSA CA G2.txt'
   - domain.txt
 
## 2. Rename the certificate to cer file as below
  - mkdir /bre_domainbankapps_com
  - cd /bre_domainbankapps_com
  - mv domain.txt domain.cer
  - Example :
     - mv bre_domainbankapps_com.txt bre_domainbankapps_com.cer
   
## 3. Create crt file as below
 - $ cat 'DigiCert Global Root G2.txt' > bre_domainbankapps_com.crt
 - $ cat 'GeoTrust EV RSA CA G2.txt' >> bre_domainbankapps_com.crt

## 4. Copy the Private Key in same Folder 
 - $ cp ../Y_CSR_Files/Private_Key/bre_domainbankapps_com.key /bre_domainbankapps_com/

## 4. Following files are available to import certificate
 - cd /bre_domainbankapps_com
 - ls -l
   ``` hcl
   -rw-r--r-- 1 M19521 1049089 2518 Jun 12 04:28  bre_domainbankapps_com.cer
   -rw-r--r-- 1 M19521 1049089 3220 Jun 12 18:58  bre_domainbankapps_com.crt
   -rw-r--r-- 1 M19521 1049089 1704 Jun  9 15:39  bre_domainbankapps_com.key
   ```

## 6. Import Certificate in AWS Cert Manager 
``` hcl
module "bre_domainbankapps_com" {
  source    = "terraform.hdfcbank.com/HDFCBANK/module/aws//modules/aws-acm"
  version             = "1.0.6"
  name                = "bre_domainbankapps_com"
  environment         = "prod"
  label_order         = ["name"]  
  certificate_body    = "../bre_domainbankapps_com/bre_domainbankapps_com.cer"
  certificate_chain   = "../bre_domainbankapps_com/bre_domainbankapps_com.crt"
  private_key         = "../bre_domainbankapps_com/bre_domainbankapps_com.key"
  import_certificate  = true
  tags                = var.additional_tags
}
```


