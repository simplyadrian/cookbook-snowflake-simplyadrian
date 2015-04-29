#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'maven'
include_recipe 'snowflake-nativex::set_datacenterid_and_workerid'
include_recipe 'snowflake-nativex::install'
include_recipe 'snowflake-nativex::configure'
include_recipe 'snowflake-nativex::add_to_elb'