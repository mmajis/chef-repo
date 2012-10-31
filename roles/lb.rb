name "loadbalancer"
description "Load balancer role"
run_list(
  "recipe[nginx]"
)
