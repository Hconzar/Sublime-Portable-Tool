@echo off

%extd% /inputbox "EnableWindow" "Enter the title of the window you would like to enable" ""

if "%result%"=="" (exit) else (set window="%result%")

%extd% /enablewindow %window%