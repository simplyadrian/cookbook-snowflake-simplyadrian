#
# Cookbook Name:: snowflake-nativex
# Recipe:: snowflake_from_archive
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

node.force_override['snowflake-nativex']['install_method'] = 'archive' # ~FC019

# Download the archives locally and unpack them.
node['snowflake-nativex']['archive'].each do |build|
  ark "#{build[:name]}"  do
    url "#{build[:url]}"
    path "#{Chef::Config[:file_cache_path]}"
    action :put
  end
end