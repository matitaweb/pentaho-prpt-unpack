echo off
rem ***************************************************
rem Script used to unzip .prpt file before commit
rem To use it:
rem 1) launch before commit
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

rem save directory to stack
pushd %~dp0

rem iterate only on file *prpt added or modified 
rem FOR  /F %%f in ('hg status -nam "glob:**.prpt"') do (
for /R %%f in (.\*.prpt) do (	
	rem create if not exist unpacked report dir 
	if not exist "%%~pf%%~nf" mkdir "%%~pf%%~nf"
	
	rem move to unpacked report dir to unzip 
	cd "%%~pf%%~nf"
	
	rem unzip witha jar utils
	"%JAVA_HOME%%JAR_PATH%" xf "%%~ff"
	
	rem add directory to hg
	hg add -q * "%%~pf%%~nf"
)

popd

