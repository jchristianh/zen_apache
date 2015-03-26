#
# Cookbook Name:: apache_conf
# Recipe:: default
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


httpd_root      = node['apache_conf']['httpd']['root']
httpd_conf_root = node['apache_conf']['httpd']['conf_root']
httpd_site_root = node['apache_conf']['httpd']['sites']


# CREATE conf/ and conf/vhosts to hold configs
directory httpd_root do
  action :create
  owner  node['apache_conf']['alt_files_owner']
  group  node['apache_conf']['alt_files_group']
  mode   node['apache_conf']['alt_dirs_mode']
end

directory httpd_conf_root do
  action :create
  owner  node['apache_conf']['alt_files_owner']
  group  node['apache_conf']['alt_files_group']
  mode   node['apache_conf']['alt_dirs_mode']
end

directory httpd_site_root do
  action :create
  owner  node['apache_conf']['alt_files_owner']
  group  node['apache_conf']['alt_files_group']
  mode   node['apache_conf']['alt_dirs_mode']
end


# SYMLINK /www/sites to /virtual
link "/virtual" do
  to httpd_site_root
end


# WRITE CONFIGS AND START SERVICES
include_recipe "apache_conf::httpd_conf"
include_recipe "apache_conf::virtual_hosts"
include_recipe "apache_conf::php_ini"
include_recipe "apache_conf::services"
