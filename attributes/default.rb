#
# Cookbook Name:: zen_apache
# Attributes:: default
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


# GENERAL OPTIONS
default['zen_apache']['alt_files_owner'] = 'chris'
default['zen_apache']['alt_files_group'] = 'chris'
default['zen_apache']['alt_files_mode']  = '0644'
default['zen_apache']['alt_dirs_mode']   = '0755'

default['zen_apache']['do_sites_symlink']     = true
default['zen_apache']['sites_symlink_target'] = '/virtual'
