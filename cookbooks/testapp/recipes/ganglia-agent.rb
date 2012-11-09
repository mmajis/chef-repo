#
# Cookbook Name:: testapp
# Recipe:: ganglia
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#to use ganglia 3.4.0:
#- add ganglia rufustfirefly apt repo
#- run apt-get update
#- define attributes needed by ganglia recipe
#- include ganglia::ganglia recipe 



#TODO this ganglia recipe requires some attributes, set them!
#ganglia server host
#ganglia cluster name
#ganglia server role, see default ganglia cookbook recipe
include_recipe "ganglia::ganglia"

