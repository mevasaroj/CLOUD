####################### Shell Script for Update the password expiry   #############"
# Developed by                  :       Mevalal Saroj (Cloud Team)
# Version                               :       1.0
# Script will change the password before 20 days of expiry
#################################################################################
#!/bin/bash

DATE=`date -d "+20 days" +%Y%m%d`

for USERNAME in `grep /bin/bash /etc/passwd | cut -d: -f1 | egrep -v "ssm-user"`
do
 USER=`chage -l "${USERNAME}" |grep -i "password expir" |grep -v warning |awk -F : {'print $2'}`
 EXPIRY=`date -d "${USER}" +%Y%m%d`

  if [ "${EXPIRY}" = "${DATE}" ]; then
        chage --maxdays 365 $USERNAME
        echo -e "$USERNAME:hdfcbank123$" | sudo chpasswd  2>&1 /dev/null
  elif expr "${EXPIRY}" "<" "${DATE}" >/dev/null; then
        chage --maxdays 365 $USERNAME
        echo -e "$USERNAME:hdfcbank123$" | sudo chpasswd  2>&1 /dev/null
  fi

done
