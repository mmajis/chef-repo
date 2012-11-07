name "loadbalancer"
description "Load balancer role"
run_list(
	"recipe[testapp::loadbalancer]"
)
default_attributes(
	"chef_client" => {
		"interval" => "30",
		"splay" => "5"
	}
)
