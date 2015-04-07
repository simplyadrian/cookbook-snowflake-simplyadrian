# An array of project names, uris and their branches need to build the NativeX snowflake project 
default['snowflake-nativex']['snowflake_git_dependencies'] = [{:name => 'twitter-scala-parent-overrides',
													          :uri => 'git@github.com:nativex/twitter-scala-parent-overrides.git',
													          :branch => 'master',
													          :depth => 1},
													          {:name => 'apache-scribe-client-overrides',
													          :uri => 'git@github.com:nativex/apache-scribe-client-overrides.git',
													          :branch => 'master',
													          :depth => 1}]
# The NativeX snowflake project name
default['snowflake-nativex']['nativex_snowflake_project_name'] = 'snowflake'
# The snowflake git repository uri
default['snowflake-nativex']['snowflake_git_repository_uri'] = 'git@github.com:nativex/snowflake.git'
# The snowflake revision or branch you want to checkout.
default['snowflake-nativex']['snowflake_git_repository_branch'] = 'master'
# The depth you want to which you want to clone the snowflake project.
default['snowflake-nativex']['snowflake_git_clone_depth'] = 1
# The destination directory where the snowflake project will live after being compiled.
default['snowflake-nativex']['link']['destination_directory'] = '/usr/local'
# The snowflake project environment home directory
default['snowflake-nativex']['snowflake_home'] = '/usr/local/snowflake'
# The snowflake project main jar file.
default['snowflake-nativex']['main_jar'] = "/target/snowflake-1.0.1-SNAPSHOT.jar"
# The snowflake class search path of directories and zip/jar files
default['snowflake-nativex']['main-class'] = "com.twitter.service.snowflake.SnowflakeServer"
# Java heap options for the snowflake application.
default['snowflake-nativex']['heap_opts'] = "-Xmx700m -Xms700m -Xmn500m"
# Java JMX optiosn for the snowflake application.
default['snowflake-nativex']['jmx_opts'] = "-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
# Java garbage collection settings for the snowflake application.
default['snowflake-nativex']['gc_opts'] = "-XX:+UseConcMarkSweepGC -verbosegc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseParNewGC -Xloggc:/var/log/snowflake/gc.log"
# Java debug options for the snow application.
default['snowflake-nativex']['debug_opts'] = "-XX:ErrorFile=/var/log/$APP_NAME/java_error%p.log"
# The complete Java options being passed to the snowflake application.
default['snowflake-nativex']['java_opts'] = "-server $GC_OPTS $JMX_OPTS $HEAP_OPTS $DEBUG_OPTS"
