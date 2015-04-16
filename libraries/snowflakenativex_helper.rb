#
# Cookbook Name:: snowflake-nativex
# Libraries:: snowflakenativex_helper
#
# Copyright 2014, NativeX
#
# All rights reserved - Do Not Redistribute
#

module SnowflakeNativex
  module Helper
  
    def get_workerid_integer_and_increment( node )
      Chef::Log.debug("Parsing node to provide key value pairs.")

      workerIdMap = []

      workerIdMap << node['snowflake']['map_id'].succ

    Chef::Log.debug("The integer being used equals #{workerIdMap.length}")
    return workerIdMap
    end
  end
end
