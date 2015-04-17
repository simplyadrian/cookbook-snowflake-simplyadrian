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
    workerId = snowflake_ids[:workerId]
    Chef::Log.info("The workerId equals #{snowflake_ids[:workerId]}")
    datacenterId = snowflake_ids[:datacenterId]
    Chef::Log.info("The datacenterId equals #{snowflake_ids[:datacenterId]}")

    current_databag_keys = Set.new

    if workerId > 31
      datacenterId.succ && workerId == 0 >> current_databag_keys
      Chef::Log.info("#{workerId} is greater then 31")
      if current_databag_keys.length > 0
        snowflake_id = {
          'datacenterId' => "#{current_databag_keys[:datacenterId]}",
          'workerId' => "#{current_databag_keys[:workerId]}"
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
      end
    else
      workerId.succ >> current_databag_keys
      Chef::Log.info("Incrementing #{workerId} by 1")
      if current_databag_keys.length > 0
        snowflake_id = {
          'datacenterId' => datacenterId,
          'workerId' => "#{current_databag_keys[:workerId]}"
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
    end
  end
  action :run
end