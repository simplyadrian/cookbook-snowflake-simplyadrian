#
# Cookbook Name:: snowflake-nativex
# Recipe:: remote_file_build
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#


# Download the dependency archives locally and unpack them.
node['snowflake-nativex']['dependency_tarball'].each do |build|
  ark "#{build[:name]}"  do
    url "#{build[:url]}"
    path "#{Chef::Config[:file_cache_path]}"
    action :put
  end
  bash "install_snowflake_dependencies" do
    cwd "#{Chef::Config[:file_cache_path]}/#{build[:name]}"
    code <<-EOH
      mvn clean install -X
    EOH
  end
end

# Download the snowflake project archive locally and unpack it.
ark "#{node['snowflake-nativex']['app']['nativex_snowflake_project_name']}" do
  url 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/snowflake.tgz'
  path "#{Chef::Config[:file_cache_path]}"
  action :install
  notifies :run, "bash[compile_snowflake_project]"
end

# Bash function to compile the snowflake project.
bash "compile_snowflake_project" do
  cwd "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['app']['nativex_snowflake_project_name']}"
  code <<-EOH
    mvn clean package -X
    EOH
    action :nothing
end