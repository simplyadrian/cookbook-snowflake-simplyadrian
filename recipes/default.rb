#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'maven'
node.default['maven']['version'] = "3"
node.default['maven']['setup_bin'] = true
node.default['maven']['install_java'] = false

include_recipe 'snowflake-nativex::install'
include_recipe 'snowflake-nativex::configure'
include_recipe 'snowflake-nativex::load_peers'
include_recipe 'snowflake-nativex::add_to_elb'