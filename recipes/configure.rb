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
    ln -s "#{Chef::Config['file_cache_path']}/#{node['snowflake']['application_name']}" \
    "#{node['snowflake-nativex']['link']['destination_directory']}/#{node['snowflake']['application_name']}"
    EOH
    not_if { ::File.directory?("#{node['snowflake-nativex']['link']['destination_directory']}/#{node['snowflake']['application_name']}") }
end

# Create environment file for snowflake
template '/etc/init.d/snowflake' do
  source 'snowflake.erb'
  mode   '0755'
end

# instantiate the data bag item for use as a variable
db = data_bag_item( 'ids', 'snowflake_id' )

# Create environment file for snowflake
template "#{node['snowflake']['snowflake_home']}/config/config.scala" do
  source 'config.scala.erb'
  mode   '0755'
  variables( 
    :datacenter_id => db['datacenter_id'],
    :worker_id => db['worker_id']
  )
  notifies :restart, 'service[snowflake]'
  not_if { node.attribute?('snowflake_configured') }
end

# Enable snowflake service
service 'snowflake' do
	supports :start => true, :restart => true, :stop => true
	action [ :enable ]
end

ruby_block 'set_idempotence' do
  block do
    node.set['snowflake_configured'] = true
    node.save
  end
  action :run
end
