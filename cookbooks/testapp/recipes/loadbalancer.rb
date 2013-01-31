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

template "/etc/nginx/sites-available/status" do
  source "nginx-sites-available-status.erb"
  mode 0440
  owner "root"
  group "root"
end

link "/etc/nginx/sites-enabled/status" do
  to "/etc/nginx/sites-available/status"
end

# Do nothing by default with this service. Subscribe to changes of the site 
# specification template above.
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action :nothing
  subscribes :reload, resources(:template => "/etc/nginx/sites-available/default", 
                                :template => "/etc/nginx/sites-available/status")
end

include_recipe "testapp::ganglia-agent"

cookbook_file "/usr/lib/ganglia/python_modules/nginx_status.py" do
  mode 0444
end

template "/etc/ganglia/conf.d/nginx_status.pyconf" do
  source "nginx_status.pyconf.erb"
  mode 0444
  variables(
    :nginx_node => search(:node, 'role:loadbalancer').map {|node| node.ipaddress}[0],
    :nginx_status_port => "8080"
  )
  notifies :restart, "service[ganglia-monitor]", :delayed
end

service "ganglia-monitor" do
  pattern "gmond"
  supports :restart => true
  action :nothing
end

