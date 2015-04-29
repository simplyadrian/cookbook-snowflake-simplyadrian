#
# Cookbook Name:: snowflake-nativex
# Recipe:: install
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe "snowflake-nativex::snowflake_from_#{node['snowflake-nativex']['install_method']}"