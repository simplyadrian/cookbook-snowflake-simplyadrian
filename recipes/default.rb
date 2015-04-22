#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

# Maven version
node.default['maven']['version'] = "3"
# Add maven to system path
node.default['maven']['setup_bin'] = true
# Don't install the openjdk that Maven cookbook ships
node.default['maven']['install_java'] = false

include_recipe 'maven'
include_recipe 'snowflake-nativex::set_datacenterid_and_workerid'
include_recipe 'snowflake-nativex::install'
include_recipe 'snowflake-nativex::configure'
include_recipe 'snowflake-nativex::add_to_elb'