#  AWS Certificate Manager 
## 1. Generate the CSR File.
 - Run the Below Command to generate CSR file
    - ]# openssl req -new -newkey rsa:2048 -keyout subdomain.domain.key -nodes -out subdomain.domain.csr
    - Ex. # openssl req -new -newkey rsa:2048 -keyout meva.cloudeng.com.key -nodes -out meva.cloudeng.com.csr
   ```hcl
   Generating a RSA private key writing new private key to 'bre.hdfcbankapps.com.key'
   -----
   There are quite a few fields but you can leave some blank For some fields there will be a default value,
   If you enter '.', the field will be left blank.
   -----
   Country Name (2 letter code) [XX]: IN
   State or Province Name (full name) []: Maharashtra
   Locality Name (eg, city) [Default City]: Mumbai
   Organization Name (eg, company) [Default Company Ltd]: Company Name
   Organizational Unit Name (eg, section) []: IT
   Common Name (eg, your name or your server's hostname) []: meva.cloudeng.com.com
   Email Address []: BLANK – Direct Enter
   Please enter the following 'extra' attributes
   to be sent with your certificate request
   A challenge password []: BLANK – Direct Enter
   An optional company name []: BLANK – Direct Enter
   ```

   
 - Run the following command to valite the CSR file generation
   - ]# ls -l
   ```hcl
   total 8
   -rw-r--r--. 1 root root 1033 Jun  9 10:11 meva.cloudeng.com.csr
   -rw-------. 1 root root 1704 Jun  9 10:09 meva.cloudeng.com.key

   ```

## 2. Generate the Certificate
 - Ask Respective team to generate the certificate using csr file


## 3.	Consolidate the Require Files
####  3.1.  Create certificate file --> CER file
 - Certificate Creation team will revert with zip which include 3 files as below. Download zip file and unzip it.
    - $ unzip meva.cloudeng.com
    - $ cd meva.cloudeng.com
    - $ ls -l
      ```hcl
      total 12
      -rw-r--r-- 1 M19521 1049089 1316 Jun 12 04:28 'DigiCert Global Root G2.txt'
      -rw-r--r-- 1 M19521 1049089 1904 Jun 12 04:28 'GeoTrust EV RSA CA G2.txt'
      -rw-r--r-- 1 M19521 1049089 2518 Jun 12 04:28  meva.cloudeng_com.txt
      ```

 - Rename the **meva.cloudeng_com.txt** to **meva.cloudeng_com.csr**, this file can be use for certificate_body in AWS ACM inport.
    - $ cd meva.cloudeng.com
    - $ mv meva.cloudeng_com.txt meva.cloudeng_com.cer
    - $ ls -l --> Last File
      ```hcl
      total 12
      -rw-r--r-- 1 M19521 1049089 1316 Jun 12 04:28 'DigiCert Global Root G2.txt'
      -rw-r--r-- 1 M19521 1049089 1904 Jun 12 04:28 'GeoTrust EV RSA CA G2.txt'
      -rw-r--r-- 1 M19521 1049089 2518 Jun 12 04:28  meva.cloudeng_com.cer
      ```

####  3.2.  Create certificate_chain file --> crt file
- Run the following command.
   - $ cd meva.cloudeng.com
   - $ ls -l 
     ```hcl
      total 12
      -rw-r--r-- 1 M19521 1049089 1316 Jun 12 04:28 'DigiCert Global Root G2.txt'
      -rw-r--r-- 1 M19521 1049089 1904 Jun 12 04:28 'GeoTrust EV RSA CA G2.txt'
      -rw-r--r-- 1 M19521 1049089 2518 Jun 12 04:28  meva.cloudeng_com.cer
      ```
   - $ cat 'DigiCert Global Root G2.txt' > meva.cloudeng_com.crt
   - $ cat 'GeoTrust EV RSA CA G2.txt' >> meva.cloudeng_com.crt
   - $ ls -l --> Last File
     ```hcl
     -rw-r--r-- 1 M19521 1049089 1316 Jun 12 04:28 'DigiCert Global Root G2.txt'
     -rw-r--r-- 1 M19521 1049089 1904 Jun 12 04:28 'GeoTrust EV RSA CA G2.txt'
     -rw-r--r-- 1 M19521 1049089 2518 Jun 12 04:28  meva.cloudeng_com.cer
     -rw-r--r-- 1 M19521 1049089 3220 Jun 12 18:58  meva.cloudeng_com.crt
     ```


####  3.3.  Import Private Key file and above 2 files into ACM
   - $ cd meva.cloudeng.com
   - mv ../Y_CSR_Files/Private_Key/meva.cloudeng_com.key .
   - $ ls -l --> Last 3 files requrie into ACM import
     ```hcl
     -rw-r--r-- 1 M19521 1049089 1316 Jun 12 04:28 'DigiCert Global Root G2.txt'
     -rw-r--r-- 1 M19521 1049089 1904 Jun 12 04:28 'GeoTrust EV RSA CA G2.txt'
     -rw-r--r-- 1 M19521 1049089 2518 Jun 12 04:28  meva.cloudeng_com.cer
     -rw-r--r-- 1 M19521 1049089 3220 Jun 12 18:58  meva.cloudeng_com.crt
     -rw-r--r-- 1 M19521 1049089 1704 Jun  9 15:39  meva.cloudeng_com.key
     ```

## 4.	Import into AWS ACMx
 - Terraform Script
   ```hcl
   module "meva.cloudeng_com" {
       source    = "terraform-aws-modules/acm/aws"
       name                = "meva.cloudeng.com"
       environment         = "prod"
       label_order         = ["name"]
       private_key         = "../meva.cloudeng.com/meva.cloudeng_com.key"
       certificate_body    = "../meva.cloudeng.com/meva.cloudeng_com.cer"
       certificate_chain   = "../meva.cloudeng.com/meva.cloudeng_com.crt"
       import_certificate  = true
       tags                = var.additional_tags
   }
   ```
   
   
 - Validation in ACM
 - Open Certificate Manager AWS Console --> List Certificates 
