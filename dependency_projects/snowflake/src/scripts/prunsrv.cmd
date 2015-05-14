REM ~ http://commons.apache.org/daemon/procrun.html
setlocal

set PRUNSRV=C:\Program Files\Apache\commons-daemon-1.0.10\prunsrv.exe
set SERVICE_NAME=Snowflake
set DISPLAY_NAME=Snowflake Unique ID Service
set DESCRIPTION=A Thrift-based serivce that generates unique 64-bit IDs based on time, service ID and a mutex sequence.
REM ~ set SNOWFLAKE_JAVA=%JAVA_HOME%
set SNOWFLAKE_JAVA=C:\Program Files\Java\jdk1.7.0_06

REM ~ set APP_DIR=C:\Program Files\Snowflake\
set APP_DIR=%~dp0..\

REM ~ Remember to change the log path in the CONFIG_FILE listed below, too
set LOG_DIR=%APP_DIR%
set MAIN_JAR=snowflake-1.0.1-SNAPSHOT.jar
set MAIN_CLASS=com.twitter.service.snowflake.SnowflakeServer
set CONFIG_FILE=%APP_DIR%config\config.scala

set INITIAL_HEAP=700
set MAX_HEAP=700
set YOUNG_GEN_HEAP=500m

set JMX_OPTS=-Dcom.sun.management.jmxremote;-Dcom.sun.management.jmxremote.port=9999;-Dcom.sun.management.jmxremote.authenticate=false;-Dcom.sun.management.jmxremote.ssl=false
set GC_OPTS=-XX:+UseConcMarkSweepGC;-verbosegc;-XX:+PrintGCDetails;-XX:+PrintGCTimeStamps;-XX:+PrintGCDateStamps;-XX:+UseParNewGC;-Xloggc:\"%LOG_DIR%snowflakeGC.log\"
set DEBUG_OPTS=-XX:ErrorFile=\"%LOG_DIR%snowflakeJErr%%p.log\"
set CLASSPATH_OPT=-cp;\"%APP_DIR%libs\*';'%APP_DIR%%MAIN_JAR%\"

set JAVA_OPTS=-server;%CLASSPATH_OPT%;%GC_OPTS%;%JMX_OPTS%;-Xmn%YOUNG_GEN_HEAP%;%DEBUG_OPTS%

set PRUNSRV_OPTS=--DisplayName="%DISPLAY_NAME%" --Install="%PRUNSRV%" ^
	--JavaHome="%SNOWFLAKE_JAVA%" --StartMode=Java --Description="%DESCRIPTION%" ^
	--Startup=auto --StartClass=%MAIN_CLASS% ^
	--JvmMs=%INITIAL_HEAP% --JvmMx=%MAX_HEAP% --JvmOptions="%JAVA_OPTS%" ^
	--LogPath="%LOG_DIR%\" --LogPrefix=%SERVICE_NAME% ^
	--StdOutput="%LOG_DIR%%SERVICE_NAME%StdOut.log" ^
	--StdError="%LOG_DIR%%SERVICE_NAME%StdErr.log" --StartParams="-f;\"%CONFIG_FILE%\""

"%PRUNSRV%" //IS//%SERVICE_NAME% %PRUNSRV_OPTS%

endlocal

pause
