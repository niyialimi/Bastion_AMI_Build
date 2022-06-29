provider "aws" {
 default_tags {
    tags = {
      Owner_Email = "neyonill@yahoo.com"
      Stack_Team  = "stackcloud8"
      Environment = "Dev"
      Backup      = "yes"
    }
  }

 assume_role {
    role_arn = "arn:aws:iam::743650199199:role/Engineer"
  
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws_source_ami" {
  default = "amzn2-ami-hvm-2.0.20210326.0-x86_64-gp2"
}

variable "aws_instance_type" {
  default = "t2.micro"
}

variable "ami_version" {
  default = "1.0.6"
}

variable "ami_name" {
  default = "ami-clixx-bastion-1.0"
}

variable "name" {
  type    = string
  default = ""
}

variable "component" {
  default = "clixx"
}

variable "aws_accounts" {
  type = list(string)
  #Create in management and share with Dev
  default= ["002995174237", "743650199199", "568779884891", "185940087895", "860574547207", "042974381947"]
}

variable "ami_regions" {
  type = list(string)
  default =["us-east-1"]
}

data "amazon-ami" "source_ami" {
  filters = {
    name = "${var.aws_source_ami}"
  }
  most_recent = true
  owners      = ["002995174237","amazon"]
  region      = "${var.aws_region}"
}

variable "aws_region" {
  default = "us-east-1"
}


# locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioners and post-processors on a
# source.


source "amazon-ebs" "amazon_ebs" {
  # assume_role {
  #   role_arn     = "arn:aws:iam::530958276242:role/Engineer"
  # }
  ami_name                = "${var.ami_name}"
  ami_regions             = "${var.ami_regions}"
  ami_users               = "${var.aws_accounts}"
  snapshot_users          = "${var.aws_accounts}"
  encrypt_boot            = false
  instance_type           = "${var.aws_instance_type}"
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    encrypted             = true  
    kms_key_id            = "64aa9346-0b94-400b-8d4d-faba41dc59df"
    volume_size           = 10
    volume_type           = "gp2"
  }
  region                  = "${var.aws_region}"
  source_ami              = "${data.amazon-ami.source_ami.id}"
  ssh_pty                 = true
  ssh_timeout             = "5m"
  ssh_username            = "ec2-user"
}


# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.amazon_ebs"]
  provisioner "shell" {
    script = "../scripts/setup.sh"
  }
}