#
# Cookbook Name:: snowflake-nativex
# Recipe:: default
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

 git "#{Chef::Config[:file_cache_path]}/ruby-build" do
   repository "git://github.com/sstephenson/ruby-build.git"
   reference "master"
   action :sync
 end

 bash "install_ruby_build" do
   cwd "#{Chef::Config[:file_cache_path]}/ruby-build"
   user "rbenv"
   group "rbenv"
   code <<-EOH
     ./install.sh
     EOH
   environment 'PREFIX' => "/usr/local"
end