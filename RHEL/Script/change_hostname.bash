
# Below Script will run command on Remote Server
#!/bin/bash
 
# AWS Standard Hostname Configuration Script for RHEL 9.5
# This script sets the hostname to AWS standard format: ip-xx-xx-xx-xx.region.compute.internal
 
set -e
 
echo "=== AWS Standard Hostname Configuration ==="
echo "Starting hostname configuration..."
 
# Get the instance's private IP address
PRIVATE_IP=$(hostname -I | awk '{print $1}')
 
if [ -z "$PRIVATE_IP" ]; then
    echo "ERROR: Could not determine private IP address"
    exit 1
fi
 
echo "Detected Private IP: $PRIVATE_IP"
 
# Get the AWS region from instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" 2>/dev/null)
REGION=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/region 2>/dev/null)
 
# Fallback to ap-south-1 if metadata service is unavailable
if [ -z "$REGION" ]; then
    echo "WARNING: Could not determine region from metadata, using ap-south-1 as default"
    REGION="ap-south-1"
fi
 
echo "Detected Region: $REGION"
 
# Convert IP address format ([IP_ADDRESS] -> [IP_ADDRESS])
IP_FORMATTED=$(echo $PRIVATE_IP | tr '.' '-')
 
# Construct the AWS standard hostname
NEW_HOSTNAME="ip-${IP_FORMATTED}.${REGION}.compute.internal"
 
echo "New Hostname: $NEW_HOSTNAME"
 
# Set the hostname using hostnamectl
echo "Setting hostname..."
hostnamectl set-hostname "$NEW_HOSTNAME"
 
# Update /etc/hostname
echo "$NEW_HOSTNAME" > /etc/hostname
 
# Verify the change
echo ""
echo "=== Verification ==="
echo "Current hostname: $(hostname)"
echo "Static hostname: $(hostnamectl status | grep 'Static hostname' | awk '{print $3}')"
echo ""
echo "✓ Hostname configuration completed successfully!"
