#
# Cookbook Name:: testapp
# Recipe:: jetty
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"

#Could use the ark cookbook to download/extract jetty...

cookbook_file "/tmp/jetty-distribution-8.1.7.v20120910.tar.gz" do
  #source "testfile" # this is the value that would be inferred from the path parameter
  mode "0755"
end

execute "tar zxvf /tmp/jetty-distribution-8.1.7.v20120910.tar.gz" do
  creates "/opt/jetty"
  action :run
  cwd "/opt"
end

execute "mv /opt/jetty-distribution-8.1.7.v20120910 /opt/jetty" do
	creates "/opt/jetty"
	action :run
end

execute "./bin/jetty.sh start" do
  action :run
  cwd "/opt/jetty"
  #environment ({'HOME' => '/home/myhome'})
end

