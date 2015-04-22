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
  Chef::Log.info("create initial contents of data bag ids")
  snowflake_id = {
    'id' => "snowflake_id",
    'datacenter_id' => 0,
    'worker_id' => 0
  }
  databag_item = Chef::DataBagItem.new
  databag_item.data_bag('ids')
  databag_item.raw_data = snowflake_id
  databag_item.save
end

# Read databag and update if conditions are met.
ruby_block "operate on the databag contents" do
  block do
    db = data_bag_item('ids', 'snowflake_id')
    worker_id = db['worker_id']
    Chef::Log.info("The worker_id equals #{db['worker_id']}")
    datacenter_id = db['datacenter_id']
    Chef::Log.info("The datacenter_id equals #{db['datacenter_id']}")

    if datacenter_id >= 31
      Chef::Log.info("datacenter_id is greater than 31")
        snowflake_id = {
          'id' => "snowflake_id",
          'datacenter_id' => 0,
          'worker_id' => 0
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
    elsif worker_id >= 31
      Chef::Log.info("worker_id is greater than 31")
        snowflake_id = {
          'id' => "snowflake_id",
          'datacenter_id' => datacenter_id.succ,
          'worker_id' => 0
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
    else
      Chef::Log.info("Incrementing worker_id by 1")
        snowflake_id = {
          'id' => "snowflake_id",
          'datacenter_id' => datacenter_id,
          'worker_id' => worker_id.succ
        }
        databag_item = Chef::DataBagItem.new
        databag_item.data_bag('ids')
        databag_item.raw_data = snowflake_id
        databag_item.save
        not_if { node.attribute?('snowflake_configured') }
    end
  end
  action :run
end