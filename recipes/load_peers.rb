#
# Cookbook Name:: snowflake-nativex
# Recipe:: load_peers
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

if node['snowflake-nativex']['app']['peer_search_enabled']

  found_nodes = []
  if Chef::Config[:solo]
    log 'Chef search disabled'
  else
    found_nodes = search 'node', node['snowflake']['peer_search_query']
    log 'Chef search results' do
      message "Search for \"#{node['snowflake']['peer_search_query']}\" yields \"#{found_nodes}\""
    end
  end

  peers = SnowflakeNativex::Helper.peers found_nodes
  peers.flatten!
  peers.sort!{ |a,b| a['id'] <=> b['id'] }

  node.default['snowflake']['map_id'] = peers

end