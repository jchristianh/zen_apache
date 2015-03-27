#
# Cookbook Name:: zen_apache
# Attributes:: httpd
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


# HTTPD OPTIONS
default['zen_apache']['httpd']['listen_port']    = "80"
default['zen_apache']['httpd']['root']           = "/www"
default['zen_apache']['httpd']['conf_root']      = node['zen_apache']['httpd']['root'] + "/conf"
default['zen_apache']['httpd']['vhosts']         = node['zen_apache']['httpd']['conf_root'] + "/vhosts"
default['zen_apache']['httpd']['sites']          = node['zen_apache']['httpd']['root'] + "/sites"
default['zen_apache']['httpd']['httpd_conf']     = "httpd.conf"
default['zen_apache']['httpd']['default_conf']   = "/etc/httpd/conf/httpd.conf"
default['zen_apache']['httpd']['vhost_data_bag'] = "virtual_hosts"
