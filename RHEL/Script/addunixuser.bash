# User Creation in Linux with Pssword Set to Expiry
#!/usr/bin/bash
# Purpose - Script to add a user to Linux system including passsword
# Author - Mevalal SAROJ - 18-Feb-2022 - Script Creation
# ------------------------------------------------------------------
# Am i Root user?
PASSWORD="pleasechangepassword"
if [ $(id -u) -eq 0 ]; then
  clear
  tput cup 5 20
  read -p "Enter USERNAME - What is username need to create ? " USERNAME
  egrep "^$USERNAME" /etc/passwd >/dev/null
  if [ $? -eq 0 ]; then
   tput cup 8 20
   echo "\e[1;31m $USERNAME exists! \e[0m"
   exit 1
  else
   useradd -m -p $(openssl passwd -1 ${PASSWORD}) -s /bin/bash -d /home/${USERNAME} -G sudo ${USERNAME}
   if [ $? -eq 0 ]; then
     tput cup 8 20
     echo "\e[1;32m User $USERNAME has been added to system! \n \e[0m"
     passwd -e ${USERNAME}
   else
     tput cup 10 20
     echo "\e[1;31m Failed to add a user $USERNAME! \e[0m"
   fi
 fi
else
 tput cup 10 20
 echo "\e[1;31m Only root may add a user to the system. \e[0m"
 exit 2
fi
