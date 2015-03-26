zen_apache Cookbook
====================
This cookbook will configure an Apache server with PHP/SSL based on virtual
hosts defined in a data bag in JSON format. Examples of configurations are
posted below.


Requirements
------------
#### platform
- This cookbook has been developed and tested on CentOS 7 (7.0.1406) only. It
may or may not work for other releases, or for derivatives such as RHEL itself.

#### packages
- All required packages are installed via this cookbook


Attributes
----------
#### GENERAL
`default['zen_apache']['alt_files_owner']`
Files default to being owned by the UID of the user running chef-client (usually root). This
attribute will override that in some areas to an alternate user ownership.

`default['zen_apache']['alt_files_group']`
Files default to being owned by the GID of the user running chef-client (usually root). This
attribute will override that in some areas to an alternate group ownership.

`default['zen_apache']['alt_files_mode']`
Files default to 644 permissions generally. This attribute will override that in
some areas to provide an alternate mode.

`default['zen_apache']['alt_dirs_mode']`
Folders default to 755 permissions generally. This attribute will override that in
some areas to provide an alternate mode.


#### HTTPD:
`default['zen_apache']['httpd']['listen_port']`
This defines the port in which the httpd pid listens on. Default is port 80.

`default['zen_apache']['httpd']['root']`
Defines the base folder where the folders for configs, sites, etc. are to be stored

`default['zen_apache']['httpd']['conf_root']`
Location under `default['zen_apache']['httpd']['root']` in which to store the configuration
data

`default['zen_apache']['httpd']['vhosts']`
Location under `default['zen_apache']['httpd']['conf_root']` in which to store the
virtual host configuration data.

`default['zen_apache']['httpd']['sites']`
Location under `default['zen_apache']['httpd']['root']` in which to store the site content

`default['zen_apache']['httpd']['httpd_conf']`
Filename for your httpd.conf. Default is httpd.conf.

`default['zen_apache']['httpd']['default_conf']`
Location and filename to the default distribution httpd.conf. This file is backed up and then a
symlink is created pointing back to the config written to `default['zen_apache']['httpd']['conf_root']`.

`default['zen_apache']['httpd']['vhost_data_bag']`
The name of the Data Bag residing on your Chef Server


#### PHP:
`default['zen_apache']['php']['php_ini']`
Path and filename for your php.ini

`default['zen_apache']['php']['default_ini']`
Location and filename of the default php.ini. This file is backed up and then a
symlink is created pointing back to this custom one.

`default['zen_apache']['php']['mem_limit']`
Value in MB (megabytes) for the memory_limit configuration option in php.ini which
controls the maximum amount of memory a script may consume.

`default['zen_apache']['php']['post_max']`
Value in MB (megabytes) for the post_max_size configuration option in php.ini which
controls the maximum size of POST data that PHP will accept.

`default['zen_apache']['php']['upld_max']`
Value in MB (megabytes) for the upload_max_filesize configuration option in php.ini which controls the maximum allowed size for uploaded files.

`default['zen_apache']['php']['timezone']`
Defines the default timezone used by the date functions

`default['zen_apache']['php']['mysql_persistance']`
Allow or prevent persistent links. Valid values are "On" or "Off".

`default['zen_apache']['php']['sess_handler']`
PHP handler used to store/retrieve data.

`default['zen_apache']['php']['sess_path']`
Path to the session data. Can be either a path to a folder for a 'files' handler, or
a server:port for a 'memcached' handler.

`default['zen_apache']['php']['geoip_dir']`
Path to your GeoIP IP location data (if available).


