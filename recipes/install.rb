#
# Cookbook Name:: snowflake-simplyadrian
# Recipe:: install
#
# Copyright 2015, simplyadrian
#
# All rights reserved - Do Not Redistribute
#

include_recipe "snowflake-simplyadrian::snowflake_from_#{node['snowflake-simplyadrian']['install_method']}"