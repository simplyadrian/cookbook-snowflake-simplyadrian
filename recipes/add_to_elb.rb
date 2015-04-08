#
# Cookbook Name:: snowflake-nativex
# Recipe:: add_to_elb
#
# Copyright 2015, NativeX
#
# All rights reserved - Do Not Redistribute
#

creds = Chef::EncryptedDataBagItem.load("credentials", "aws")

aws_elastic_lb 'add_to_elb' do
  aws_access_key creds['aws_access_key_id']
  aws_secret_access_key creds['aws_secret_access_key']
  name "#{node['snowflake-nativex']['elb']['name']}"
  action :register
end