@echo off
setlocal ENABLEDELAYEDEXPANSION

call:folderListToCallBack "d:\user\desktop\QQ_SLK2WAV" ":showNew" "d:\user\desktop\新建文件夹 ()"
echo=%errorlevel%

pause
exit/b 0

REM :-------------------------子程序区域-------------------------:
goto end

REM 被回调子程序
:showNew

echo=%*

exit/b 0


REM 根据指定文件、文件夹(遍历其中文件)和目标目录生成目标文件并回调指定方法，如果源文件为文件夹则保留文件夹目录结构
REM call:folderListToCallBack "源文件/夹" "回调方法名" ["目标文件夹(默认源文件/夹同级目录_new)"]
REM 	回调参数: %1-源文件, %2-目标文件夹
REM ERRORCODE: 1-指定源文件不存在, 2-参数错误
:folderListToCallBack
REM 初始化
for %%a in (fLTCB_srcFile, fLTCB_baseDir, fLTCB_descDir, fLTCB_targetDir) do set "%%a="

REM 参数校验
	REM 源文件/夹
	set "fLTCB_srcFile=%~1"
	if not defined fLTCB_srcFile exit/b 2
	if not exist "%fLTCB_srcFile%" exit/b 1
	REM 回调方法名
	set "fLTCB_callBackName=%~2"
	if not defined fLTCB_callBackName exit/b 2
	REM 目标文件夹
	set "fLTCB_descDir=%~3"
	if not "%fLTCB_descDir:~-1%"=="\" set "fLTCB_descDir=%fLTCB_descDir%\"

REM # 单文件处理
if not exist "%fLTCB_srcFile%\" (
	REM 将转换路径设置为源文件路径下新文件夹内
	if not defined fLTCB_DescDir set "fLTCB_descDir=%~dpnx1"
	
	call %fLTCB_callBackName% "%fLTCB_srcFile%" "!fLTCB_descDir!_new"
	
	goto folderListToCallBackEnd
)

REM # 目录文件处理
REM 相对全路径中截取子路径变量
set "fLTCB_baseDir=%fLTCB_srcFile%"
if not "%fLTCB_baseDir:~-1%"=="\" set "fLTCB_baseDir=%fLTCB_baseDir%\"

if defined fLTCB_descDir goto folderListToCallBackFolder

REM 转换结果目录
set "fLTCB_descDir=%~1"
if "%fLTCB_descDir:~-1%"=="\" set "fLTCB_descDir=%fLTCB_descDir:~0,-1%"
set "fLTCB_descDir=%fLTCB_descDir%_new\"

REM 目录遍历转换
:folderListToCallBackFolder
for /r "%fLTCB_srcFile%\" %%a in (*) do if exist "%%~a" (
	REM 将装换路径设置为原路径下新文件夹内,如果有子文件夹则拼合到新文件夹下
	set "fLTCB_targetDir=%%~dpa"
	set "fLTCB_targetDir=!fLTCB_targetDir:%fLTCB_baseDir%=!"
	
	call %fLTCB_callBackName% "%%~a" "%fLTCB_descDir%!fLTCB_targetDir!"
)
:folderListToCallBackEnd
exit/b 0

:end