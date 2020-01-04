variable name {
  type    = string
  default = "cloud-config-helper"
}

variable users {
  type = list

  # name                 string         *required
  # lock_passwd          bool           true
  # inactive             bool           false
  # system               bool           false
  # snapuser             string         null
  # groups               list(string)   []
  # shell                string         /bin/bash
  # homedir              string         /home/<username>
  # sudo                 list(string)   []
  # gecos                string         null
  # selinux_user         string         null
  # passwd               string         null
  # ssh_redirect_user    bool           false
  # ssh_import_id        list(string)   []
  # ssh_authorized_keys  list(string)   []

  default = [
    # {
    #   name    = "alice",
    #   groups  = ["wheel"],
    #   public_keys = ["ssh-ed25519 AAAAC3N...................iupw7Un"],
    # },
  ]

  description = "A list of the users to create with cloud-config"
}
