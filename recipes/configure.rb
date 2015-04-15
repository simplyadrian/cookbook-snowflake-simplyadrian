#
# Cookbook Name:: snowflake-nativex
# Recipe:: configure
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

# Link compiled snowflake project to /usr/local/snowflake
bash "link_snowflake_project" do
  code <<-EOH
    ln -s "#{Chef::Config['file_cache_path']}/#{node['snowflake-nativex']['app']['nativex_snowflake_project_name']}" \
    "#{node['snowflake-nativex']['link']['destination_directory']}/#{node['snowflake-nativex']['app']['nativex_snowflake_project_name']}"
    EOH
    not_if { ::File.directory?("#{node['snowflake-nativex']['link']['destination_directory']}/#{node['snowflake-nativex']['app']['nativex_snowflake_project_name']}") }
end

# Create environment file for snowflake
template '/etc/init.d/snowflake' do
  source 'snowflake.erb'
  mode   '0755'
end

# Create environment file for snowflake
template "#{node['snowflake-nativex']['app']['snowflake_home']}/config/config.scala" do
  helpers (SnowflakeNativex::Helper)
  source 'config.scala.erb'
  mode   '0755'
  notifies :restart, 'service[snowflake]'
end

# Instantiate snowflake service
service 'snowflake' do
	supports :start => true, :restart => true, :stop => true
	action [ :enable ]
end

