#
# Cookbook Name:: zen_apache
# Recipe:: httpd_conf
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


httpd_conf_root    = node['zen_apache']['httpd']['conf_root']
httpd_conf         = node['zen_apache']['httpd']['httpd_conf']
default_httpd_conf = node['zen_apache']['httpd']['default_conf']


execute "Backing up default httpd.conf" do
  command "mv #{default_httpd_conf} #{default_httpd_conf}.dist"
  not_if { File.exists?("#{default_httpd_conf}.dist") }
end


template "#{httpd_conf_root}/#{httpd_conf}" do
  source 'httpd-2.4.conf.erb'
  owner  node['zen_apache']['alt_files_owner'] if node['zen_apache']['alt_files_owner']
  group  node['zen_apache']['alt_files_group'] if node['zen_apache']['alt_files_group']
  mode   node['zen_apache']['alt_files_mode']  if node['zen_apache']['alt_files_mode']

  variables ({
    :server_root =>  node['zen_apache']['httpd']['server_root'],
    :user        =>  node['zen_apache']['httpd']['user'],
    :group       =>  node['zen_apache']['httpd']['group'],
    :server_admin => node['zen_apache']['httpd']['server_admin'],
    :http_listen =>  node['zen_apache']['httpd']['listen_port'],
    :conf_path   =>  node['zen_apache']['httpd']['vhosts'],
    :sitelist    =>  node['sitelist']
  })

  notifies :restart, "service[httpd]", :delayed
end


# Symlink Conf to NFS version:
link default_httpd_conf do
  to "#{httpd_conf_root}/#{httpd_conf}"
  only_if { File.exists?("#{default_httpd_conf}.dist") }
end


ssl_certs = search(:ssl_certs, 'id:*') # ignore FC003

if ssl_certs.count > 0
  ssl_certs.each do |cert|
    file "#{httpd_conf_root}/ssl/#{cert['id']}" do
    owner  node['zen_apache']['alt_files_owner'] if node['zen_apache']['alt_files_owner']
    group  node['zen_apache']['alt_files_group'] if node['zen_apache']['alt_files_group']
    mode   node['zen_apache']['alt_files_mode']  if node['zen_apache']['alt_files_mode']

      # SSL CERT CONTENT
      if cert['data'].class == String
        content "#{cert['header']}\n" + cert['data'].gsub(/\s+/, "\n") + "\n#{cert['footer']}\n"
      else
        str = ""
        cert['data'].each do |c|
          str = str + "#{cert['header']}\n" + c.gsub(/\s+/, "\n") + "\n#{cert['footer']}\n"
        end
        content str
      end

      notifies :restart, "service[httpd]", :delayed
    end
  end
end
