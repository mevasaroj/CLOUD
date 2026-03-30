################################################################################
# MAIN EBS DOCUMENT
################################################################################

##### MAIN FILE USED BY OUR MODULE. 
#### PLEASE REFER FOR MORE INFORMATION https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
#### PLEASE REFER FOR MORE INFORMATION https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment

resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.size
  snapshot_id       = var.snapshot_id
  type              = var.volume_type
  tags              = var.tags
  encrypted         = var.encrypted
  kms_key_id        = var.kms_key_id
  iops              = var.iops
  throughput        = var.throughput
}

resource "aws_volume_attachment" "this" {
  device_name = var.device_name
  volume_id   = aws_ebs_volume.this.id
  instance_id = var.instance_id
}
