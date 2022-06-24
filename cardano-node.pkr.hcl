packer {
  required_plugins {
    # https://github.com/hashicorp/packer-plugin-amazon
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

data "amazon-ami" "ubuntu" {
  filters = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = "us-east-1"
}

locals {
  hk_year_month_day = formatdate("YYYYMMDD", timeadd(timestamp(), "8h"))
}

source "amazon-ebs" "cardano-node" {
  ami_groups            = ["all"]
  ami_name              = "whslabs-cardano-node-${local.hk_year_month_day}"
  communicator          = "ssh"
  force_delete_snapshot = true
  force_deregister      = true
  instance_type         = "t2.large"
  region                = "us-east-1"
  source_ami            = data.amazon-ami.ubuntu.id
  ssh_username          = "ubuntu"
  aws_polling {
    delay_seconds = 60
    max_attempts  = 60
  }
  launch_block_device_mappings {
    device_name           = "/dev/sda1"
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }
}

build {
  sources = ["source.amazon-ebs.cardano-node"]

  provisioner "ansible" {
    playbook_file = "ansible/playbook.yaml"
  }
}
