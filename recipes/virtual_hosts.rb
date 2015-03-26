#
# Cookbook Name:: apache_conf
# Recipe:: virtual_hosts
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


# Create Virtual Host config directory if not present:
directory node['apache_conf']['httpd']['vhosts'] do
  action :create
  owner  node['apache_conf']['alt_files_owner']
  group  node['apache_conf']['alt_files_group']
  mode   node['apache_conf']['alt_dirs_mode']
  recursive true
end


node['sitelist'].each do |sl|
  vh     = data_bag_item(node['apache_conf']['httpd']['vhost_data_bag'], sl)
  mysite = vh['id'].sub(/_ssl$|_proxy$/, "")

  log "Creating folders and config for #{mysite}"

  site_root = "#{vh['site_root']}/#{mysite}"
  doc_root  = "#{site_root}/#{vh['doc_root']}"
  log_root  = "#{site_root}/#{vh['log_root']}"

  doc_log_dirs = Array[doc_root,log_root]
  doc_log_dirs.each do |dir|
    directory dir do
      action :create
      mode   "0755"
      recursive true
    end
  end

  template "#{node['apache_conf']['httpd']['vhosts']}/#{vh['id']}" do
    source "virtual_host.erb"
    owner  node['apache_conf']['alt_files_owner']
    group  node['apache_conf']['alt_files_group']
    mode   node['apache_conf']['alt_files_mode']

    # Generate a pretty header for each VHost file:
    conf_hd_len = mysite.length + " - virtual host file".length + 8
    conf_header = "#" * conf_hd_len

    variables({
      :conf_header   => conf_header,
      :site_name     => mysite,
      :site_alias    => vh['site_alias'],
      :doc_root      => doc_root,
      :site_admin    => vh['site_admin'],
      :site_ip       => vh['site_ip'],
      :site_port     => vh['site_port'],
      :host_lookups  => vh['host_lookups'],
      :ip_whitelist  => vh['ip_whitelist'],
      :customlog     => "#{log_root}/#{vh['site']['customlog']}",
      :errorlog      => "#{log_root}/#{vh['site']['errorlog']}",
      :clog_opts     => vh['site']['clog_opts'],
      :dontlog       => vh['site']['dontlog'],
      :site          => vh['site'],
      :proxyreqs     => vh['site']['proxyreqs'],
      :proxy         => vh['site']['proxy'],
      :modsec_opts   => vh['site']['modsecopts']
    })

    notifies :restart, "service[httpd]", :delayed
  end
end
