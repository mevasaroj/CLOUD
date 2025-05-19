# Below Script will run command on Remote Server
#!/usr/bin/bash
# Author: Mevalal SAROJ
# Date: 16-May-2023
# This script is use to copy and install the RPM on remote server.
#
# Read the ServerNames from Properties file
for server in `cat server`
do
sshpass -p "hdfcbank123$" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l hdfcbank $server sudo mkdir -p /opt/RPM
sshpass -p "hdfcbank123$" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l hdfcbank $server sudo ls -l /opt/
sshpass -p "hdfcbank123$" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l hdfcbank $server sudo chown hdfcbank:hdfcbank -R /opt/RPM/
sshpass -p "hdfcbank123$" scp -r -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no /opt/RPM/nmap-ncat-6.40-13.amzn2.x86_64.rpm hdfcbank@${server}:/opt/RPM/
sshpass -p "hdfcbank123$" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l hdfcbank $server sudo rpm -ivh /opt/RPM/nmap-ncat-6.40-13.amzn2.x86_64.rpm
sshpass -p "hdfcbank123$" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l hdfcbank $server sudo nc -zv 10.196.137.208 22
done
