#
# Cookbook Name:: php_devops
# Recipe:: database
#
# Copyright (c) 2017 Sarah Ma, All Rights Reserved.

::Chef::Recipe.send(:include, Wordpress::Helpers)

mysql_client 'default' do
  action :create
end

mysql2_chef_gem 'default' do
  action :install
end

node.set_unless['wordpress']['db']['pass'] = '111111'
node.save

db = node['wordpress']['db']

if is_local_host? db['host']

  # The following is required for the mysql community cookbook to work properly
  include_recipe 'selinux::disabled' if node['platform_family'] == 'rhel'

  mysql_service db['instance_name'] do
    port db['port']
    version db['mysql_version']
    initial_root_password db['root_password']
    action [:create, :start]
  end

  socket = "/var/run/mysql-#{db['instance_name']}/mysqld.sock"

  if node['platform_family'] == 'debian'
    link '/var/run/mysqld/mysqld.sock' do
      to socket
      not_if 'test -f /var/run/mysqld/mysqld.sock'
    end
  elsif node['platform_family'] == 'rhel'
    link '/var/lib/mysql/mysql.sock' do
      to socket
      not_if 'test -f /var/lib/mysql/mysql.sock'
    end
  end

  mysql_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :socket   => socket,
    :password => db['root_password']
  }

  mysql_database db['name'] do
    connection  mysql_connection_info
    action      :create
  end

  mysql_database_user db['user'] do
    connection    mysql_connection_info
    password      db['pass']
    host          db['host']
    database_name db['name']
    action        :create
  end

  mysql_database_user db['user'] do
    connection    mysql_connection_info
    database_name db['name']
    privileges    [:all]
    action        :grant
  end

end
