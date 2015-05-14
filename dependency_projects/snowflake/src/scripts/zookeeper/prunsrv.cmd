REM ~ http://commons.apache.org/daemon/procrun.html
setlocal
call "%~dp0zkEnv.cmd"

REM ~ Undo echo off from zkEnv.cmd
@echo on

set PRUNSRV=C:\Program Files\Apache\commons-daemon-1.0.10\prunsrv.exe
set SERVICE_NAME=Zookeeper
set DISPLAY_NAME=Apache Zookeeper
set DESCRIPTION=Distributed Process Coordinator
set ZK_JAVA=C:\Program Files\Java\jdk1.7.0_06

set APP_DIR=%~dp0..\
set LOG_DIR=%APP_DIR%

set JARS=
REM ~ http://superuser.com/questions/288255/windows-command-line-how-to-append-a-variable-in-a-loop
setlocal enabledelayedexpansion
for /f "delims=" %%x in ('dir "%~dp0..\*.jar" /b') do set JARS=!JARS!;%~dp0..\%%x
for /f "delims=" %%x in ('dir "%~dp0..\lib\*.jar" /b') do set JARS=!JARS!;%~dp0..\lib\%%x
setlocal disabledelayedexpansion

set MAIN_CLASS=org.apache.zookeeper.server.quorum.QuorumPeerMain

set JMX_OPTS=-Dcom.sun.management.jmxremote;-Dcom.sun.management.jmxremote.port=9998;-Dcom.sun.management.jmxremote.authenticate=false;-Dcom.sun.management.jmxremote.ssl=false

set JAVA_OPTS=-server;%JMX_OPTS%;-Dzookeeper.log.dir=\"%LOG_DIR%";-Dzookeeper.root.logger=%ZOO_LOG4J_PROP%

REM ~ These aren't hooked up. Saved in case we want them later
REM ~ set INITIAL_HEAP=700
REM ~ set MAX_HEAP=700
REM ~ set YOUNG_GEN_HEAP=500m
REM ~ set GC_OPTS=-XX:+UseConcMarkSweepGC;-verbosegc;-XX:+PrintGCDetails;-XX:+PrintGCTimeStamps;-XX:+PrintGCDateStamps;-XX:+UseParNewGC;-Xloggc:\"%LOG_DIR%snowflakeGC.log\"
REM ~ set DEBUG_OPTS=-XX:ErrorFile=\"%LOG_DIR%snowflakeJErr%%p.log\"

set PRUNSRV_OPTS=--DisplayName="%DISPLAY_NAME%" --Install="%PRUNSRV%" ^
	--JavaHome="%ZK_JAVA%" --StartMode=Java --Description="%DESCRIPTION%" ^
	--Startup=auto --Classpath="\"%JARS:~1%\"" --StartClass=%MAIN_CLASS% ^
	--JvmOptions="%JAVA_OPTS%" ^
	--LogPath="%LOG_DIR%\" --LogPrefix=%SERVICE_NAME% ^
	--StdOutput="%LOG_DIR%%SERVICE_NAME%StdOut.log" ^
	--StdError="%LOG_DIR%%SERVICE_NAME%StdErr.log" --StartParams="%ZOOCFG%"

"%PRUNSRV%" //IS//%SERVICE_NAME% %PRUNSRV_OPTS%

endlocal
pause
