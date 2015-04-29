# The NativeX snowflake project name
default['snowflake-nativex']['application_name'] = 'snowflake'
# List of tarballs for installing snowflake from archive.
default['snowflake-nativex']['archive'] = [{:name => 'twitter-scala-parent-overrides',
												:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/twitter-scala-parent-overrides.tgz'},
								    			{:name => 'apache-scribe-client-overrides',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/apache-scribe-client-overrides.tgz'},
								    			{:name => 'snowflake',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/snowflake.tgz'}]
# Snowflake install method. Currently supports 'archive' and 'source'.
default['snowflake-nativex']['install_method'] = 'archive'
# The snowflake project environment home directory
default['snowflake-nativex']['snowflake_home'] = '/usr/local/snowflake'
# Snowflake logging file name.
default['snowflake-nativex']['snowflake_log'] = 'snowflake.log'
# ELB name ** Must be deployed prior to snowflake instances. **
default['snowflake-nativex']['elb']['name'] = "DAW1AL-flakeELB"
# The destination directory where the snowflake project will live after being compiled.
default['snowflake-nativex']['link']['destination_directory'] = '/usr/local'
# Zookeeper hosts lists. ##TODO Make this dynamic with an LWRP. *zookeeper cookbook dependency
default['snowflake-nativex']['zookeeper']['host_list'] = 'pchdvl-zookpr01.teamfreeze.com,pchdvl-zookpr02.teamfreeze.com,pchdvl-zookpr03.teamfreeze.com'
