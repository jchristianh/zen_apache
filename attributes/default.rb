#
# Cookbook Name:: apache_conf
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
default['apache_conf']['alt_files_owner'] = "chris"
default['apache_conf']['alt_files_group'] = "chris"
default['apache_conf']['alt_files_mode']  = "0644"
default['apache_conf']['alt_dirs_mode']   = "0755"


# HTTPD:
default['apache_conf']['httpd']['listen_port']    = "80"
default['apache_conf']['httpd']['root']           = "/www"
default['apache_conf']['httpd']['conf_root']      = node['apache_conf']['httpd']['root'] + "/conf"
default['apache_conf']['httpd']['vhosts']         = node['apache_conf']['httpd']['conf_root'] + "/vhosts"
default['apache_conf']['httpd']['sites']          = node['apache_conf']['httpd']['root'] + "/sites"
default['apache_conf']['httpd']['httpd_conf']     = "httpd.conf"
default['apache_conf']['httpd']['default_conf']   = "/etc/httpd/conf/httpd.conf"
default['apache_conf']['httpd']['vhost_data_bag'] = "virtual_hosts"


# PHP:
default['apache_conf']['php']['php_ini']     = node['apache_conf']['httpd']['conf_root'] + "/php.ini"
default['apache_conf']['php']['default_ini'] = "/etc/php.ini"

default['apache_conf']['php']['mem_limit']         = 128
default['apache_conf']['php']['post_max']          = 256
default['apache_conf']['php']['upld_max']          = 200
default['apache_conf']['php']['timezone']          = "America/New_York"
default['apache_conf']['php']['mysql_persistance'] = "On"
default['apache_conf']['php']['sess_handler']      = "files"
default['apache_conf']['php']['sess_path']         = node['apache_conf']['httpd']['root'] + "/cache"
default['apache_conf']['php']['geoip_dir']         = "/www/sites/resources.thezengarden.net/htdocs/analytics/misc"
