@echo off
rem ***************************************************
rem Script used to zip all .prpt relative directory to .prpt file 
rem To use it when you make a simple fix to xml file and you want to rebuild prpt file
rem ***************************************************
rem 
rem http://rkj.github.io/mercurial/2010/05/26/Mercurial-PreCommitAddFiles.html
rem https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-xp/bb490909(v=technet.10)
rem set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_161
set JAR_PATH=\bin\jar.exe

rem check if exist jar utility
if not exist "%JAVA_HOME%%JAR_PATH%" (
    echo ERRORE NON ESISTE il percorso : %JAVA_HOME%%JAR_PATH%
	exit \B 1
)


setlocal

IF "%~1"=="" (	
	echo "NESSUN PARAMERTRO"
) ELSE (
	cd %~1
)

echo zip files .prpt in directory %CD%
pause


rem iterate only on file *prpt added or modified 
rem FOR  /F %%f in ('hg status -nam "glob:**.prpt"') do (
for /R %%f in (.\*.prpt) do (	

	rem save directory to stack
	pushd %~dp0
	
	rem create if not exist unpacked report dir 
	if exist "%%~pf%%~nf" (
		rem echo %%f
		rem echo "%%~pf"
		echo rezip file: "%%~ff"
		rem echo "%%~nf"
		rem echo "%%~xf"
		rem echo "%%~sf"
		rem echo "%%~nxf"
		cd "%%~pf%%~nf"
		"%JAVA_HOME%%JAR_PATH%" cfnM "../%%~nxf" .
		rem pause
		rem dir
	)
		
	rem move to unpacked report dir to unzip 
	rem cd "%%~pf%%~nf"
	
	rem unzip witha jar utils
	rem "%JAVA_HOME%%JAR_PATH%" xf "%%~ff"
	rem "%JAVA_HOME%%JAR_PATH%" cfnM ../LQ5.zip .
	
	popd
)
endlocal


