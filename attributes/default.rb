#
# Cookbook Name:: php_devops
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

default['wordpress']['version'] = 'latest'

default['wordpress']['db']['root_password'] = 'my_root_password'
default['wordpress']['db']['instance_name'] = 'default'
default['wordpress']['db']['name'] = "wordpressdb"
default['wordpress']['db']['user'] = "wordpressuser"
default['wordpress']['db']['pass'] = '123456'
default['wordpress']['db']['prefix'] = 'wp_'
default['wordpress']['db']['host'] = 'localhost'
default['wordpress']['db']['port'] = '3306'  # Must be a string
default['wordpress']['db']['charset'] = 'utf8'
default['wordpress']['db']['collate'] = ''
case node['platform']
when 'ubuntu'
  case node['platform_version']
  when '10.04'
    default['wordpress']['db']['mysql_version'] = '5.1'
  else
    default['wordpress']['db']['mysql_version'] = '5.5'
  end
when 'centos', 'redhat', 'amazon', 'scientific'
  if node['platform_version'].to_i < 6
    default['wordpress']['db']['mysql_version'] = '5.0'
  elsif node['platform_version'].to_i < 7
    default['wordpress']['db']['mysql_version'] = '5.1'
  else
    default['wordpress']['db']['mysql_version'] = '5.5'
  end
else
  default['wordpress']['db']['mysql_version'] = '5.5'
end

default['wordpress']['allow_multisite'] = false

default['wordpress']['wp_config_options'] = {}

default['wordpress']['config_perms'] = 0644
default['wordpress']['server_aliases'] = [node['fqdn']]
default['wordpress']['server_port'] = '80'

default['wordpress']['install']['user'] = node['apache']['user']
default['wordpress']['install']['group'] = node['apache']['group']

# Languages
default['wordpress']['languages']['lang'] = ''
default['wordpress']['languages']['version'] = ''
default['wordpress']['languages']['repourl'] = 'http://translate.wordpress.org/projects/wp'
default['wordpress']['languages']['projects'] = ['main', 'admin', 'admin_network', 'continents_cities']
default['wordpress']['languages']['themes'] = []
default['wordpress']['languages']['project_pathes'] = {
  'main'              => '/',
  'admin'             => '/admin/',
  'admin_network'     => '/admin/network/',
  'continents_cities' => '/cc/'
}
%w{ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty}.each do |year|
  default['wordpress']['languages']['project_pathes']["twenty#{year}"] = "/twenty#{year}/"
end
node['wordpress']['languages']['project_pathes'].each do |project,project_path|
  # http://translate.wordpress.org/projects/wp/3.5.x/admin/network/ja/default/export-translations?format=mo
  default['wordpress']['languages']['urls'][project] =
    node['wordpress']['languages']['repourl'] + '/' +
    node['wordpress']['languages']['version'] + project_path +
    node['wordpress']['languages']['lang'] + '/default/export-translations?format=mo'
end

default['wordpress']['server_name'] = node['fqdn']
default['wordpress']['parent_dir'] = '/var/www'
default['wordpress']['dir'] = "#{node['wordpress']['parent_dir']}/wordpress"
default['wordpress']['url'] = "https://wordpress.org/wordpress-#{node['wordpress']['version']}.tar.gz"

default['wordpress']['php_options'] = { 'php_admin_value[upload_max_filesize]' => '50M', 'php_admin_value[post_max_size]' => '55M' }
