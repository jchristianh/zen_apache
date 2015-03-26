#
# Cookbook Name:: zen_apache
# Attributes:: default
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


# GENERAL
default['zen_apache']['alt_files_owner'] = "chris"
default['zen_apache']['alt_files_group'] = "chris"
default['zen_apache']['alt_files_mode']  = "0644"
default['zen_apache']['alt_dirs_mode']   = "0755"


# HTTPD:
default['zen_apache']['httpd']['listen_port']    = "80"
default['zen_apache']['httpd']['root']           = "/www"
default['zen_apache']['httpd']['conf_root']      = node['zen_apache']['httpd']['root'] + "/conf"
default['zen_apache']['httpd']['vhosts']         = node['zen_apache']['httpd']['conf_root'] + "/vhosts"
default['zen_apache']['httpd']['sites']          = node['zen_apache']['httpd']['root'] + "/sites"
default['zen_apache']['httpd']['httpd_conf']     = "httpd.conf"
default['zen_apache']['httpd']['default_conf']   = "/etc/httpd/conf/httpd.conf"
default['zen_apache']['httpd']['vhost_data_bag'] = "virtual_hosts"


# PHP:
default['zen_apache']['php']['php_ini']     = node['zen_apache']['httpd']['conf_root'] + "/php.ini"
default['zen_apache']['php']['default_ini'] = "/etc/php.ini"

default['zen_apache']['php']['mem_limit']         = 128
default['zen_apache']['php']['post_max']          = 256
default['zen_apache']['php']['upld_max']          = 200
default['zen_apache']['php']['timezone']          = "America/New_York"
default['zen_apache']['php']['mysql_persistance'] = "On"
default['zen_apache']['php']['sess_handler']      = "files"
default['zen_apache']['php']['sess_path']         = node['zen_apache']['httpd']['root'] + "/cache"
default['zen_apache']['php']['geoip_dir']         = "/www/sites/resources.thezengarden.net/htdocs/analytics/misc"
