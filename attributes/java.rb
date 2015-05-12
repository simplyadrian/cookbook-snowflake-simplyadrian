# The snowflake project main jar file.
default['snowflake-simplyadrian']['java']['main_jar'] = 'snowflake-1.0.1-SNAPSHOT.jar'
# The snowflake class search path of directories and zip/jar files
default['snowflake-simplyadrian']['java']['main_class'] = 'com.twitter.service.snowflake.SnowflakeServer'
# Java heap options for the snowflake application.
default['snowflake-simplyadrian']['java']['heap_opts'] = '-Xmx700m -Xms700m -Xmn500m'
# Java JMX optiosn for the snowflake application.
default['snowflake-simplyadrian']['java']['jmx_opts'] = '-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false'
# Java garbage collection settings for the snowflake application.
default['snowflake-simplyadrian']['java']['gc_opts'] = '-XX:+UseConcMarkSweepGC -verbosegc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseParNewGC -Xloggc:/var/log/snowflake_gc.log'
# Java debug options for the snow application.
default['snowflake-simplyadrian']['java']['debug_opts'] = '-XX:ErrorFile=/var/log/$APP_NAME_java_error%p.log'
# The complete Java options being passed to the snowflake application.
default['snowflake-simplyadrian']['java']['java_opts'] = '-server $GC_OPTS $JMX_OPTS $HEAP_OPTS $DEBUG_OPTS'