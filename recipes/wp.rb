#
# Cookbook Name:: php_devops
# Recipe:: wp
#
# Copyright (c) 2017 Sarah Ma, All Rights Reserved.

default_password = '123456'

node.set_unless['wordpress']['keys']['auth'] = default_password
node.set_unless['wordpress']['keys']['secure_auth'] = default_password
node.set_unless['wordpress']['keys']['logged_in'] = default_password
node.set_unless['wordpress']['keys']['nonce'] = default_password
node.set_unless['wordpress']['salt']['auth'] = default_password
node.set_unless['wordpress']['salt']['secure_auth'] = default_password
node.set_unless['wordpress']['salt']['logged_in'] = default_password
node.set_unless['wordpress']['salt']['nonce'] = default_password
node.save

directory node['wordpress']['dir'] do
  action :create
  recursive true
  owner node['wordpress']['install']['user']
  group node['wordpress']['install']['group']
  mode  '00755'
end

archive = 'wordpress.tar.gz'

tar_extract node['wordpress']['url'] do
  target_dir node['wordpress']['dir']
  creates File.join(node['wordpress']['dir'], 'index.php')
  user node['wordpress']['install']['user']
  group node['wordpress']['install']['group']
  tar_flags [ '--strip-components 1' ]
  not_if { ::File.exists?("#{node['wordpress']['dir']}/index.php") }
end

template "#{node['wordpress']['dir']}/wp-config.php" do
  source 'wp-config.php.erb'
  mode node['wordpress']['config_perms']
  variables(
    :db_name           => node['wordpress']['db']['name'],
    :db_user           => node['wordpress']['db']['user'],
    :db_password       => node['wordpress']['db']['pass'],
    :db_host           => node['wordpress']['db']['host'],
    :db_prefix         => node['wordpress']['db']['prefix'],
    :db_charset        => node['wordpress']['db']['charset'],
    :db_collate        => node['wordpress']['db']['collate'],
    :auth_key          => node['wordpress']['keys']['auth'],
    :secure_auth_key   => node['wordpress']['keys']['secure_auth'],
    :logged_in_key     => node['wordpress']['keys']['logged_in'],
    :nonce_key         => node['wordpress']['keys']['nonce'],
    :auth_salt         => node['wordpress']['salt']['auth'],
    :secure_auth_salt  => node['wordpress']['salt']['secure_auth'],
    :logged_in_salt    => node['wordpress']['salt']['logged_in'],
    :nonce_salt        => node['wordpress']['salt']['nonce'],
    :lang              => node['wordpress']['languages']['lang'],
    :allow_multisite   => node['wordpress']['allow_multisite'],
    :wp_config_options => node['wordpress']['wp_config_options']
  )
  owner node['wordpress']['install']['user']
  group node['wordpress']['install']['group']
  action :create
end
