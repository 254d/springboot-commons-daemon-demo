@echo off
set SERVICE_NAME=DemoApplicationService
set BASEDIR=%~dp0

%BASEDIR%prunmgr.exe //ES//%SERVICE_NAME%
