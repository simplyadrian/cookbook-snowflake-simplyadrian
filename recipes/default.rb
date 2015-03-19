#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

node['snowflake-nativex']['snowflake_git_dependencies'].each do |depend_build|
  git "#{Chef::Config[:file_cache_path]}/#{depend_build[:name]}"  do
    repository depend_build[:url]
    repository depend_build[:branch]
    depth depend_build[:depth]
    action :sync
  end
  bash "build_snowflake" do
    cwd "#{Chef::Config[:file_cache_path]}/#{depend_build[:name]}"
    code <<-EOH
      mvn clean install
      EOH
  end
end

git "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}" do
  repository node['snowflake-nativex']['snowflake_git_repository_url']
  revision node['snowflake-nativex']['snowflake_git_repository_branch']
  action :sync
  notifies :run, "bash[compile_snowflake_project]"
end

bash "compile_snowflake_project" do
  cwd "#{Chef::Config[:file_cache_path]}/#{node['snowflake-nativex']['nativex_snowflake_project_name']}"
  code <<-EOH
    mvn clean package
    EOH
end