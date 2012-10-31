#
# Cookbook Name:: testapp
# Recipe:: testapp
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "testapp::jetty"

cookbook_file "/opt/jetty/webapps/testapp.war" do
  #source "testfile" # this is the value that would be inferred from the path parameter
  mode "0755"
  user "ubuntu"
  group "ubuntu"
end