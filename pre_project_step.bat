@echo off
setlocal

set "SCRIPT_DIR=%~dp0"

cd %SCRIPT_DIR%

for /f "delim=" %%H in ('git rev-parse --short HEAD') do set GIT_COMMIT_ID=%%H

for /f "delim=" %%T in ('git log -1 --format=%%at') do set GIT_UNIX_TIMESTAMP=%%T

(
  echo #macro GIT_COMMIT_ID "%GIT_COMMIT_ID%"
  echo #macro GIT_UNIX_TIMESTAMP "%GIT_UNIX_TIMESTAMP%"
) > "%SCRIPT_DIR%scripts/scrGitConstants/scrGitConstants.gml"

endlocal