#
# Cookbook Name:: testapp
# Recipe:: ganglia
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

#to use ganglia 3.4.0:
#- add ganglia rufustfirefly apt repo
#- run apt-get update
#- define attributes needed by ganglia recipe
#- include ganglia::ganglia recipe 

apt_repository "ganglia" do
  uri "http://ppa.launchpad.net/rufustfirefly/ganglia/ubuntu"
  distribution node[:lsb][:codename]
  components {"main"}
  keyserver "keyserver.ubuntu.com"
  key "A93EFBE2"
end

#Ganglia attributes defined in role(s) or use defaults from recipe.
include_recipe "ganglia::ganglia"

