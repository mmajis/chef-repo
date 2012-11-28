#
# Cookbook Name:: testapp
# Recipe:: loadbalancer
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.default['nginx']['log_format'] = 
	[ 
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

include_recipe "nginx"

template "/etc/nginx/sites-available/default" do
  source "nginx-sites-available-default.erb"
  mode 0440
  owner "root"
  group "root"
  variables({
    :appservers => search(:node, "role:testapp AND chef_environment:#{node.chef_environment}")
  })
end

# Do nothing by default with this service. Subscribe to changes of the site 
# specification template above.
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action :nothing
  subscribes :reload, resources(:template => "/etc/nginx/sites-available/default")
end

