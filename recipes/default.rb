#
# Cookbook Name:: snowflake-simplyadrian
# Recipe:: default
#
# Copyright 2015, simplyadrian
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'maven'
include_recipe 'snowflake-simplyadrian::set_datacenterid_and_workerid'
include_recipe 'snowflake-simplyadrian::install'
include_recipe 'snowflake-simplyadrian::configure'
include_recipe 'snowflake-simplyadrian::add_to_elb'