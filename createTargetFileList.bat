@echo off
setlocal ENABLEDELAYEDEXPANSION

call:createConvertFileList "d:\user\desktop\ͨ�ÿ�ܡ��ʵ�" ":showNew" "d:\user\desktop\�½��ļ���"
echo=%errorlevel%

pause
exit/b 0

REM :-------------------------�ӳ�������-------------------------:
goto end

REM ��ʾ�µ�
:showNew

echo=srcFile:"%~1", cCFL_descDir:"%~2"

exit/b 0


REM ����ָ���ļ����ļ���(���������ļ�)��Ŀ��Ŀ¼����Ŀ���ļ����ص�ָ�����������Դ�ļ�Ϊ�ļ��������ļ���Ŀ¼�ṹ
REM call:createConvertFileList "Դ�ļ�/��" "�ص�������" ["Ŀ���ļ���(Ĭ��Դ�ļ�/��ͬ��Ŀ¼_new)"]
REM 	�ص�����: %1-Դ�ļ�, %2-Ŀ���ļ���
REM ERRORCODE: 1-ָ��Դ�ļ�������, 2-��������
:createConvertFileList
REM ��ʼ��
for %%a in (cCFL_srcFile, cCFL_baseDir, cCFL_descDir, cCFL_targetDir) do set "%%a="

REM ����У��
	REM Դ�ļ�/��
	set "cCFL_srcFile=%~1"
	if not defined cCFL_srcFile exit/b 2
	if not exist "%cCFL_srcFile%" exit/b 1
	REM �ص�������
	set "cCFL_callBackName=%~2"
	if not defined cCFL_callBackName exit/b 2
	REM Ŀ���ļ���
	set "cCFL_descDir=%~3"
	if not "%cCFL_descDir:~-1%"=="\" set "cCFL_descDir=%cCFL_descDir%\"

REM # ���ļ�����
if not exist "%cCFL_srcFile%\" (
	REM ��ת��·������ΪԴ�ļ�·�������ļ�����
	if not defined cCFL_DescDir set "cCFL_descDir=%~dpnx1"
	
	call %cCFL_callBackName% "%cCFL_srcFile%" "!cCFL_descDir!_new"
	
	goto createConvertFileListEnd
)

REM # Ŀ¼�ļ�����
REM ���ȫ·���н�ȡ��·������
set "cCFL_baseDir=%cCFL_srcFile%"
if not "%cCFL_baseDir:~-1%"=="\" set "cCFL_baseDir=%cCFL_baseDir%\"

if defined cCFL_descDir goto createConvertFileListFolder

REM ת�����Ŀ¼
set "cCFL_descDir=%~1"
if "%cCFL_descDir:~-1%"=="\" set "cCFL_descDir=%cCFL_descDir:~0,-1%"
set "cCFL_descDir=%cCFL_descDir%_new\"

REM Ŀ¼����ת��
:createConvertFileListFolder
for /r "%cCFL_srcFile%\" %%a in (*) do if exist "%%~a" (
	REM ��װ��·������Ϊԭ·�������ļ�����,��������ļ�����ƴ�ϵ����ļ�����
	set "cCFL_targetDir=%%~dpa"
	set "cCFL_targetDir=!cCFL_targetDir:%cCFL_baseDir%=!"
	
	call %cCFL_callBackName% "%%~a" "%cCFL_descDir%!cCFL_targetDir!"
)
:createConvertFileListEnd
exit/b 0

:end