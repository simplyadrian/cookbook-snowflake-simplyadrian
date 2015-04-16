#
# Cookbook Name:: snowflake-nativex
# Libraries:: snowflakenativex_helper
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

class Chef
  module SnowflakeNativex
    module Helper
      class << self

        def peers(nodes)
          nodes = [nodes] if nodes.class == Chef::Node
          nodes.map{ |node| node_to_peer(node) }
        end

        def node_to_peer(node)
          unless node['snowflake-nativex']['app']['datacenterId'].nil?
            snowflakeDatacenterID = [ node['snowflake-nativex']['app']['datacenterId'] ]
          else
            snowflakeDatacenterID = node['snowflake-nativex']['app']['datacenterId']
          end

          snowflakeDatacenterID.to_a.map.with_index do |snowflakeDatacenterID, i|
            { 'snowflakeDatacenterID'  => snowflakeDatacenterID,
              'workerIdMap' => i + node['snowflake']['map_id'].to_i    
            }
          end
        end

      end
    end
  end
end