#
# Cookbook Name:: snowflake-nativex
# Recipe:: set_datacenterid_and_workerid.rb
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

require 'chef/data_bag'

unless Chef::DataBag.list.key?('unique_name')
  new_databag = Chef::DataBag.new
  new_databag.name('unique_name')
  new_databag.save
end