@echo off
set DIR=%~dp0target\release
cmd /c mvnw clean package
java -cp "%DIR%\*;%DIR%\lib\*" com.example.demo.DemoApplication %*
