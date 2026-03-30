################################################################################
# VARIABLES EBS DOCUMENT
################################################################################

##### VARIABLES FILE USED BY OUR MODULE. 
#### PLEASE REFER FOR MORE INFORMATION https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume
#### PLEASE REFER FOR MORE INFORMATION https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment

variable "availability_zone" {
  type = string
  description = "availablity zone for ebs volume to be created"
  default = ""
}

variable "size" {
  type = number
  description = "size for ebs volume to be created"
  default = null
}

variable "volume_type" {
  type = string
  description = "type standard/gp3/gp3/io1/io2/sc1/st1 for ebs volume to be created"
  default = "gp3"
}

variable "device_name" {
  type = string
  description = "device name /sdf /sdg etc.. for ebs volume to be created"
  default = ""
}

variable "instance_id" {
  type = string
  description = "instance id to ebs volume to be attached"
  default = ""
}

variable "encrypted" {
  type    = bool
  default = true
}

variable "tags" {
  description = "A mapping of tags to assign to the ebs volume createde"
  type        = map(string)
  default     = {}
}

variable "snapshot_id" {
  type = string
  description = "Snapshot id to be used to create an ebs volume"
  default = ""
}

variable "kms_key_id" {
  type = string
  description = "availablity zone for kms key to be encrypted"
  default = ""
}

variable "iops" {
  type = number
  description = "Amount of IOPS to provision for the disk"
  default = 3000
}

variable "throughput" {
  type = number
  description = "Throughput that the volume supports, in MiB/s"
  default = 125
}
