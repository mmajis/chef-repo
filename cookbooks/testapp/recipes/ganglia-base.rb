#
# Cookbook Name:: testapp
# Recipe:: ganglia-base
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

case node[:platform]
when "ubuntu"
	apt_repository "ganglia" do
	  uri "http://ppa.launchpad.net/rufustfirefly/ganglia/ubuntu/"
	  distribution node[:lsb][:codename]
	  components ["main"]
	  keyserver "keyserver.ubuntu.com"
	  key "A93EFBE2"
	  deb_src true
	end
end
	
directory "/etc/ganglia/conf.d" do
	mode 0755
	recursive true
end

directory "/usr/lib/ganglia/python_modules" do
	mode 0755
	recursive true
end

cookbook_file "/etc/ganglia/conf.d/modpython.conf" do
	mode 0444
end	