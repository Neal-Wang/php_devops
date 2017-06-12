#
# Cookbook Name:: php_devops
# Recipe:: site
#
# Copyright (c) 2017 Sarah Ma, All Rights Reserved.

web_app "wordpress" do
  template "wordpress.conf.erb"
  docroot node['wordpress']['dir']
  server_name node['wordpress']['server_name']
  server_aliases node['wordpress']['server_aliases']
  server_port node['wordpress']['server_port']
  enable true
end