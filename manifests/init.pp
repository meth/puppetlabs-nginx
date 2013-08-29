# Class: nginx
#
# This module manages NGINX.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the nginx::params class
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged NGINX
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
#  stdlib
#    - puppetlabs-stdlib module >= 0.1.6
#    - plugin sync enabled to obtain the anchor type
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include nginx
# }
class nginx (
  $worker_processes   = $nginx::params::nx_worker_processes,
  $worker_connections = $nginx::params::nx_worker_connections,
  $proxy_set_header   = $nginx::params::nx_proxy_set_header,
  $confd_purge        = $nginx::params::nx_confd_purge,
  $configtest_enable  = $nginx::params::nx_configtest_enable,
  $service_restart    = $nginx::params::nx_service_restrart,
  $config_template = $nginx::params::config_template,
  $proxy_template = $nginx::params::proxy_template,
  $nx_sendfile = $nginx::params::nx_sendfile,
  $nx_tcp_nopush = $nginx::params::nx_tcp_nopush,
  $nx_keepalive_timeout = $nginx::params::nx_keepalive_timeout,
  $nx_tcp_nodelay = $nginx::params::nx_tcp_nodelay,
  $nx_logdir = $nginx::params::nx_logdir,
  $nx_gzip = $nginx::params::nx_gzip,
  $extra_config_options = {},
  $nx_proxy_redirect = $nginx::params::nx_proxy_redirect,
  $nx_client_max_body_size = $nginx::params::nx_client_max_body_size,
  $nx_client_body_buffer_size = $nginx::params::nx_client_body_buffer_size,
  $nx_proxy_connect_timeout = $nginx::params::nx_proxy_connect_timeout,
  $nx_proxy_send_timeout = $nginx::params::nx_proxy_send_timeout,
  $nx_proxy_read_timeout = $nginx::params::nx_proxy_read_timeout,
  $nx_proxy_buffers = $nginx::params::nx_proxy_buffers,
) inherits nginx::params {

  include stdlib

  class { 'nginx::package':
    notify => Class['nginx::service'],
  }

  class { 'nginx::config':
    worker_processes 	=> $worker_processes,
    worker_connections 	=> $worker_connections,
    proxy_set_header 	=> $proxy_set_header,
    confd_purge         => $confd_purge,
    require 		=> Class['nginx::package'],
    notify  		=> Class['nginx::service'],
    config_template => $config_template,
    proxy_template => $proxy_template,
    nx_sendfile => $nx_sendfile,
    nx_tcp_nopush => $nx_tcp_nopush,
    nx_keepalive_timeout => $nx_keepalive_timeout,
    nx_tcp_nodelay => $nx_tcp_nodelay,
    nx_logdir => $nx_logdir,
    nx_gzip => $nx_gzip,
    extra_options => $extra_config_options,
    nx_proxy_redirect => $nx_proxy_redirect,
    nx_client_max_body_size => $nx_client_max_body_size,
    nx_client_body_buffer_size => $nx_client_body_buffer_size,
    nx_proxy_connect_timeout => $nx_proxy_connect_timeout,
    nx_proxy_send_timeout => $nx_proxy_send_timeout,
    nx_proxy_read_timeout => $nx_proxy_read_timeout,
    nx_proxy_buffers => $nx_proxy_buffers,
  }

  class { 'nginx::service':
    configtest_enable => $configtest_enable,
    service_restart => $service_restart,
  }

  # Allow the end user to establish relationships to the "main" class
  # and preserve the relationship to the implementation classes through
  # a transitive relationship to the composite class.
  anchor{ 'nginx::begin':
    before => Class['nginx::package'],
    notify => Class['nginx::service'],
  }
  anchor { 'nginx::end':
    require => Class['nginx::service'],
  }
}
