#
# Cookbook Name:: snowflake-nativex
# Recipe:: git_build
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

node.force_override['snowflake-nativex']['install_method'] = 'source' # ~FC019

include_recipe 'role-base-nativex::git_auth'

# Create ssh wraper for github.com authentication
file "#{Chef::Config[:file_cache_path]}/git_wrapper.sh" do
  mode 00755
  content "#!/bin/sh\nexec /usr/bin/ssh -i #{node['role-base-nativex']['ssh']['home']}/#{node['role-base-nativex']['ssh']['key_name']} -o 'StrictHostKeyChecking=no' \"$@\""
end

# Clone the snowflake dependencies locally and compile and install
node['snowflake-nativex']['git']['snowflake_git_dependencies'].each do |build|
  git "#{Chef::Config[:file_cache_path]}/#{build[:name]}"  do
    repository build[:uri]
    revision build[:branch]
    depth build[:depth]
    action :sync
    ssh_wrapper "#{Chef::Config[:file_cache_path]}/git_wrapper.sh"
    timeout 180
  end
  bash "install_snowflake_dependencies" do
  cwd "#{Chef::Config[:file_cache_path]}/#{build[:name]}"
  code <<-EOH
    mvn clean install -X
    EOH
    not_if { ::File.directory?("#{Chef::Config[:file_cache_path]}/#{build[:name]}/target")}
  end
end

# Clone the snowflake project and notify the compile function to package the snowflake project.
git "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['app']['nativex_snowflake_project_name']}" do
  repository node['snowflake-nativex']['git']['snowflake_git_repository_uri']
  revision node['snowflake-nativex']['git']['snowflake_git_repository_branch']
  depth node['snowflake-nativex']['git']['snowflake_git_clone_depth']
  action :sync
  ssh_wrapper "#{Chef::Config[:file_cache_path]}/git_wrapper.sh"
  timeout 180
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