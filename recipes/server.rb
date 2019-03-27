#
# Cookbook Name:: zen_apache
# Recipe:: server
#
# Copyright (C) 2019 Chris Hammer <chris@thezengarden.net>
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


# if node should be running php7, lets install/enable it:
if node['apache_conf']['php']['use_ver_7']
  # Install remi-release to suck in php56/php7
  cookbook_file "#{node['rhel_base']['tmp']}/remi-release-7.rpm" do
    source 'remi-release-7.rpm'
    mode   '0644'
    not_if "rpm -qa | grep 'remi-release'"
  end

  rpm_package "remi-release-7" do
    source "#{node['rhel_base']['tmp']}/remi-release-7.rpm"
    action :install
    not_if "rpm -qa | grep 'remi-release'"
  end

  execute "removing-remi-release-7.rpm" do
    command "rm -f #{node['rhel_base']['tmp']}/remi-release-7.rpm"
    only_if { File.exist?("#{node['rhel_base']['tmp']}/remi-release-7.rpm") }
  end


#################################################################
# We need to decide which dot release of 7 to deploy:           #
#################################################################

  if node['apache_conf']['php']['7_ver']
  
    seven_ver = [
      'php54',
      'php70',
      'php71',
      'php72',
      'php73'
    ]
  
    seven_ver.each do |sv|
      # we'll use this to set versions 7.1, 7.2, or 7.3 based on need...
      if node['apache_conf']['php']['7_ver'] == sv
        execute "enabling-repo-remi-#{sv}" do
          command "yum-config-manager --enable remi remi-#{sv}"
          not_if "grep enabled=1 /etc/yum.repos.d/remi-#{sv}.repo"
        end
      # if we're one of the unchosen versions, disable the repo:
      else
        execute "disabling-repo-remi-#{sv}" do
          command "yum-config-manager --disable remi-#{sv}"
          only_if "grep enabled=1 /etc/yum.repos.d/remi-#{sv}.repo"
        end
      end
    end
  else
  # if nodes version is NOT set, default to php 7.0...
    execute 'enabling-remi-repo-70' do
      command 'yum-config-manager --enable remi-php70'
      not_if "grep enabled=1 /etc/yum.repos.d/remi-php70.repo"
    end
  end
end


#################################################################


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
