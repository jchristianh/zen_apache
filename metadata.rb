name             'zen_apache'
maintainer       'Copyright (C) 2019 Chris Hammer'
maintainer_email 'chris@thezengarden.net'
license          'GPL-2.0'
description      'Installs/Configures zen_apache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.3.42'
issues_url       'http://www.thezengarden.net'
source_url       'http://www.thezengarden.net'
chef_version     '>= 12.5' if respond_to?(:chef_version)
supports         'centos', '>= 7.0'