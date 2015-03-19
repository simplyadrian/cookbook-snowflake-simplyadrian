#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

file "#{Chef::Config[:file_cache_path]}/git_wrapper.sh" do
  mode "0755"
  content "#!/bin/sh\nexec /usr/bin/ssh -i /root/.ssh/id_rsa \"$@\""
end

node['snowflake-nativex']['snowflake_git_dependencies'].each do |build|
  git "#{Chef::Config[:file_cache_path]}/#{build[:name]}"  do
    repository build[:url]
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
  end
end

git "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}" do
  repository node['snowflake-nativex']['snowflake_git_repository_url']
  revision node['snowflake-nativex']['snowflake_git_repository_branch']
  depth node['snowflake-nativex']['snowflake_git_clone_depth']
  action :sync
  ssh_wrapper "#{Chef::Config[:file_cache_path]}/git_wrapper.sh"
  notifies :run, "bash[compile_snowflake_project]"
end

bash "compile_snowflake_project" do
  cwd "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}"
  code <<-EOH
    mvn clean package
    EOH
end