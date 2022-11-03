@ECHO OFF
SETLOCAL
SET "w3strings_path=w3strings encoder 0.4.1"
SET "input_dir=modPrimalShallowWater\localization"
SET "input_file=en.csv"
SET "id=7071"
CD "%w3strings_path%"
w3strings.exe --encode "%input_dir%\%input_file%" --id-space "%id%"
MOVE /Y "%input_dir%\%input_file%.w3strings" "%input_dir%"\..\content\en.w3strings
MOVE /Y "%input_dir%\%input_file%.w3strings.ws" "%input_dir%"\..\content\scripts\
ENDLOCAL