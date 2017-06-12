#
# Cookbook Name:: php_devops
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

include_recipe 'php_devops::web_server'
include_recipe 'php_devops::database'
include_recipe 'php_devops::wp'
include_recipe 'php_devops::site'