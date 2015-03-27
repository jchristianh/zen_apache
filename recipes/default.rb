#
# Cookbook Name:: zen_apache
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


# If we're not running off a Chef Server,
# we will fail the run:
CheckSolo.check_solo?


# CREATE conf/ and conf/vhosts to hold configs
directory node['zen_apache']['httpd']['root'] do
  action :create
  owner  node['zen_apache']['alt_files_owner']
  group  node['zen_apache']['alt_files_group']
  mode   node['zen_apache']['alt_dirs_mode']
end

directory node['zen_apache']['httpd']['conf_root'] do
  action :create
  owner  node['zen_apache']['alt_files_owner']
  group  node['zen_apache']['alt_files_group']
  mode   node['zen_apache']['alt_dirs_mode']
end

directory node['zen_apache']['httpd']['sites'] do
  action :create
  owner  node['zen_apache']['alt_files_owner']
  group  node['zen_apache']['alt_files_group']
  mode   node['zen_apache']['alt_dirs_mode']
end

directory node['zen_apache']['php']['sess_path'] do
  action :create
end


# Symlink site root if desired
link node['zen_apache']['sites_symlink_target'] do
  to node['zen_apache']['httpd']['sites']
  only_if { node['zen_apache']['do_sites_symlink'] }
end


# WRITE CONFIGS AND START SERVICES
include_recipe "zen_apache::httpd_conf"
include_recipe "zen_apache::virtual_hosts"
include_recipe "zen_apache::php_ini"
include_recipe "zen_apache::services"
