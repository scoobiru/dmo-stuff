@ECHO OFF
SETLOCAL

:SetParams
SET node=solo
SET device=GPU
SET platform=<0...n>
SET card=<0...n>
SET host=http://<host>:<port>/
SET user=<user>
SET password=<password>
SET wallet=<wallet>

:RunSolo
SET minerbin=DynMiner2.exe
SET compute=<1024...n>
SET workitems=<32,64,128,256,512>
ECHO Starting %minerbin% %node% instance on %device% at %host% to %wallet%
SET params=-mode %node% -server %host% -user %user% -pass %password% -wallet %wallet% -miner %device%,%compute%,%workitems%,%platform%,%card%
START /MIN "Solo Miner" %minerbin% %params%
TIMEOUT /T <seconds>
taskkill /F /IM %minerbin%
GOTO RunSolo

ENDLOCAL
EXIT /B 2