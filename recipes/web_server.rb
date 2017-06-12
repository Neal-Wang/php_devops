#
# Cookbook Name:: php_devops
# Recipe:: web_server
#
# Copyright (c) 2017 Sarah Ma, All Rights Reserved.

include_recipe "php"
include_recipe "php::module_mysql"

include_recipe "apache2"
include_recipe "apache2::mod_php5"