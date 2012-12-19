#
# Cookbook Name:: testapp
# Recipe:: testapp
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "testapp::jetty"

remote_file "/opt/jetty/webapps/testapp.war" do
  source "https://dl.dropbox.com/u/1279329/thesis/soawar/testapp-20121219.war"
  mode "0755"
  checksum "3163de36a833507cb55eda85bc4090347a7b77ea428a9e21c4805d3189d4f603"
  user "ubuntu"
  group "ubuntu"
end