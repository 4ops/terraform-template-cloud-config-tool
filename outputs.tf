output users {
  value       = indent(2, join("\n", data.template_file.user_array.*.rendered))
  description = "Part of the cloud-config in YAML format - just insert in your template `  $${module.myusers.users}` after `users:`"
}

output default_user {
  value       = local.users_count != 1 ? "" : indent(4, join("", data.template_file.user_objects.*.rendered))
  description = "Can be used on setup default user in cloud-config. Usage: `    $${module.myuser.default_user}` after `  default_user:`"
}
