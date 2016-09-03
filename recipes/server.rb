#
# Cookbook Name:: zen_apache
# Recipe:: server
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


# Install remi-release to such in php56/php7
cookbook_file "#{node['rhel_base']['tmp']}/remi-release-7.rpm" do
  source 'remi-release-7.rpm'
  mode   '0644'
  not_if "rpm -qa | grep 'remi-release'"
end

package "remi-release-7" do
  source "#{node['rhel_base']['tmp']}/remi-release-7.rpm"
  provider Chef::Provider::Package::Rpm
  action :install
  not_if "rpm -qa | grep 'remi-release'"
end

execute "removing-remi-release-7.rpm" do
  command "rm -f #{node['rhel_base']['tmp']}/remi-release-7.rpm"
  only_if { File.exist?("#{node['rhel_base']['tmp']}/remi-release-7.rpm") }
end


pkg_list = [
    'httpd', 'php-pecl-igbinary', 'php-pecl-memcache',
    'php-pecl-imagick', 'php-cli', 'php-gd',
    'php-process', 'php-pear', 'php-pecl-memcached',
    'php-pdo', 'php-xmlrpc', 'php-snmp', 'php-imap',
    'php-common', 'php-mysql', 'php-xml',
    'php-pecl-msgpack', 'php-mcrypt', 'php-pecl-geoip',
    'php-mbstring', 'php-pecl-redis', 'php', 'mod_perl',
    'mod_ssl', 'iptables-services','mariadb','perl-XML-Parser'
]


# Install the required packages for each Apache based web node:
pkg_list.each do |pkg|
  package pkg do
    action :install
  end
end
