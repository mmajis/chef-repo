name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[apt]",
  "recipe[chef-client]"
#  "recipe[build-essential]"
)
default_attributes(
  :ganglia => {
    :server_role => "ganglia_listener",
    :unicast => true,
    :cluster_name => "chefcluster",
    :mute => "no",
    :deaf => "no"
  },
  "chef_client" => {
		"interval" => "60",
		"splay" => "10"
  }
)