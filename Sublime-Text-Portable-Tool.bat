@ECHO OFF
TITLE Sublime Text Portable Tool
CALL :get_last_arg %*
SET "CURRENT_DIR=%LAST_ARG%"
SET "TEMP_DIR=%CD%"
SET PATH=%TEMP_DIR%;%PATH%
CD /D %CURRENT_DIR%

ECHO.
ECHO       Sublime Text �K�⪩�u��] @LOO2K  �c���ơ��ק�Gjfcherng     
ECHO ----------------------------------------------------------------------------
ECHO.
ECHO   �ާ@�Ǹ��G
ECHO   1: �K�[ Sublime Text ��t�Υk���� (icon_menu.ico)
ECHO   2: ���� Sublime Text �k����
ECHO   3: �K�[���ɦW���p (icon_doc.ico, ���ɦW�C��Цs��ܦP�ؿ��� ext.txt �ɮפ�)
ECHO   4: �������ɦW���p
ECHO   5: �� Sublime Text ���D�{���ϥܬ� icon_program.ico
ECHO   6: ���}
ECHO.
ECHO   �`�N�ƶ��G
ECHO   1. �бN���}���ƻs�� Sublime Text ����Ƨ�
ECHO   2. �T�{ Sublime Text ���i�����ɮצW�� sublime_text.exe
ECHO   3. �бN�ݭn�j�w�����ɦW�O�s��P�ؿ� ext.txt �ɮפ��]�C��@�Ӱ��ɦW�^
ECHO.
ECHO ----------------------------------------------------------------------------


:begin
SET /p u=��J�ާ@�Ǹ��ë� Enter ��G
IF "%u%" == "1" GOTO regMenu
IF "%u%" == "2" GOTO unregMenu
IF "%u%" == "3" GOTO sublime_text_file
IF "%u%" == "4" GOTO un_sublime_text_file
IF "%u%" == "5" GOTO change_program_icon
IF "%u%" == "6" EXIT
GOTO begin


:regMenu
reg add "HKCR\*\shell\Sublime Text" /ve /d "�H Sublime Text �}��" /f 
reg add "HKCR\*\shell\Sublime Text" /v "Icon" /d "%cd%\icon_menu.ico" /f
REM reg add "HKCR\*\shell\Sublime Text" /v "Icon" /d "%cd%\sublime_text.exe,0" /f
reg add "HKCR\*\shell\Sublime Text\command" /ve /d "%cd%\sublime_text.exe ""%%1""" /f 
ECHO.
ECHO �w���\�K�[�k����
ECHO.
GOTO begin


:unregMenu
reg delete "HKCR\*\shell\Sublime Text" /f
ECHO.
ECHO �w���\�����k����
ECHO.
GOTO begin


:sublime_text_file
reg add "HKCR\sublime_text_file" /ve /d "Sublime Text file" /f
reg add "HKCR\sublime_text_file\DefaultIcon" /ve /d "%cd%\icon_doc.ico" /f
reg add "HKCR\sublime_text_file\shell\open\command" /ve /d "%cd%\sublime_text.exe ""%%1""" /f
FOR /F "eol=;" %%e IN (ext.txt) DO (
	REM ECHO %%e
	reg query "HKCR\.%%e" > NUL || reg add "HKCR\.%%e" /f
	FOR /f "skip=2 tokens=1,2,* delims= " %%a IN ('reg query "HKCR\.%%e" /ve') DO (
		IF NOT "%%c" == "sublime_text_file" (
			reg add "HKCR\.%%e" /v "sublime_text_backup" /d "%%c" /f
		)
	)
	assoc .%%e=sublime_text_file
)
ECHO.
ECHO �w���\�K�[���ɦW
ECHO.
GOTO begin


:un_sublime_text_file
reg delete "HKCR\sublime_text_file" /f
FOR /F "eol=;" %%e IN (ext.txt) DO (
	REM ECHO %%e
	reg query "HKCR\.%%e" /v "sublime_text_backup" > NUL || reg add "HKCR\.%%e" /ve /f
	FOR /f "skip=2 tokens=1,2,* delims= " %%a IN ('reg query "HKCR\.%%e" /v "sublime_text_backup"') DO (
		reg add "HKCR\.%%e" /ve /d "%%c" /f
		reg delete "HKCR\.%%e" /V "sublime_text_backup" /f
	)
)
ECHO.
ECHO �w���\�������ɦW
ECHO.
GOTO BEGIN


:change_program_icon
ResHacker.exe -addoverwrite "sublime_text.exe", "sublime_text.exe", "icon_program.ico", ICONGROUP, MAINICON, 0
@DEL /F ResHacker.ini
@DEL /F ResHacker.log
REM try to clean icon cache
@ie4uinit.exe -ClearIconCache
@DEL /F /A %USERPROFILE%\AppData\Local\IconCache.db
ECHO.
ECHO �w���\�󴫥D�{���ϥ�
ECHO.
GOTO BEGIN


:get_last_arg
  SET "LAST_ARG=%~1"
  SHIFT
  IF NOT "%~1"=="" GOTO get_last_arg
GOTO :EOF
