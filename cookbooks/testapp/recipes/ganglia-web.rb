#
# Cookbook Name:: testapp
# Recipe:: ganglia-web
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

#install ganglia-web from tar.gz
case node[:platform]
when "ubuntu"
	package "apache2"
	package "php5"
	gangliaWebDir = "/opt/ganglia-web"
when "redhat", "centos", "fedora"
	package "httpd"
	package "php"
	gangliaWebDir = "/var/www/html/ganglia"
end

package "rrdtool"

remote_file "/tmp/ganglia-web-3.5.4.tar.gz" do
  source "http://sourceforge.net/projects/ganglia/files/ganglia-web/3.5.4/ganglia-web-3.5.4.tar.gz/download"
  mode "0644"
  checksum "a6e84622f89617da4d2236d8cc6adb1aee00bebf04c34fe46bd032a2d3e3354c"
  not_if "test -d #{gangliaWebDir}"
  notifies :run, "execute[unpack-ganglia-web]", :immediately
end

execute "unpack-ganglia-web" do
	command "tar zxf /tmp/ganglia-web-3.5.4.tar.gz"
	action :nothing
	cwd "/tmp"
	notifies :create, "cookbook_file[/tmp/ganglia-web-3.5.4/Makefile]", :immediately
	notifies :run, "execute[install-ganglia-web]", :immediately
end

#Copy platform specific makefile from cookbook
cookbook_file "/tmp/ganglia-web-3.5.4/Makefile" do
	action :nothing
end

execute "install-ganglia-web" do
	command "make install"
	action :nothing
	cwd "/tmp/ganglia-web-3.5.4"
end

cookbook_file "/opt/ganglia-web/graph.d/nginx_accepts_ratio_report.php" do
  owner "ubuntu"
  group "ubuntu"
  mode 0644
end
cookbook_file "/opt/ganglia-web/graph.d/nginx_scoreboard_report.php" do
	owner "ubuntu"
	group "ubuntu"
  	mode 0644
end

case node[:platform]
when "ubuntu"
	cookbook_file "#{gangliaWebDir}/apache.conf"
	link "/etc/apache2/sites-enabled/ganglia" do
    	to "#{gangliaWebDir}/apache.conf"
    	notifies :restart, "service[apache2]"
  	end
when "redhat", "centos", "fedora"
	#nothing to do?
end

service "apache2" do
  service_name "httpd" if platform?( "redhat", "centos", "fedora" )
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end