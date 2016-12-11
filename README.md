`V0.1` `20161211`
# FolderListToRun-Bat

根据指定的源目录、目标目录、回调方法名，将源目录中的文件及目录结构处理后传输到回调方法中

## 使用方法

### 语法
	CALL:folderListToCallBack "源文件/夹" "回调方法名" ["目标文件夹(默认源文件/夹同级目录_new)"]

### ERRORCODE
- `0` 执行期间未发现问题
- `1` 指定源目录不存在
- `2` 参数错误

## 使用示例

> 遍历`C:\eg`目录文件结构到`D:\eg`, 将内容在回调方法`:showDetails`中显示出来

- 用例
	
		CALL:folderListToCallBack "C:\eg" ":showDetails" "D:\eg"

- 批处理文件

		@echo off
		setlocal ENABLEDELAYEDEXPANSION

		call:folderListToCallBack "c:\eg" ":showDetails" "d:\eg"

		REM :-------------------------子程序区域-------------------------:
		goto end

		REM 被回调子程序
		:showDetails
		echo=srcFile:"%~1", targetFile:"%~2\%~nx1"
		exit/b 0

		REM 本子程序
		:folderListToCallBack
			REM 本子程序内容
		exit/b 0

		:end
		REM :-------------------------子程序结束-------------------------:

		pause

- 执行结果

		srcFile:"c:\eg\SLK2MP3.bat", targetFile:"d:\eg\SLK2MP3.bat"
		srcFile:"c:\eg\SLK2MP3_FAST.bat", targetFile:"d:\eg\SLK2MP3_FAST.bat"
		srcFile:"c:\eg\SLK2WAV.bat", targetFile:"d:\eg\SLK2WAV.bat"
		srcFile:"c:\eg\SLK2WAV_FAST.bat", targetFile:"d:\eg\SLK2WAV_FAST.bat"
		srcFile:"c:\eg\bin\convert.bat", targetFile:"d:\eg\bin\convert.bat"
		srcFile:"c:\eg\bin\pcm2wav.exe", targetFile:"d:\eg\bin\pcm2wav.exe"
		srcFile:"c:\eg\bin\slk2pcm.exe", targetFile:"d:\eg\bin\slk2pcm.exe"
		srcFile:"c:\eg\bin\split.exe", targetFile:"d:\eg\bin\split.exe"
		srcFile:"c:\eg\test\TestAudio.slk", targetFile:"d:\eg\test\TestAudio.slk"
		srcFile:"c:\eg\tool\FileName2CreateTime.bat", targetFile:"d:\eg\tool\FileName2CreateTime.bat"

## 相关链接

