#
# Cookbook Name:: zen_apache
# Attributes:: php
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


# PHP OPTIONS
default['zen_apache']['php']['php_ini']           = node['zen_apache']['httpd']['conf_root'] + "/php.ini"
default['zen_apache']['php']['default_ini']       = "/etc/php.ini"

default['zen_apache']['php']['max_exec_time']     = 300
default['zen_apache']['php']['max_input_time']    = 300
default['zen_apache']['php']['display_errors']    = "On"
default['zen_apache']['php']['allow_fopen']       = "On"
default['zen_apache']['php']['allow_url_inc']     = "Off"
default['zen_apache']['php']['sess_use_cookies']  = 1
default['zen_apache']['php']['sess_cookie_life']  = 0
default['zen_apache']['php']['mem_limit']         = 128
default['zen_apache']['php']['post_max']          = 256
default['zen_apache']['php']['upld_max']          = 200
default['zen_apache']['php']['timezone']          = "America/New_York"
default['zen_apache']['php']['mysql_persistance'] = "On"
default['zen_apache']['php']['sess_handler']      = "files"
default['zen_apache']['php']['sess_path']         = "/tmp"
default['zen_apache']['php']['geoip_dir']         = "/www/sites/resources.thezengarden.net/htdocs/analytics/misc"
