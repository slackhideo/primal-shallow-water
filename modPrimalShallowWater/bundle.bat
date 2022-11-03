@ECHO OFF
SETLOCAL
SET "wcc_lite_path=Script Merger v0.6.5\Tools\wcc_lite\bin\x64"
SET "source=modPrimalShallowWater\content\bundles"
SET "outdir=The Witcher 3 Wild Hunt GOTY\dlc\dlcPrimalShallowWater\content"
CD "%wcc_lite_path%"
wcc_lite.exe pack -dir="%source%" -outdir="%outdir%"
wcc_lite.exe metadatastore -path="%outdir%"
ENDLOCAL