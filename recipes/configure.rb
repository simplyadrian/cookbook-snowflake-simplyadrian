#
# Cookbook Name:: snowflake-nativex
# Recipe:: configure
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

# Create environment file for snowflake
template "#{node['snowflake-nativex']['app']['snowflake_home']}/config/config.scala" do
  source 'config.scala.erb'
  mode   '0755'
end