name 'php_devops'
maintainer 'Sarah Ma'
maintainer_email 'mance2012@gmail.com'
license 'all_rights'
description 'Installs/Configures php_devops'
long_description 'Installs/Configures php_devops'
version '1.2.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/php_devops/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/php_devops' if respond_to?(:source_url)

depends 'php', '~> 4.2.0'
depends 'php-fpm', '~> 0.7.9'
depends 'database', '~> 6.1.1'
depends 'mysql', '~> 8.4.0'
depends 'apache2', '~> 3.3.0'
depends "tar", ">= 0.3.1"
depends 'selinux', '~> 0.7'
depends 'mysql2_chef_gem', '~> 2.0.1'