@echo off
setlocal ENABLEDELAYEDEXPANSION

call:folderListToCallBack "d:\user\desktop\QQ_SLK2WAV" ":showNew" "d:\user\desktop\�½��ļ��� ()"
echo=%errorlevel%

pause
exit/b 0

REM :-------------------------�ӳ�������-------------------------:
goto end

REM ���ص��ӳ���
:showNew

echo=%*

exit/b 0


REM ����ָ���ļ����ļ���(���������ļ�)��Ŀ��Ŀ¼����Ŀ���ļ����ص�ָ�����������Դ�ļ�Ϊ�ļ��������ļ���Ŀ¼�ṹ
REM call:folderListToCallBack "Դ�ļ�/��" "�ص�������" ["Ŀ���ļ���(Ĭ��Դ�ļ�/��ͬ��Ŀ¼_new)"]
REM 	�ص�����: %1-Դ�ļ�, %2-Ŀ���ļ���
REM ERRORCODE: 1-ָ��Դ�ļ�������, 2-��������
:folderListToCallBack
REM ��ʼ��
for %%a in (fLTCB_srcFile, fLTCB_baseDir, fLTCB_descDir, fLTCB_targetDir) do set "%%a="

REM ����У��
	REM Դ�ļ�/��
	set "fLTCB_srcFile=%~1"
	if not defined fLTCB_srcFile exit/b 2
	if not exist "%fLTCB_srcFile%" exit/b 1
	REM �ص�������
	set "fLTCB_callBackName=%~2"
	if not defined fLTCB_callBackName exit/b 2
	REM Ŀ���ļ���
	set "fLTCB_descDir=%~3"
	if not "%fLTCB_descDir:~-1%"=="\" set "fLTCB_descDir=%fLTCB_descDir%\"

REM # ���ļ�����
if not exist "%fLTCB_srcFile%\" (
	REM ��ת��·������ΪԴ�ļ�·�������ļ�����
	if not defined fLTCB_DescDir set "fLTCB_descDir=%~dpnx1"
	
	call %fLTCB_callBackName% "%fLTCB_srcFile%" "!fLTCB_descDir!_new"
	
	goto folderListToCallBackEnd
)

REM # Ŀ¼�ļ�����
REM ���ȫ·���н�ȡ��·������
set "fLTCB_baseDir=%fLTCB_srcFile%"
if not "%fLTCB_baseDir:~-1%"=="\" set "fLTCB_baseDir=%fLTCB_baseDir%\"

if defined fLTCB_descDir goto folderListToCallBackFolder

REM ת�����Ŀ¼
set "fLTCB_descDir=%~1"
if "%fLTCB_descDir:~-1%"=="\" set "fLTCB_descDir=%fLTCB_descDir:~0,-1%"
set "fLTCB_descDir=%fLTCB_descDir%_new\"

REM Ŀ¼����ת��
:folderListToCallBackFolder
for /r "%fLTCB_srcFile%\" %%a in (*) do if exist "%%~a" (
	REM ��װ��·������Ϊԭ·�������ļ�����,��������ļ�����ƴ�ϵ����ļ�����
	set "fLTCB_targetDir=%%~dpa"
	set "fLTCB_targetDir=!fLTCB_targetDir:%fLTCB_baseDir%=!"
	
	call %fLTCB_callBackName% "%%~a" "%fLTCB_descDir%!fLTCB_targetDir!"
)
:folderListToCallBackEnd
exit/b 0

:end