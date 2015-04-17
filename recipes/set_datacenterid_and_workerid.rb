#
# Cookbook Name:: snowflake-nativex
# Recipe:: set_datacenterid_and_workerid.rb
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

require 'chef/data_bag'

# Create databag if it doesn't exist.
unless Chef::DataBag.list.key?('ids')
  new_databag = Chef::DataBag.new
  new_databag.name('ids')
  new_databag.save
end

# Read databag and update if conditions are met.
ruby_block "read the databag contents" do
  block do
    snowflake_ids = data_bag_item('ids','snowflake_id')
    workerId = snowflake_ids['workerId']
    datacenterId = snowflake_ids['datacenterId']
    if workerId > 31
      datacenterId.succ && workerId == 0
    else
      workerId.succ
    end
  end
  action :run
end

#snowflake_id = {
#  'datacenterId' => 0,
#  'workerId' => 0
#}
#databag_item = Chef::DataBagItem.new
#databag_item.data_bag('ids')
#databag_item.raw_data = snowflake_id
#databag_item.save