Usage
-----
#### zen_apache::default
- Include `zen_apache` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[zen_apache]"
  ]
}
```

- Create a data bag to hold your Virtual Hosts
- Create a data bag to store your SSL certs (if any)
- Attach one or more sites to the node which should be serving them:

```json
{
  "name":"my_node",
  "normal": {
    "sitelist": [
      "mysite.com",
      "myothersite.com"
    ]
  }
}
```

- Execute a chef-client run to deploy


Example JSON's for Site Configuration
--------------------------------------
### Standard Site:
```json
{
  "id"           : "resources.thezengarden.net",
  "site_root"    : "/virtual",
  "doc_root"     : "htdocs",
  "log_root"     : "logs",
  "site_admin"   : "chris@thezengarden.net",
  "site_ip"      : "*",
  "site_port"    : "80",
  "host_lookups" : "Off",
  "ip_whitelist" : ["10","209.97.6.5"],

  "site" : {
    "directories"       : {
      "/virtual/resources.thezengarden.net/htdocs"          : {
        "AllowOverride" : "All",
        "Options"       : "ExecCGI Includes FollowSymLinks",
        "Require"       : "all granted"
      }
    },
    "customlog"         : "access_log combined",
    "clog_opts"         : "env=!dontlog",
    "dontlog"           : true,
    "errorlog"          : "error_log",
    "server_status"     : true
  }
}
```

### SSL Site:
```json
{
  "id"           : "thezengarden.net_ssl",
  "site_alias"   : "www.thezengarden.net",
  "site_root"    : "/virtual",
  "doc_root"     : "htdocs",
  "log_root"     : "logs",
  "site_admin"   : "chris@thezengarden.net",
  "site_ip"      : "*",
  "site_port"    : "443",
  "host_lookups" : "Off",
  "ip_whitelist" : ["10","209.97.6.5"],

  "site" : {
    "blocked_files"     : ["wp-login.php","xmlrpc.php"],
    "directories"       : {
      "/virtual/thezengarden.net/htdocs"          : {
        "AllowOverride" : "All",
        "Options"       : "ExecCGI Includes FollowSymLinks",
        "Require"       : "all granted"
      },
      "/virtual/thezengarden.net/htdocs/wp-admin" : {
        "Require"       : ["all denied", "ip 10 209.97.6.5"]
      }
    },
    "customlog"        : "access_log combined",
    "clog_opts"         : "env=!dontlog",
    "dontlog"           : true,
    "errorlog"          : "error_log",
    "ssl"               : {
      "SSLEngine"               : "On",
      "SSLCertificateFile"      : "/www/conf/ssl/thezengarden.net.crt",
      "SSLCertificateKeyFile"   : "/www/conf/ssl/thezengarden.net.key",
      "SSLCertificateChainFile" : "/www/conf/ssl/thezengarden.net.bundle"
    }
  }
}
```


### ProxyPass Site:
```json
{
  "id"           : "cdn.thezengarden.net",
  "site_root"    : "/virtual",
  "doc_root"     : "htdocs",
  "log_root"     : "logs",
  "site_admin"   : "chris@thezengarden.net",
  "site_ip"      : "*",
  "site_port"    : "80",
  "host_lookups" : "Off",
  "ip_whitelist" : ["10","209.97.6.5"],

  "site" : {
    "customlog"        : "access_log combined",
    "clog_opts"        : "env=!dontlog",
    "dontlog"          : true,
    "errorlog"         : "error_log",
    "proxyreqs"        : true,
    "proxy"            : {
      "path"           : "/",
      "dest"           : "http://zg-cdn01.thezengarden.net:8000/",
      "preserve_hosts" : true
    }
  }
}
```

SSL Certs:
----------
### Example for Data Bag:
```json
{
  "id"     : "thezengarden.net.crt",
  "header" : "-----BEGIN CERTIFICATE-----",
  "footer" : "-----END CERTIFICATE-----",
  "data"   : "98erjeproigerp8gerhgeprogierg erpogih rgpoier gpeor "
}
```

`NOTE:` You will need to put the cert data on a single line with each former line being
denoted by a space


Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: GPL v2
Authors: Chris Hammer <chris@thezengarden.net>
