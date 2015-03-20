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

# Istantiate encrypted data bag
creds = Chef::EncryptedDataBagItem.load('credentials', 'github_chef_user_private_key')

# Store private key on disk
file "#{node['snowflake-nativex']['ssh']['home']}/id_rsa" do
  content "#{creds['priv']}"
  owner node['snowflake-nativex']['ssh']['user']
  group node['snowflake-nativex']['ssh']['group']
  mode 00600
  action :create_if_missing
end

# Create ssh wraper for github.com authentication
file "#{Chef::Config[:file_cache_path]}/git_wrapper.sh" do
  mode 00755
  content "#!/bin/sh\nexec /usr/bin/ssh -i #{node['snowflake-nativex']['ssh']['home']}/id_rsa \"$@\""
end

# Clone the snowflake dependencies locally and compile and install
node['snowflake-nativex']['snowflake_git_dependencies'].each do |build|
  git "#{Chef::Config[:file_cache_path]}/#{build[:name]}"  do
    repository build[:uri]
    revision build[:branch]
    depth build[:depth]
    action :sync
    ssh_wrapper "#{Chef::Config[:file_cache_path]}/git_wrapper.sh"
    notifies :run, "bash[install_snowflake_dependencies]"
  end
  bash "install_snowflake_dependencies" do
  cwd "#{Chef::Config[:file_cache_path]}/#{build[:name]}"
  code <<-EOH
    mvn clean install
    EOH
    #not_if { ::File.directory?("#{Chef::Config[:file_cache_path]}/#{build[:name]}/target")}
    action :nothing
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
    #not_if { ::File.directory?("#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}/target")}
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