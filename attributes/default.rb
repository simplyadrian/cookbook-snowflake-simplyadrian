# The NativeX snowflake project name
default['snowflake']['application_name'] = 'snowflake'
# List of tarballs for installing snowflake from archive.
default['snowflake']['archive'] = [{:name => 'twitter-scala-parent-overrides',
												:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/twitter-scala-parent-overrides.tgz'},
								    			{:name => 'apache-scribe-client-overrides',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/apache-scribe-client-overrides.tgz'},
								    			{:name => 'snowflake',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/snowflake.tgz'}]
# Snowflake install method. Currently supports 'archive' and 'source'.
default['snowflake']['install_method'] = 'archive'
# The snowflake project environment home directory
default['snowflake']['snowflake_home'] = '/usr/local/snowflake'
# Snowflake logging directory and file name.
default['snowflake']['snowflake_log'] = 'snowflake.log'
# ELB name ##TODO make this a dynamic attribute but set it here while developing.
default['snowflake-nativex']['elb']['name'] = "DAW1AL-flakeELB"
# An array of project names, uris and their branches need to build the NativeX snowflake project 
default['snowflake-nativex']['git']['snowflake_git_dependency'] = [{:name => 'twitter-scala-parent-overrides',
													          :uri => 'git@github.com:nativex/twitter-scala-parent-overrides.git',
													          :branch => 'master',
													          :depth => 1},
													          {:name => 'apache-scribe-client-overrides',
													          :uri => 'git@github.com:nativex/apache-scribe-client-overrides.git',
													          :branch => 'master',
													          :depth => 1}]
# The snowflake git repository uri
default['snowflake-nativex']['git']['snowflake_git_repository_uri'] = 'git@github.com:nativex/snowflake.git'
# The snowflake revision or branch you want to checkout.
default['snowflake-nativex']['git']['snowflake_git_repository_branch'] = 'master'
# The depth you want to which you want to clone the snowflake project.
default['snowflake-nativex']['git']['snowflake_git_clone_depth'] = 1
# The destination directory where the snowflake project will live after being compiled.
default['snowflake-nativex']['link']['destination_directory'] = '/usr/local'
# Zookeeper hosts lists. ##TODO Make this dynamic with an LWRP. *zookeeper cookbook dependency
default['snowflake-nativex']['zookeeper']['host_list'] = 'pchdvl-zookpr01.teamfreeze.com,pchdvl-zookpr02.teamfreeze.com,pchdvl-zookpr03.teamfreeze.com'
