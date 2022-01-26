@ECHO OFF
SETLOCAL

::Params, fill in <> with chosen values
SET mode=stratum
SET device=GPU
SET platform=<0...n>
SET card=<0...n>
SET host=<host>
SET port=<port>
SET wallet=<wallet>
SET worker=<worker>
SET timeout=<seconds>

::All variables set within the RunSolo loop can be changed without restarting script, press a key in the loop script window to kill and restart miner with new params
::Move any variables from above into loop to also allow this adjustment
:RunStratum
SET minerbin=DynMiner2.exe
SET diff=<2...n>
SET password=d=%diff%
SET compute=<1024...n>
SET workitems=<32,64,128,256,512>
::Optional loops param
SET loops=<2-10>

::Choose minername and param depending on use of loops
SET minername=%host% : %minerbin% - %compute%,%workitems%
SET params=-mode %mode% -server %host% -port %port% -user %wallet%.%worker% -pass %password% -miner %device%,%compute%,%workitems%,%platform%,%card%
::Comment out above two lines and uncomment following two lines for loops
::SET minername=%host% : %minerbin% - %compute%,%workitems%,loops:%loops%
::SET params=-mode %mode% -server %host% -port %port% -user %wallet%.%worker% -pass %password% -miner %device%,%compute%,%workitems%,%platform%,%card%,%loops%

::Messaging and start
ECHO Starting %minerbin% %mode% instance on %device% at %host% to %wallet%
ECHO Params: %params%
START /MIN "%minername%" %minerbin% %params%
TIMEOUT /T %timeout%
taskkill /F /IM %minerbin%
GOTO RunStratum

ENDLOCAL
EXIT