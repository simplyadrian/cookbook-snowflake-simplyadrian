# The simplyadrian snowflake project name
default['snowflake-simplyadrian']['application_name'] = 'snowflake'
# List of tarballs for installing snowflake from archive.
default['snowflake-simplyadrian']['archive'] = [{:name => 'twitter-scala-parent-overrides',
												:url => 'https://s3-us-west-2.amazonaws.com/archive-code-simplyadrian/twitter-scala-parent-overrides.tgz'},
								    			{:name => 'apache-scribe-client-overrides',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-simplyadrian/apache-scribe-client-overrides.tgz'},
								    			{:name => 'snowflake',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-simplyadrian/snowflake.tgz'}]
# Snowflake install method. Currently supports 'archive' and 'source'.
default['snowflake-simplyadrian']['install_method'] = 'archive'
# The snowflake project environment home directory
default['snowflake-simplyadrian']['snowflake_home'] = '/usr/local/snowflake'
# Snowflake logging file name.
default['snowflake-simplyadrian']['snowflake_log'] = 'snowflake.log'
# ELB name ** Must be deployed prior to snowflake instances. **
default['snowflake-simplyadrian']['elb']['name'] = "DAW1AL-flakeELB"
# The destination directory where the snowflake project will live after being compiled.
default['snowflake-simplyadrian']['link']['destination_directory'] = '/usr/local'
# Zookeeper hosts lists. ##TODO Make this dynamic with an LWRP. *zookeeper cookbook dependency
default['snowflake-simplyadrian']['zookeeper']['host_list'] = 'pchdvl-zookpr01.simplyadrian.com,pchdvl-zookpr02.simplyadrian.com,pchdvl-zookpr03.simplyadrian.com'
