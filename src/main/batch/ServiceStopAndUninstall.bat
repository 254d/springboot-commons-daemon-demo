@echo off
set SERVICE_NAME=DemoApplicationService
set BASEDIR=%~dp0

%BASEDIR%prunsrv.exe stop   %SERVICE_NAME%
%BASEDIR%prunsrv.exe delete %SERVICE_NAME%

pause
