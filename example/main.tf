terraform {
  required_version = ">= 0.12.1"

  required_providers {
    template = ">= 2.1"
  }
}

module this_user {
  source = "../"
  name   = "terramodule"

  users = [
    {
      name          = "terramodule",
      groups        = ["wheel"],
      ssh_import_id = ["terramodule", "gh:4ops"],
    },
  ]
}

module administrators {
  source = "../"
  name   = "administrators"

  users = [
    {
      name   = "alice",
      groups = ["users"],
      sudo   = ["ALL=(ALL) NOPASSWD:ALL"],
      gecos  = "Test user 1",

      ssh_authorized_keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+QB7lldYv3OPAlQk4RRLbnzLk5ZMSARd/vpiupw7Un"],
    },
    {
      name   = "bob",
      groups = ["wheel", "sudo", "adm"],
      sudo   = [],
      gecos  = "Test user 2",

      ssh_authorized_keys = [],
    },
  ]
}

data template_file cloud_config {
  template = <<-CLOUD_CONFIG
    #cloud-config
    users:
      - default
      ${module.administrators.users}
    system_info:
      default_user:
        ${module.this_user.default_user}
    package_upgrade: true
    runcmd:
      - userdel -fr ec2-user
  CLOUD_CONFIG
}
