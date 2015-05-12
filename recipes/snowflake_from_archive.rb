#
# Cookbook Name:: snowflake-simplyadrian
# Recipe:: snowflake_from_archive
#
# Copyright 2015, simplyadrian
#
# All rights reserved - Do Not Redistribute
#

node.force_override['snowflake-simplyadrian']['install_method'] = 'archive' # ~FC019

# Download the archives locally and unpack them.
node['snowflake-simplyadrian']['archive'].each do |build|
  ark "#{build[:name]}"  do
    url "#{build[:url]}"
    path "#{Chef::Config[:file_cache_path]}"
    action :put
  end
end