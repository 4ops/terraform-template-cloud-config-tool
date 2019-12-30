# Cloud config tool

Simple template tool for creating [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html) with [Terraform](https://www.terraform.io/)

Terraform registry [module](https://registry.terraform.io/modules/4ops/cloud-config-tool/template/1.0.0)

## Usage example

Setup modules in `main.tf`:

```terraform
module this_user {
  source  = 4ops/cloud-config-tool/template
  version = 1.0.0

  users  = local.user
}

module administrators {
  source  = 4ops/cloud-config-tool/template
  version = 1.0.0

  users = var.administrators
}
```

Template content:

```yaml
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
```

Rendered template:

```yaml
#cloud-config
users:
  - default
  - name: alice
    shell: /bin/bash
    lock_passwd: true
    gecos: Test user 1
    groups: [users]
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    home: /home/alice
    ssh_authorized_keys:
      - ssh-ed25519 AAAA...
  - name: bob
    shell: /bin/bash
    lock_passwd: true
    gecos: Test user 2
    groups: [wheel, sudo, adm]
    home: /home/bob
system_info:
  default_user:
    name: terramodule
    shell: /bin/bash
    lock_passwd: true
    groups: [wheel]
    home: /home/terramodule
    ssh_import_id: terramodule
package_upgrade: true
runcmd:
  - userdel -fr ec2-user
```

Also, see [example](/example) directory.
