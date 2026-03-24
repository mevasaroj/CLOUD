# How to Change Hostname of Windows2019 & Windows2022 at restart
### A. Create the .bat file at C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup\
- vi C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup\hostname.bat
```hcl
@echo off
REM Use "IPv4 Address" for Windows 7+ or "IP Address" for older versions if needed
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4 Address"') do (
    set "IP_LINE=%%a"
)Hos

REM The extracted line will have a leading space, this removes it
set "IP_ADDR=%IP_LINE: =%"

:: Convert IP address format (10.40.14.138 -> 10-40-14-138)
set FORMATTED_IP=%IP_ADDR:.=-%

:: Construct the AWS standard hostname
set NEW_HOSTNAME=ip-%FORMATTED_IP%

:: Change the Hostname - Reboot Require
wmic computersystem where name="%computername%" call rename name="%NEW_HOSTNAME%"
```

### A. Set the .bat file at strtup menu
- 1. Press the **Windows Key + R** --> Type **gpedit.msc** --> Please enter
- 2. In the left pane, navigate to **Computer Configuration** --> Click **Windows Settings** --> Click **Scripts (Startup/Shutdown)** --> Double click **Startup**
- 3. Click on **Add**
      - Scrit Name = **C:\Windows\System32\GroupPolicy\Machine\Scripts\Startup\hostname.bat**
      - Script Parameters = **Hostname**
    
  4. Click on **OK**
  5. Click on **Apply** --> Click **OK**
  6. Close the gpedit.msc
  7. Reboot Server twice to change the hostname.

