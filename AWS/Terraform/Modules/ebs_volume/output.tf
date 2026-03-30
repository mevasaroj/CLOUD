################################################################################
# OUTPUTS EBS DOCUMENT
################################################################################

##### OUTPUTS FILE USED BY OUR MODULE. 
#### PLEASE REFER FOR MORE INFORMATION https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
#### PLEASE REFER FOR MORE INFORMATION https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment

output "aws_ebs_volume" {
  value = aws_ebs_volume.this.id
}

output "aws_volume_attachment" {
  value = aws_volume_attachment.this.id
}
