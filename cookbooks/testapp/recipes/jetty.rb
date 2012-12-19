#
# Cookbook Name:: testapp
# Recipe:: jetty
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node["java"]["jdk_version"] = "7"
include_recipe "java"

#Could use the ark cookbook to download/extract jetty...?

remote_file "/tmp/jetty-distribution-8.1.7.v20120910.tar.gz" do
  source "https://dl.dropbox.com/u/1279329/thesis/soawar/jetty-distribution-8.1.7.v20120910.tar.gz"
  mode "0755"
  checksum "a65d20367839bf3df7d32a05992678487ba8daeebb41d9833975aee46ffe86c2"
  not_if "test -d /opt/jetty"
end

execute "tar zxf /tmp/jetty-distribution-8.1.7.v20120910.tar.gz" do
  creates "/opt/jetty"
  action :run
  cwd "/opt"
end

execute "mv /opt/jetty-distribution-8.1.7.v20120910 /opt/jetty" do
	creates "/opt/jetty"
	action :run
end

cookbook_file "/opt/jetty/lib/ext/metrics-annotation-3.0.0-SNAPSHOT.jar" do
end
cookbook_file "/opt/jetty/lib/ext/metrics-core-3.0.0-SNAPSHOT.jar" do
end
cookbook_file "/opt/jetty/lib/ext/metrics-jetty-3.0.0-SNAPSHOT.jar" do
end
cookbook_file "/opt/jetty/lib/ext/metrics-ganglia-3.0.0-SNAPSHOT.jar" do
end
cookbook_file "/opt/jetty/lib/ext/slf4j-api-1.6.6.jar" do
end

execute "jetty-restart" do
  command "./bin/jetty.sh restart"
  action :nothing
  cwd "/opt/jetty"
end

template "/opt/jetty/etc/jetty.xml" do
  source "jetty-xml.erb"
  mode 0440
  variables(
    :ganglia_listener_node => search(:node, 'role:ganglia_listener')[0],
    :ganglia_listener_port => "8649",
    :ganglia_reporting_interval => "10"
  )
  notifies :run, resources(:execute => "jetty-restart"), :delayed
end

execute "./bin/jetty.sh start" do
  action :run
  cwd "/opt/jetty"
  creates "/var/run/jetty.pid"
  #environment ({'HOME' => '/home/myhome'})
end
