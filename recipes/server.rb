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
    'httpd', 'php56-php-pecl-igbinary', 'php56-php-pecl-memcache',
    'php56-php-pecl-imagick', 'php56-php-cli', 'php56-php-gd',
    'php56-php-process', 'php56-php-pear', 'php56-php-pecl-memcached',
    'php56-php-pdo', 'php56-php-xmlrpc', 'php56-php-snmp', 'php56-php-imap',
    'php56-php-common', 'php56-php-mysql', 'php56-php-xml',
    'php56-php-pecl-msgpack', 'php56-php-mcrypt', 'php56-php-pecl-geoip',
    'php56-php-mbstring', 'php56-php-pecl-redis', 'php56', 'mod_perl',
    'mod_ssl', 'iptables-services','mariadb','perl-XML-Parser'
]


# Install the required packages for each Apache based web node:
pkg_list.each do |pkg|
  package pkg do
    action :install
  end
end
