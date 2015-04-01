#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'maven'
node.default['maven']['version'] = "3"
node.default['maven']['setup_bin'] = true
node.default['maven']['install_java'] = false

# Create ssh wraper for github.com authentication
file "#{Chef::Config[:file_cache_path]}/git_wrapper.sh" do
  mode 00755
  content "#!/bin/sh\nexec /usr/bin/ssh -i #{node['role-base-nativex']['ssh']['home']}/git_nativex -o 'StrictHostKeyChecking=no' \"$@\""
end

# Clone the snowflake dependencies locally and compile and install
node['snowflake-nativex']['snowflake_git_dependencies'].each do |build|
  git "#{Chef::Config[:file_cache_path]}/#{build[:name]}"  do
    repository build[:uri]
    revision build[:branch]
    depth build[:depth]
    action :sync
    ssh_wrapper "#{Chef::Config[:file_cache_path]}/git_wrapper.sh"
  end
  bash "install_snowflake_dependencies" do
  cwd "#{Chef::Config[:file_cache_path]}/#{build[:name]}"
  code <<-EOH
    mvn clean install
    EOH
    not_if { ::File.directory?("#{Chef::Config[:file_cache_path]}/#{build[:name]}/target")}
  end
end

# Clone the snowflake project and notify the compile function to package the snowflake project.
git "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}" do
  repository node['snowflake-nativex']['snowflake_git_repository_uri']
  revision node['snowflake-nativex']['snowflake_git_repository_branch']
  depth node['snowflake-nativex']['snowflake_git_clone_depth']
  action :sync
  ssh_wrapper "#{Chef::Config[:file_cache_path]}/git_wrapper.sh"
  notifies :run, "bash[compile_snowflake_project]"
end

# Bash function to compile the snowflake project.
bash "compile_snowflake_project" do
  cwd "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}"
  code <<-EOH
    mvn clean package
    EOH
    action :nothing
end

# Link compiled snowflake project to /usr/local/snowflake
bash "link_snowflake_project" do
  code <<-EOH
    ln -s "#{Chef::Config['file_cache_path']}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}" \
    "#{node['snowflake-nativex']['link']['destination_directory']}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}"
    EOH
    not_if { ::File.directory?("#{node['snowflake-nativex']['link']['destination_directory']}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}") }
end

# Create environment file for snowflake
template '/etc/snowflakerc' do
  source 'snowflakerc.erb'
  mode   '0755'
end