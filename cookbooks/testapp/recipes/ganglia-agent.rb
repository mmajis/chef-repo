#
# Cookbook Name:: testapp
# Recipe:: ganglia
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "testapp::ganglia-base"

#Ganglia attributes defined in role(s) or use defaults from recipe.
include_recipe "ganglia"

