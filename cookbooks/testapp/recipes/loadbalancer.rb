#
# Cookbook Name:: testapp
# Recipe:: loadbalancer
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

template "/etc/nginx/sites-available/default" do
  source "nginx-sites-available-default.erb"
  mode 0440
  owner "root"
  group "root"
  variables({
    :appservers => search(:node, 'role:loadbalancer'),
  })
end
