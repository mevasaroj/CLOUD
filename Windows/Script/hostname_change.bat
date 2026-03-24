:: Below Script to Change the Hostname in Windows-2019 and Windows-2022
@echo off
REM Use "IPv4 Address" for Windows 7+ or "IP Address" for older versions if needed
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4 Address"') do (
    set "IP_LINE=%%a"
)

REM The extracted line will have a leading space, this removes it
set "IP_ADDR=%IP_LINE: =%"

:: Convert IP address format (10.40.14.138 -> 10-40-14-138)
set FORMATTED_IP=%IP_ADDR:.=-%

:: Construct the AWS standard hostname
set NEW_HOSTNAME=ip-%FORMATTED_IP%

:: Change the Hostname - Reboot Require
wmic computersystem where name="%computername%" call rename name="%NEW_HOSTNAME%"

:: =========================== OR ===============================

@echo off
:: Fetching the IP Address
REM Use "IPv4 Address" for Windows 7+ or "IP Address" for older versions if needed
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4 Address"') do (
    set "IP_LINE=%%a"
)

REM The extracted line will have a leading space, this removes it
set "IP_ADDR=%IP_LINE: =%"

:: Fetching AWS Region 
:: 1 Get current AWS region from CLI config
for /f "tokens=*" %%i in ('aws configure get region 2^>nul') do set AWS_REGION=%%i

:: 2. If empty, check fetch from metadata
if "%AWS_REGION%"=="" (
    for /f "tokens=*" %%a in ('curl -s http://169.254.169.254/latest/meta-data/placement/region') do set AWS_REGION=%%a
)

:: 3. If empty, check AWS commands
if "%AWS_REGION%"=="" (
    for /f "tokens=*" %%a in ('aws configure list ^| findstr /B "region"') do set AWS_REGION=%%a
)

:: 4. If empty, check AWS ec2 command
if "%AWS_REGION%"=="" (
    for /f "tokens=*" %%a in ('aws ec2 describe-availability-zones --output text --query "AvailabilityZones[0].[RegionName]" 2^>nul') do set AWS_REGION=%%a
)

:: If variable is empty, set default to ap-south-1
if "%AWS_REGION%"=="" (
    echo Region not found. Defaulting to ap-south-1.
    set AWS_REGION=ap-south-1
)

:: Convert IP address format (10.40.14.138 -> 10-40-14-138)
set FORMATTED_IP=%IP_ADDR:.=-%

:: Construct the AWS standard hostname
set NEW_HOSTNAME=ip-%FORMATTED_IP%

:: Change the Hostname - Reboot Require
wmic computersystem where name="%computername%" call rename name="%NEW_HOSTNAME%"
