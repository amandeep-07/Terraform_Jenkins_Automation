# ########################## PROVIDER ################################
# variable "region" {
#   description = "region name where create ec2 instance"
#   type        = string
# }

# variable "access_key" {
#   description = "Your access key to login in your aws account"
#   type        = string
# }

# variable "secret_key" {
#   description = "Your secret key to login in your aws account"
#   type        = string
# }

####################################################################
########################## BACKEND ################################
# variable "backend_key_name" {
#   description = "Your bucket name where you store tf state file"
#   type        = string
# }
####################################################################
########################## KEY PAIR ################################
variable "algorithm" {
  description = "Algorithm of your key (RSA or ED25519)"
  type        = string
}

variable "rsa_bits" {
  description = "rsa_bits of your key"
  type        = number
}

variable "key_name" {
  description = "Name of your key"
  type        = string
}

variable "key" {
  description = "key pair save in amazon s3"
  type        = string
}

variable "bucket_name" {
  description = "Your bucket name where you store key pair"
  type        = string
}

#############################################################################
#############################  SECURITY GROUP ###############################
variable "sg-name" {
  description = "Security group name"
  type        = string
}

# variable "cidr_blocks" {
#   description = "cidr block to allow the range of ip"
#   type        = string
# }

#############################################################################
#############################  EC2 INSTANCE  ################################
variable "instance_count" {
  description = "number of instance you launch"
  type        = number
}

variable "ami" {
  description = "ami of your instance"
  type        = string
}

variable "instance_type" {
  description = "instance type"
  type        = string
}

variable "tags" {
  description = "give a tag to your instance"
  type        = map(string)
}

variable "root_block_device" {
  description = "instance type"
  type        = number
}

############################################################################
############################# EBS VOLUME  ##################################
variable "ebs_volume_type" {
  description = "type of your ebs volume"
  type        = string
}

variable "ebs_volume_size" {
  description = "size of your ebs volume"
  type        = number
}

# variable "IOPS" {
#   description = "Number of IOPS"
#   type        = number
# }

variable "device_name" {
  description = "device name of your instance"
  type        = string
}

############################################################################