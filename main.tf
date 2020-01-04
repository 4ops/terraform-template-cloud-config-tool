terraform {
  required_version = ">= 0.12.17"

  required_providers {
    template = ">= 2.1.2"
  }
}

locals {
  templates   = "${path.module}/templates"
  users_count = length(var.users)

  empty = {
    lock_passwd         = true
    inactive            = null
    system              = null
    snapuser            = null
    groups              = []
    shell               = "/bin/bash"
    homedir             = null
    sudo                = []
    gecos               = null
    selinux_user        = null
    passwd              = null
    ssh_redirect_user   = null
    ssh_import_id       = []
    ssh_authorized_keys = []
  }
}

data template_file user_objects {
  count    = local.users_count
  template = templatefile("${local.templates}/user.yaml", merge(local.empty, var.users[count.index]))
}

data template_file user_array {
  count    = local.users_count
  template = "- ${indent(2, element(data.template_file.user_objects.*.rendered, count.index))}"
}
