#
# Cookbook Name:: zen_apache
# Recipe:: php_ini
#
# Copyright (C) 2015 Chris Hammer <chris@thezengarden.net>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/gpl-2.0.txt>.


conf_root       = node['zen_apache']['httpd']['conf_root']
zg_php_ini      = node['zen_apache']['php']['php_ini']
default_php_ini = node['zen_apache']['php']['default_ini']


template "#{conf_root}/php.ini" do
  source 'php.ini.erb'
  owner  node['zen_apache']['alt_files_owner']
  group  node['zen_apache']['alt_files_group']
  mode   node['zen_apache']['alt_files_mode']

  variables ({
    :php_memory_limit      => node['zen_apache']['php']['mem_limit'],
    :php_post_max_size     => node['zen_apache']['php']['post_max'],
    :php_upload_max        => node['zen_apache']['php']['upld_max'],
    :php_timezone          => node['zen_apache']['php']['timezone'],
    :php_mysql_persistance => node['zen_apache']['php']['mysql_persistance'],
    :php_session_handler   => node['zen_apache']['php']['sess_handler'],
    :php_session_path      => node['zen_apache']['php']['sess_path'],
    :geoip_directory       => node['zen_apache']['php']['geoip_dir']
  })

  notifies :restart, "service[httpd]", :delayed
end


execute "Backing up default php.ini" do
  command "mv #{default_php_ini} #{default_php_ini}.dist"
  not_if { File.exists?("#{default_php_ini}.dist") }
end


# Symlink php.ini to NFS version:
link default_php_ini do
  to zg_php_ini
  only_if { File.exists?("#{default_php_ini}.dist") }
end
