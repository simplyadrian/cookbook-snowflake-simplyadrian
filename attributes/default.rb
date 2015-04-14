# Snowflake install method. Currently supports 'archive' and 'source'.
default['snowflake-nativexsnow']['install_method'] = 'archive'
# The NativeX snowflake project name
default['snowflake-nativex']['app']['nativex_snowflake_project_name'] = 'snowflake'
# The snowflake project environment home directory
default['snowflake-nativex']['app']['snowflake_home'] = '/usr/local/snowflake'
# Snowflake datacetnerID ##TODO make this dynamic with an LWRP.
default['snowflake-nativex']['app']['datacenterId'] = 7
# Snowflake map id 0..31 ##TODO make this dynamic with an LWRP
default['snowflake-nativex']['app']['map_id'] = 0
# Snowflake logging directory and file name.
default['snowflake-nativex']['app']['snowflake_log'] = 'snowflake.log'
# List of tarballs for installing snowflake from archive.
default['snowflake-nativex']['dependency_tarball'] = [{:name => 'twitter-scala-parent-overrides',
												:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/twitter-scala-parent-overrides.tgz'},
								    			{:name => 'apache-scribe-client-overrides',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/apache-scribe-client-overrides.tgz'},
								    			{:name => 'snowflake',
								    			:url => 'https://s3-us-west-2.amazonaws.com/archive-code-nativex/snowflake.tgz'}]
# ELB name ##TODO make this a dynamic attribute but set it here while developing.
default['snowflake-nativex']['elb']['name'] = "DAW1AL-flakeELB"
# An array of project names, uris and their branches need to build the NativeX snowflake project 
default['snowflake-nativex']['git']['snowflake_git_dependencies'] = [{:name => 'twitter-scala-parent-overrides',
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
# The snowflake project main jar file.
default['snowflake-nativex']['java']['main_jar'] = 'snowflake-1.0.1-SNAPSHOT.jar'
# The snowflake class search path of directories and zip/jar files
default['snowflake-nativex']['java']['main-class'] = 'com.twitter.service.snowflake.SnowflakeServer'
# Java heap options for the snowflake application.
default['snowflake-nativex']['java']['heap_opts'] = '-Xmx700m -Xms700m -Xmn500m'
# Java JMX optiosn for the snowflake application.
default['snowflake-nativex']['java']['jmx_opts'] = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false'
# Java garbage collection settings for the snowflake application.
default['snowflake-nativex']['java']['gc_opts'] = '-XX:+UseConcMarkSweepGC -verbosegc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseParNewGC -Xloggc:/var/log/snowflake/gc.log'
# Java debug options for the snow application.
default['snowflake-nativex']['java']['debug_opts'] = '-XX:ErrorFile=/var/log/$APP_NAME/java_error%p.log'
# The complete Java options being passed to the snowflake application.
default['snowflake-nativex']['java']['java_opts'] = '-server $GC_OPTS $JMX_OPTS $HEAP_OPTS $DEBUG_OPTS'
# The destination directory where the snowflake project will live after being compiled.
default['snowflake-nativex']['link']['destination_directory'] = '/usr/local'
# Zookeeper hosts lists. ##TODO Make this dynamic with an LWRP. *zookeeper cookbook dependency
default['snowflake-nativex']['zookeeper']['host_list'] = 'pchdvl-zookpr01.teamfreeze.com,pchdvl-zookpr02.teamfreeze.com,pchdvl-zookpr03.teamfreeze.com'
