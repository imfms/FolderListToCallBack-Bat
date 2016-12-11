@echo off
setlocal ENABLEDELAYEDEXPANSION

call:createConvertFileList "d:\user\desktop\通用框架·质地" ":showNew" "d:\user\desktop\新建文件夹"
echo=%errorlevel%

pause
exit/b 0

REM :-------------------------子程序区域-------------------------:
goto end

REM 显示新的
:showNew

echo=srcFile:"%~1", cCFL_descDir:"%~2"

exit/b 0


REM 根据指定文件、文件夹(遍历其中文件)和目标目录生成目标文件并回调指定方法，如果源文件为文件夹则保留文件夹目录结构
REM call:createConvertFileList "源文件/夹" "回调方法名" ["目标文件夹(默认源文件/夹同级目录_new)"]
REM 	回调参数: %1-源文件, %2-目标文件夹
REM ERRORCODE: 1-指定源文件不存在, 2-参数错误
:createConvertFileList
REM 初始化
for %%a in (cCFL_srcFile, cCFL_baseDir, cCFL_descDir, cCFL_targetDir) do set "%%a="

REM 参数校验
	REM 源文件/夹
	set "cCFL_srcFile=%~1"
	if not defined cCFL_srcFile exit/b 2
	if not exist "%cCFL_srcFile%" exit/b 1
	REM 回调方法名
	set "cCFL_callBackName=%~2"
	if not defined cCFL_callBackName exit/b 2
	REM 目标文件夹
	set "cCFL_descDir=%~3"
	if not "%cCFL_descDir:~-1%"=="\" set "cCFL_descDir=%cCFL_descDir%\"

REM # 单文件处理
if not exist "%cCFL_srcFile%\" (
	REM 将转换路径设置为源文件路径下新文件夹内
	if not defined cCFL_DescDir set "cCFL_descDir=%~dpnx1"
	
	call %cCFL_callBackName% "%cCFL_srcFile%" "!cCFL_descDir!_new"
	
	goto createConvertFileListEnd
)

REM # 目录文件处理
REM 相对全路径中截取子路径变量
set "cCFL_baseDir=%cCFL_srcFile%"
if not "%cCFL_baseDir:~-1%"=="\" set "cCFL_baseDir=%cCFL_baseDir%\"

if defined cCFL_descDir goto createConvertFileListFolder

REM 转换结果目录
set "cCFL_descDir=%~1"
if "%cCFL_descDir:~-1%"=="\" set "cCFL_descDir=%cCFL_descDir:~0,-1%"
set "cCFL_descDir=%cCFL_descDir%_new\"

REM 目录遍历转换
:createConvertFileListFolder
for /r "%cCFL_srcFile%\" %%a in (*) do if exist "%%~a" (
	REM 将装换路径设置为原路径下新文件夹内,如果有子文件夹则拼合到新文件夹下
	set "cCFL_targetDir=%%~dpa"
	set "cCFL_targetDir=!cCFL_targetDir:%cCFL_baseDir%=!"
	
	call %cCFL_callBackName% "%%~a" "%cCFL_descDir%!cCFL_targetDir!"
)
:createConvertFileListEnd
exit/b 0

:end