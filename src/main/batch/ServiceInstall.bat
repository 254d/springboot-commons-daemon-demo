@echo off
set SERVICE_NAME=DemoApplicationService
set DISPLAY_NAME=Demo Application Service
set DESCRIPTION=Spring Boot app as a Windows Service (procrun)
set BASEDIR=%~dp0
set JVM=%JAVA_HOME%\bin\server\jvm.dll
set JAR=demo.jar
set LIB=lib

if not defined JAVA_HOME (
  echo JAVA_HOME is NOT set.
  exit /b 1
)

if not exist "%JAVA_HOME%\bin\java.exe" (
  echo JAVA_HOME is set but java.exe not found.
  echo JAVA_HOME=%JAVA_HOME%
  exit /b 2
)

echo JAVA_HOME is valid: %JAVA_HOME%

"%BASEDIR%\prunsrv.exe" install %SERVICE_NAME% ^
  --DisplayName="%DISPLAY_NAME%" ^
  --Description="%DESCRIPTION%" ^
  --Startup=auto ^
  --Install="%BASEDIR%\prunsrv.exe" ^
  --Jvm="%JVM%" ^
  --StartMode=jvm ^
  --StartClass=com.example.demo.WindowsServiceLauncher ^
  --StartMethod=start ^
  --StopMode=jvm ^
  --StopClass=com.example.demo.WindowsServiceLauncher ^
  --StopMethod=stop ^
  --Classpath="%BASEDIR%%JAR%;%BASEDIR%%LIB%*" ^
  --JvmOptions=-Duser.dir=%BASEDIR% ^
  ++JvmOptions=-Dfile.encoding=UTF-8 ^
  ++JvmOptions=-Dspring.devtools.restart.enabled=false ^
  --LogPath="%BASEDIR%logs" ^
  --LogPrefix=%SERVICE_NAME% ^
  --LogLevel=Info ^
  --StdOutput=auto ^
  --StdError=auto

echo Installed: %SERVICE_NAME%

pause
