@ECHO OFF
SETLOCAL

:SetParams
SET node=stratum
SET device=GPU
SET platform=<0...n>
SET card=<0...n>
SET host=<host>
SET port=<port>
SET wallet=<wallet>
SET worker=<worker>
SET timeout=<seconds>

:RunYiimp
SET minerbin=DynMiner2.exe
SET diff=<2...n>
SET password=d=%diff%
SET compute=<1024...n>
SET workitems=<32,64,128,256,512>
SET params=-mode %node% -server %host% -port %port% -user %wallet%.%worker% -pass %password% -miner %device%,%compute%,%workitems%,%platform%,%card%
ECHO Starting %minerbin% %node% instance on %device% at %host% to %wallet%
START /MIN "Yiimp Miner" %minerbin% %params%
TIMEOUT /T %timeout%
taskkill /F /IM %minerbin%
GOTO RunYiimp

ENDLOCAL
EXIT /B 2