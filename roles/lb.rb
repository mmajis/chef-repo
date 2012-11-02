name "loadbalancer"
description "Load balancer role"
run_list(
	"recipe[testapp::loadbalancer]"
)
default_attributes(
	"nginx" => { 
		"log_format" => [ 
			{
			"name" => "upstream_info",
			"format" => "'$remote_addr - $remote_user [$time_local]  $request '
  						 'upstream_response_time $upstream_response_time '
  						 'msec $msec request_time $request_time $upstream_addr'" 
  			},
  			{
			"name" => "timed_combined",
			"format" => "'$remote_addr - $remote_user [$time_local]  '
                    '\"$request\" $status $body_bytes_sent '
                    '\"$http_referer\" \"$http_user_agent\" $request_time'"
  			} 
		]
	}
)
