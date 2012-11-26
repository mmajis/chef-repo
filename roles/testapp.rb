name "testapp"
description "Test application server role"
run_list(
  "recipe[apt]",
  "recipe[chef-client]",
  "recipe[testapp]",
  "recipe[testapp::ganglia-agent]"
)
