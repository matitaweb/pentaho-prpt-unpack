@echo off
rem ***************************************************
rem Script used to unzip .prpt file in pre-commit hook 
rem To use it:
rem 1) create file .hg\hgrc 
rem 2) write in file .hg\hgrc 
rem [hooks]
rem pre-commit = precommitunzip.bat
rem ***************************************************
rem 
rem http://rkj.github.io/mercurial/2010/05/26/Mercurial-PreCommitAddFiles.html
rem https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-xp/bb490909(v=technet.10)
set JAR_PATH=%CD%\bin\jar.exe

rem check if exist jar utility
if not exist "%JAR_PATH%" (
    echo ERRORE NON ESISTE il percorso : %JAR_PATH%
	exit \B 1
)

rem save directory to stack


rem iterate only on file *prpt added or modified 
FOR /F delims^=^ eol^= %%f in ('hg status -nam "glob:**.prpt"') do (
	
	pushd %~dp0
	rem echo %%~ff
	rem echo %%~f

		
	rem create if not exist unpacked report dir 
	if not exist "%%~pf%%~nf" mkdir "%%~pf%%~nf"
	
	rem move to unpacked report dir to unzip 
	cd "%%~pf%%~nf"
	
	rem unzip witha jar utils
	"%JAR_PATH%" xf "%%~ff"
	
	rem add directory to hg
	hg add -q * "%%~pf%%~nf"
	popd
)

exit \B 0



