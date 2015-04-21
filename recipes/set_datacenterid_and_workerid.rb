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
  Chef::Log.info("data bag ids exists.")
  new_databag = Chef::DataBag.new
  new_databag.name('ids')
  new_databag.save
end

# Read databag and update if conditions are met.
ruby_block "operate on the databag contents" do
  block do
    snowflake_ids = data_bag_item('ids', 'snowflake_id')
    worker_id = snowflake_ids ['worker_id']
    Chef::Log.info("The worker_id equals #{snowflake_ids['worker_id']}")
    datacenterId = snowflake_ids['datacenter_id']
    Chef::Log.info("The datacenter_id equals #{snowflake_ids['datacenter_id']}")

    #current_databag_keys = Set.new
    #Chef::Log.info("created new hash #{current_databag_keys}")

    if worker_id > 31
      #datacenter_id.succ && worker_id == 0 >> current_databag_keys
      Chef::Log.info("#{worker_id} is greater then 31")
      #if current_databag_keys.length > 0
        snowflake_id = {
          'datacenter_id' => datacenter_id.succ, #"#{current_databag_keys['datacenter_id']}",
          'worker_id' => 0 #"#{current_databag_keys['worker_id']}"
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
      #end
    else
      #worker_id.succ >> current_databag_keys
      Chef::Log.info("Incrementing #{worker_id} by 1")
      #if current_databag_keys.length > 0
        snowflake_id = {
          'datacenter_id' => datacenter_id,
          'worker_id' => worker_id.succ #"#{current_databag_keys['worker_id']}"
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
      #end
    end
  end
  action :run
end