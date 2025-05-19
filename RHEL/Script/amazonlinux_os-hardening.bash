####################### Shell Script for Amazon Linux 2 OS Baselining #######################"
# Developed by 			: 	Mevalal Saroj (Cloud Team)
# Version 				: 	1.0
# Total Baseline Points : 	140
###########################################################################################


############### Function to check the File exists or not
file_status()
{
	if [[ -f "$1"  ]]
	then
		status=1
	else
		status=0
	fi
}

############## User input for remediation required or not - in case of 'no' only report will be generated
read -p "Require Remediation(yes/no) : " require_remediation


############## Main Shell Script to perform the Check/Remediation task (Basis on the remediation require/not-required)

echo
echo "############################# Point 2: Ensure /tmp is configured #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		tmp_part=$(grep -w /tmp /etc/fstab | awk '{print $2}')
		if [[ "$tmp_part" == "/tmp" ]]
		then
				echo "Compliant (Action Not Required)"
				findmnt /tmp
		else
				echo "Not Compliant (Manual Intervention Required) - '/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 3: Ensure noexec option set on /tmp partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		tmp_part=$(grep -w /tmp /etc/fstab | awk '{print $2}')
		if [[ "$tmp_part" == "/tmp" ]]
		then
				tmp_part_option_noexec=$(grep -w "/tmp" /etc/fstab | awk '{print $4}' | grep -wo 'noexec')
				if [[ "$tmp_part_option_noexec" == "noexec" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/tmp" /etc/fstab)"
				else
						tmp_part_options=$(grep -w "/tmp" /etc/fstab | awk '{print $4}')
						tmp_part_options_count=$(grep -w "/tmp" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$tmp_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$tmp_part_options' modifying_line:'$tmp_part_options,noexec' file:/etc/fstab"
										sed -i "/[[:blank:]]\/tmp[[:blank:]]/s/$tmp_part_options/$tmp_part_options,noexec/" /etc/fstab
										mount -o remount,noexec /tmp
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$tmp_part_options' file:'/etc/fstab"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$tmp_part_options' file:/etc/fstab"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi


echo
echo "############################# Point 4: Ensure nodev option set on /tmp partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		tmp_part=$(grep -w /tmp /etc/fstab | awk '{print $2}')
		if [[ "$tmp_part" == "/tmp" ]]
		then
				tmp_part_option_nodev=$(grep -w "/tmp" /etc/fstab | awk '{print $4}' | grep -wo 'nodev')
				if [[ "$tmp_part_option_nodev" == "nodev" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/tmp" /etc/fstab)"
				else
						tmp_part_options=$(grep -w "/tmp" /etc/fstab | awk '{print $4}')
						tmp_part_options_count=$(grep -w "/tmp" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$tmp_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$tmp_part_options' modifying_line:'$tmp_part_options,nodev' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/tmp[[:blank:]]/s/$tmp_part_options/$tmp_part_options,nodev/" /etc/fstab
										mount -o remount,nodev /tmp
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$tmp_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$tmp_part_options' file:'/etc/fstab"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 5: Ensure nosuid option set on /tmp partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		tmp_part=$(grep -w /tmp /etc/fstab | awk '{print $2}')
		if [[ "$tmp_part" == "/tmp" ]]
		then
				tmp_part_option_nosuid=$(grep -w "/tmp" /etc/fstab | awk '{print $4}' | grep -wo 'nosuid')
				if [[ "$tmp_part_option_nosuid" == "nosuid" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/tmp" /etc/fstab)"
				else
						tmp_part_options=$(grep -w "/tmp" /etc/fstab | awk '{print $4}')
						tmp_part_options_count=$(grep -w "/tmp" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$tmp_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$tmp_part_options' modifying_line:'$tmp_part_options,nosuid' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/tmp[[:blank:]]/s/$tmp_part_options/$tmp_part_options,nosuid/" /etc/fstab
										mount -o remount,nosuid /tmp
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$tmp_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$tmp_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 6: Ensure /dev/shm is configured #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		dev_shm_part=$(grep -w /dev/shm /etc/fstab | awk '{print $2}')
		if [[ "$dev_shm_part" == "/dev/shm" ]]
		then
				echo "Compliant (Action Not Required)"
				findmnt /dev/shm
		else
				echo "Not Compliant (Manual Intervention Required) - '/dev/shm' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 7: Ensure noexec option set on /dev/shm partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		dev_shm_part=$(grep -w /dev/shm /etc/fstab | awk '{print $2}')
		if [[ "$dev_shm_part" == "/dev/shm" ]]
		then
				dev_shm_part_option_noexec=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}' | grep -wo 'noexec')
				if [[ "$dev_shm_part_option_noexec" == "noexec" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/dev/shm" /etc/fstab)"
				else
						dev_shm_part_options=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}')
						dev_shm_part_options_count=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$dev_shm_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$dev_shm_part_options' modifying_line:'$dev_shm_part_options,noexec' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/dev\/shm[[:blank:]]/s/$dev_shm_part_options/$dev_shm_part_options,noexec/" /etc/fstab
										mount -o remount,noexec /dev/shm
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$dev_shm_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$dev_shm_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/dev/shm' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 8: Ensure nodev option set on /dev/shm partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		dev_shm_part=$(grep -w /dev/shm /etc/fstab | awk '{print $2}')
		if [[ "$dev_shm_part" == "/dev/shm" ]]
		then
				dev_shm_part_option_nodev=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}' | grep -wo 'nodev')
				if [[ "$dev_shm_part_option_nodev" == "nodev" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/dev/shm" /etc/fstab)"
				else
						dev_shm_part_options=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}')
						dev_shm_part_options_count=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$dev_shm_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$dev_shm_part_options' modifying_line:'$dev_shm_part_options,nodev' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/dev\/shm[[:blank:]]/s/$dev_shm_part_options/$dev_shm_part_options,nodev/" /etc/fstab
										mount -o remount,nodev /dev/shm
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$dev_shm_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$dev_shm_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/dev/shm' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 9: Ensure nosuid option set on /dev/shm partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		dev_shm_part=$(grep -w /dev/shm /etc/fstab | awk '{print $2}')
		if [[ "$dev_shm_part" == "/dev/shm" ]]
		then
				dev_shm_part_option_nosuid=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}' | grep -wo 'nosuid')
				if [[ "$dev_shm_part_option_nosuid" == "nosuid" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/dev/shm" /etc/fstab)"
				else
						dev_shm_part_options=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}')
						dev_shm_part_options_count=$(grep -w "/dev/shm" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$dev_shm_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$dev_shm_part_options' modifying_line:'$dev_shm_part_options,nosuid' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/dev\/shm[[:blank:]]/s/$dev_shm_part_options/$dev_shm_part_options,nosuid/" /etc/fstab
										mount -o remount,nosuid /dev/shm
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$dev_shm_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$dev_shm_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/dev/shm' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 10: Ensure /var/tmp partition includes the noexec option #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		var_tmp_part=$(grep -w /var/tmp /etc/fstab | awk '{print $2}')
		if [[ "$var_tmp_part" == "/var/tmp" ]]
		then
				var_tmp_part_option_noexec=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}' | grep -wo 'noexec')
				if [[ "$var_tmp_part_option_noexec" == "noexec" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/var/tmp" /etc/fstab)"
				else
						var_tmp_part_options=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}')
						var_tmp_part_options_count=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$var_tmp_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$var_tmp_part_options' modifying_line:'$var_tmp_part_options,noexec' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/var\/tmp[[:blank:]]/s/$var_tmp_part_options/$var_tmp_part_options,noexec/" /etc/fstab
										mount -o remount,noexec /var/tmp
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$var_tmp_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$var_tmp_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/var/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 11: Ensure nodev option set on /var/tmp partition #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		var_tmp_part=$(grep -w /var/tmp /etc/fstab | awk '{print $2}')
		if [[ "$var_tmp_part" == "/var/tmp" ]]
		then
				var_tmp_part_option_nodev=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}' | grep -wo 'nodev')
				if [[ "$var_tmp_part_option_nodev" == "nodev" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/var/tmp" /etc/fstab)"
				else
						var_tmp_part_options=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}')
						var_tmp_part_options_count=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$var_tmp_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$var_tmp_part_options' modifying_line:'$var_tmp_part_options,nodev' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/var\/tmp[[:blank:]]/s/$var_tmp_part_options/$var_tmp_part_options,nodev/" /etc/fstab
										mount -o remount,nodev /var/tmp
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$var_tmp_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$var_tmp_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/var/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 12: Ensure /var/tmp partition includes the nosuid option #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		var_tmp_part=$(grep -w /var/tmp /etc/fstab | awk '{print $2}')
		if [[ "$var_tmp_part" == "/var/tmp" ]]
		then
				var_tmp_part_option_nosuid=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}' | grep -wo 'nosuid')
				if [[ "$var_tmp_part_option_nosuid" == "nosuid" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/var/tmp" /etc/fstab)"
				else
						var_tmp_part_options=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}')
						var_tmp_part_options_count=$(grep -w "/var/tmp" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$var_tmp_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$var_tmp_part_options' modifying_line:'$var_tmp_part_options,nosuid' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/var\/tmp[[:blank:]]/s/$var_tmp_part_options/$var_tmp_part_options,nosuid/" /etc/fstab
										mount -o remount,nosuid /var/tmp
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$var_tmp_part_options' file:/etc/fstab"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$var_tmp_part_options' file:'/etc/fstab'"
						fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/var/tmp' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi


echo
echo "############################# Point 13: Ensure /home partition includes the nodev option #############################"
file_status "/etc/fstab"
if [[ "$status" == 1 ]]
then
		home_part=$(grep -w /home /etc/fstab | awk '{print $2}')
		if [[ "$home_part" == "/home" ]]
		then
				home_part_option_nodev=$(grep -w "/home" /etc/fstab | awk '{print $4}' | grep -wo 'nodev')
				if [[ "$home_part_option_nodev" == "nodev" ]]
				then
						echo "Compliant (Action Not Required) - $(grep -w "/home" /etc/fstab)"
				else
						home_part_options=$(grep -w "/home" /etc/fstab | awk '{print $4}')
						home_part_options_count=$(grep -w "/home" /etc/fstab | awk '{print $4}' | wc -l)
						if [ "$require_remediation" == "yes" ]
						then
								if [ "$home_part_options_count" -eq 1 ]
								then
										echo "Not Compliant (Remediating) - current_options:'$home_part_options' modifying_line:'$home_part_options,nodev' file:'/etc/fstab'"
										sed -i "/[[:blank:]]\/home[[:blank:]]/s/$home_part_options/$home_part_options,nodev/" /etc/fstab
										mount -o remount,nodev /home
								else
										echo "Not Compliant (Manual Intervention Required) - current_options:'$home_part_options' file:'/etc/fstab'"
								fi
						else
								echo "Not Compliant (Action Required) - current_options:'$home_part_options' file:'/etc/fstab'"

								fi
				fi
		else
				echo "Not Compliant (Manual Intervention Required) - '/home' not found in '/etc/fstab'"
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/fstab' file not found"
fi

echo
echo "############################# Point 17: Ensure sticky bit is set on all world-writable directories #############################"
if [[ "$(df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | wc -l)" -ge 1 ]]
then
	df --local -P 2> /dev/null | awk '{if (NR!=1) print $6}' | xargs -I '{}' find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | while read -r not_stickybit_filenames
	do
			if [ "$require_remediation" == "yes" ]
			then
					echo "Not Compliant (Remediating) - current_status:'$(stat -c "%A" $not_stickybit_filenames)' file:'$not_stickybit_filenames'"
					chmod a+t $not_stickybit_filenames
			else
					echo "Not Compliant (Action Required) - current_status:'$(stat -c "%A" $not_stickybit_filenames)' file:'$not_stickybit_filenames'"
			fi
	done
else
		echo "Compliant (Action Not Required) - 'No files found which required Sticky bit'"
fi

echo
echo "############################# Point 18: Disable Automounting #############################"
if rpm -q autofs >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'autofs'"
			yum remove autofs -y
		else
			echo "Not Compliant (Action Required) - $(rpm -q autofs)"
		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q autofs)"
fi

echo
echo "############################# Point 19: Disable USB Storage #############################"
usb_storage_mod=$(lsmod | grep usb-storage | wc -l)
if [[ "$usb_storage_mod" -eq 0 ]]
then
		echo "Compliant (Action Not Required) - 'usb-storage' module not present"
else
		if [ "$require_remediation" == "yes" ]
		then
			if [[ -f /etc/modprobe.d/usb_storage.conf ]]
			then
				if [[ "$(grep 'install usb-storage /bin/true' /etc/modprobe.d/usb_storage.conf | wc -l)" -eq 0 ]]
				then
					echo "Not Compliant (Remediating) - addying_line:'install usb-storage /bin/true' file:'/etc/modprobe.d/usb_storage.conf' and running command 'rmmod usb-storage'"
					echo "install usb-storage /bin/true" >> /etc/modprobe.d/usb_storage.conf
					rmmod usb-storage
				else
					echo "Not Compliant (Remediating) - running command 'rmmod usb-storage'"
					rmmod usb-storage
				fi
			else
				echo "Not Compliant (Remediating) - creating_file:'/etc/modprobe.d/usb_storage.conf' addying_line:'install usb-storage /bin/true'"
				echo "install usb-storage /bin/true" >> /etc/modprobe.d/usb_storage.conf
				rmmod usb-storage
			fi
		else
			echo "Not Compliant (Action Required) - current_status:'$(lsmod | grep usb-storage)'"
		fi
fi

echo
echo "############################# Point 20: Ensure mounting of cramfs filesystems is disabled #############################"
cramfs_mod=$(lsmod | grep cramfs | wc -l)
if [[ "$cramfs_mod" -eq 0 ]]
then
		echo "Compliant (Action Not Required) - 'cramfs' module not present"
else
		if [ "$require_remediation" == "yes" ]
		then
			if [[ -f /etc/modprobe.d/cramfs.conf ]]
			then
				if [[ "$(grep 'install cramfs /bin/true' /etc/modprobe.d/cramfs.conf | wc -l)" -eq 0 ]]
				then
					echo "Not Compliant (Remediating) - addying_line:'install cramfs /bin/true' file:'/etc/modprobe.d/cramfs.conf' and running command 'rmmod cramfs'"
					echo "install cramfs /bin/true" >> /etc/modprobe.d/cramfs.conf
					rmmod cramfs
				else
					echo "Not Compliant (Remediating) - running command 'rmmod cramfs'"
					rmmod cramfs
				fi
			else
				echo "Not Compliant (Remediating) - creating_file:'/etc/modprobe.d/cramfs.conf' addying_line:'install cramfs /bin/true'"
				echo "install cramfs /bin/true" >> /etc/modprobe.d/cramfs.conf
				rmmod cramfs
			fi
		else
			echo "Not Compliant (Action Required) - current_status:'$(lsmod | grep cramfs)'"
		fi
fi

echo
echo "############################# Point 21: Ensure mounting of udf filesystems is disabled #############################"
udf_mod=$(lsmod | grep udf | wc -l)
if [[ "$udf_mod" -eq 0 ]]
then
		echo "Compliant (Action Not Required) - 'udf' module not present"

else
		if [ "$require_remediation" == "yes" ]
		then
			if [[ -f /etc/modprobe.d/udf.conf ]]
			then
				if [[ "$(grep 'install udf /bin/true' /etc/modprobe.d/udf.conf | wc -l)" -eq 0 ]]
				then
					echo "Not Compliant (Remediating) - addying_line:'install udf /bin/true' file:'/etc/modprobe.d/udf.conf' and running command 'rmmod udf'"
					echo "install udf /bin/true" >> /etc/modprobe.d/udf.conf
					rmmod udf

				else
					echo "Not Compliant (Remediating) - running command 'rmmod udf'"
					rmmod udf

				fi
			else
				echo "Not Compliant (Remediating) - creating_file:'/etc/modprobe.d/udf.conf' addying_line:'install udf /bin/true'"
				echo "install udf /bin/true" >> /etc/modprobe.d/udf.conf
				rmmod udf

			fi
		else
			echo "Not Compliant (Action Required) - current_status:'$(lsmod | grep udf)'"

		fi
fi

echo
echo "########################## Point 24: Ensure gpgcheck is globally activated ##########################"
gpgcheck_files=$(grep '^gpgcheck' /etc/yum.repos.d/*.repo | wc -l)
if [[ "$gpgcheck_files" -ge 1 ]]
then
	grep '^gpgcheck' /etc/yum.repos.d/*.repo | cut -d: -f1 | uniq | while read -r file_name
	do
		grep '^gpgcheck' $file_name | while read -r gpgcheck_entry
		do
			if [[ "$gpgcheck_entry" == "gpgcheck=1" ]]
			then
				  echo "Compliant (Action Not Required) - current_status:'$gpgcheck_entry' file:'$file_name'"

			else
				  if [ "$require_remediation" == "yes" ]
				  then 
							echo "Not Compliant (Remediating) - current_status:'$gpgcheck_entry' modifying_line:'gpgcheck=1' file:'$file_name'"
							sed -i "s/^gpgcheck.*/gpgcheck=1/i" $file_name

				  else
							echo "Not Compliant (Action Required) - current_status:'$gpgcheck_entry' file:'$file_name'"

				  fi
			fi
		done
	done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/yum.repos.d/*.repo' file not found"

fi

echo
echo "############################# Point 25: Ensure AIDE is installed #############################"
if rpm -q aide >/dev/null 2>&1
then
		echo "Compliant (Action Not Required) - $(rpm -q aide)"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - installing 'aide', initializing 'aide' and renaming gz file to 'aide.db.gz'"
			yum install aide -y
			aide --init
			mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

		else
			echo "Not Compliant (Action Required) - $(rpm -q aide)"

		fi
fi


echo
echo "############################# Point 26: Ensure filesystem integrity is regularly checked #############################"
if rpm -q cronie >/dev/null 2>&1
then
		crontab_entry=$(crontab -l)
		if [[ "$crontab_entry" == "0 5 * * * /usr/sbin/aide --check" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$crontab_entry'"

		else
				if [ "$require_remediation" == "yes" ]
				then
							echo "Not Compliant (Remediating) - current_status:'$crontab_entry' addying_line:'0 5 * * * /usr/sbin/aide --check'"
							echo "0 5 * * * /usr/sbin/aide --check" | crontab -

				else
							echo "Not Compliant (Action Required) - current_status:'$crontab_entry'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - 'cronie' is not installed"

fi

echo
echo "########################## Point 27: Ensure permissions on bootloader config are configured ##########################"
file_status "/boot/grub2/grub.cfg"
if [[ "$status" == 1 ]]
then
		grub_cfg_uid=$(stat /boot/grub2/grub.cfg -c "%U")
		grub_cfg_gid=$(stat /boot/grub2/grub.cfg -c "%G")
		grub_cfg_per=$(stat /boot/grub2/grub.cfg -c "%a")
		if [[ "$grub_cfg_uid" == "root" ]] && [[ "$grub_cfg_gid" == "root" ]] && [[ "$grub_cfg_per" -eq 600 ]]
		then
			  echo "Compliant (Action Not Required) - file:'/boot/grub2/grub.cfg' current_owner_user:'$grub_cfg_uid' current_owner_group:'$grub_cfg_gid' current_permission:'$grub_cfg_per'"

		else
			  if [ "$require_remediation" == "yes" ]
			  then
					echo "Not Compliant (Remediating) - file:'/boot/grub2/grub.cfg' current_owner_user:'$grub_cfg_uid' current_owner_group:'$grub_cfg_gid' current_permission:'$grub_cfg_per'"
					chown root:root /boot/grub2/grub.cfg
					chmod 600 /boot/grub2/grub.cfg

			  else
					echo "Not Compliant (Action Required) - file:'/boot/grub2/grub.cfg' current_owner_user:'$grub_cfg_uid' current_owner_group:'$grub_cfg_gid' current_permission:'$grub_cfg_per'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/boot/grub2/grub.cfg' file not found"

fi

echo
echo "############################# Point 28: Ensure authentication required for single user mode #############################"
file_status "/usr/lib/systemd/system/rescue.service"
if [[ "$status" == 1 ]]
then
		res_ser_exec=$(grep -i "^ExecStart=" /usr/lib/systemd/system/rescue.service)
		res_ser_exec_value=$(grep -i "^ExecStart=" /usr/lib/systemd/system/rescue.service | cut -d "=" -f2)

		if [[ "$res_ser_exec_value" == '-/bin/sh -c "/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"' ]]
		then
				echo "Compliant (Action Not Required) - $res_ser_exec file:/usr/lib/systemd/system/rescue.service"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^ExecStart=" /usr/lib/systemd/system/rescue.service | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$res_ser_exec' modifying_line:'ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"' file:'/usr/lib/systemd/system/rescue.service'"
								sed -i "s/^ExecStart=.*/ExecStart=-\/bin\/sh -c \"\/sbin\/sulogin; \/usr\/bin\/systemctl --fail --no-block default\"/i" /usr/lib/systemd/system/rescue.service

						else
								echo "Not Compliant (Remediating) - current_status:'$res_ser_exec' addying_line:'ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"' file:'/usr/lib/systemd/system/rescue.service'"
								echo "ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"" >> /usr/lib/systemd/system/rescue.service

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$res_ser_exec'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/usr/lib/systemd/system/rescue.service' file not found"

fi

file_status "/usr/lib/systemd/system/emergency.service"
if [[ "$status" == 1 ]]
then
		emg_ser_exec=$(grep -i "^ExecStart=" /usr/lib/systemd/system/emergency.service)
		emg_ser_exec_value=$(grep -i "^ExecStart=" /usr/lib/systemd/system/emergency.service | cut -d "=" -f2)

		if [[ "$emg_ser_exec_value" == '-/bin/sh -c "/sbin/sulogin; /usr/bin/systemctl --fail --no-block default"' ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$emg_ser_exec' file:'/usr/lib/systemd/system/emergency.service'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^ExecStart=" /usr/lib/systemd/system/emergency.service | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$emg_ser_exec' modifying_line:'ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"' file:'/usr/lib/systemd/system/emergency.service'"
								sed -i "s/^ExecStart=.*/ExecStart=-\/bin\/sh -c \"\/sbin\/sulogin; \/usr\/bin\/systemctl --fail --no-block default\"/i" /usr/lib/systemd/system/emergency.service

						else
								echo "Not Compliant (Remediating) - current_status:'$emg_ser_exec' addying_line:'ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"' file:'/usr/lib/systemd/system/emergency.service'"
								echo "ExecStart=-/bin/sh -c \"/sbin/sulogin; /usr/bin/systemctl --fail --no-block default\"" >> /usr/lib/systemd/system/emergency.service

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$emg_ser_exec'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/usr/lib/systemd/system/emergency.service' file not found"

fi


echo
echo "############################# Point 29: Ensure core dumps are restricted #############################"
file_status "/etc/security/limits.conf"
if [[ "$status" == 1 ]]
then
		limits_hardcore=$(grep -w "^s*\* hard core 0" /etc/security/limits.conf)
		if [[ "$limits_hardcore" == "* hard core 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$limits_hardcore' file:'/etc/security/limits.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -w "^s*\* hard core" /etc/security/limits.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$limits_hardcore' modifying_line:'* hard core 0' file:'/etc/security/limits.conf'"
								sed -i "s/^\* hard core.*/* hard core 0/i" /etc/security/limits.conf

						else
								echo "Not Compliant (Remediating) - current_status:'$limits_hardcore' addying_line:'* hard core 0' file:'/etc/security/limits.conf'"
								echo "* hard core 0" >> /etc/security/limits.conf

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$limits_hardcore' file:'/etc/security/limits.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/security/limits.conf' file not found"

fi

file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_dumpable=$(grep -i "^fs.suid_dumpable" /etc/sysctl.conf)
		if [[ "$etc_sysctl_dumpable" == "fs.suid_dumpable = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_dumpable' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^fs.suid_dumpable" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_dumpable' modifying_line:'fs.suid_dumpable = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^fs\.suid_dumpable.*/fs.suid_dumpable = 0/i" /etc/sysctl.conf
								sysctl -w fs.suid_dumpable=0

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_dumpable' addying_line:'fs.suid_dumpable = 0' file:'/etc/sysctl.conf'"
								echo "fs.suid_dumpable = 0" >> /etc/sysctl.conf
								sysctl -w fs.suid_dumpable=0

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_dumpable' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi


echo
echo "############################# Point 31: Ensure address space layout randomization (ASLR) is enabled #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl=$(grep -i "^kernel.randomize_va_space" /etc/sysctl.conf)
		if [[ "$etc_sysctl" == "kernel.randomize_va_space = 2" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^kernel.randomize_va_space" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl' modifying_line:'kernel.randomize_va_space = 2' file:'/etc/sysctl.conf'"
								sed -i "s/^kernel\.randomize_va_space.*/kernel.randomize_va_space = 2/i" /etc/sysctl.conf
								sysctl -w kernel.randomize_va_space=2

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl' addying_line:'kernel.randomize_va_space = 2' file:'/etc/sysctl.conf'"
								echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
								sysctl -w kernel.randomize_va_space=2

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi


echo
echo "############################# Point 32: Ensure Prelink is not installed #############################"
if rpm -q prelink >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - restoring 'prelink' binaries to normal and removing 'prelink'"
			prelink -ua
			yum remove prelink -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q prelink)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q prelink)"

fi

echo
echo "############################# Point 33: Ensure SELinux is installed #############################"
if rpm -q libselinux >/dev/null 2>&1
then
		echo "Compliant (Action Not Required) - $(rpm -q libselinux)"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - installing 'libselinux'"
			yum install libselinux -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q libselinux)"

		fi
fi


echo
echo "########################## Point 35: Ensure SELinux policy is configured ##########################"
selinux_policy=$(sestatus | grep 'Loaded policy')
selinux_policy_type=$(echo "${selinux_policy##* }")
if [[ "$selinux_policy_type" == "targeted" ]]
then
      echo "Compliant (Action Not Required) - current_status:'SELINUXTYPE=$selinux_policy_type'"

else
      if [ "$require_remediation" == "yes" ]
			then
                if [ "$(grep -i "^SELINUXTYPE=" /etc/selinux/config | wc -l)" == 1 ]
                then
						echo "Not Compliant (Remediating) - current_status:'SELINUXTYPE=$selinux_policy_type' modifying_line:'SELINUXTYPE=targeted' file:'/etc/selinux/config'"
						sed -i "s/^SELINUXTYPE=.*/SELINUXTYPE=targeted/i" /etc/selinux/config
                        
                else
                        echo "Not Compliant (Remediating) - current_status:'SELINUXTYPE=$selinux_policy_type' adding_line:'SELINUXTYPE=targeted' file:'/etc/selinux/config'"
						echo "SELINUXTYPE=targeted" >> /etc/selinux/config
                        
                fi
      else
			echo "Not Compliant (Action Required) - current_status:'SELINUXTYPE=$selinux_policy' file:'/etc/selinux/config'"

      fi
fi


echo
echo "########################## Point 36: Ensure the SELinux mode is enforcing or permissive ##########################"
selinux_mode=$(getenforce)
if [[ "$selinux_mode" == "Permissive" ]]
then
      echo "Compliant (Action Not Required) - current_status:'SELINUX=$selinux_mode'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^SELINUX=" /etc/selinux/config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'SELINUX=$selinux_mode' modifying_line:'SELINUX=permissive' file:'/etc/selinux/config'"
                                setenforce 0
								sed -i "s/^SELINUX=.*/SELINUX=permissive/i" /etc/selinux/config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'SELINUX=$selinux_mode' adding_line:'SELINUX=permissive' file:'/etc/selinux/config'"
                                setenforce 0
								echo "SELINUX=permissive" >> /etc/selinux/config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'SELINUX=$selinux_mode' file:'/etc/selinux/config'"

      fi
fi

echo
echo "############################# Point 38: Ensure SETroubleshoot is not installed #############################"
if rpm -q setroubleshoot >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'setroubleshoot'"
			yum remove setroubleshoot -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q setroubleshoot)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q setroubleshoot)"

fi

echo
echo "############################# Point 39: Ensure the MCS Translation Service (mcstrans) is not installed #############################"
if rpm -q mcstrans >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - stopping 'avahi-daemon.socket' and removing 'avahi-autoipd'"
			yum remove mcstrans -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q mcstrans)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q mcstrans)"

fi

echo
echo "########################## Point 40: Ensure message of the day is configured properly ##########################"
file_status "/etc/motd"
if [[ "$status" == 1 ]]
then
		msg_of_the_day=$(cat /etc/motd)
		if [[ "$msg_of_the_day" == "Authorized uses only. All activity may be monitored and reported." ]]
		then
			  echo "Compliant (Action Not Required) - file:'/etc/motd' current_message:'$msg_of_the_day'"

		else
			  if [ "$require_remediation" == "yes" ]
			  then
					echo "Not Compliant (Remediating) - file:'/etc/motd' current_message:'$msg_of_the_day' new_message:'Authorized uses only. All activity may be monitored and reported.'"
					echo "Authorized uses only. All activity may be monitored and reported." > /etc/motd

			  else
					echo "Not Compliant (Action Required) - file:'/etc/motd' current_message:'$msg_of_the_day'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/motd' file not found"

fi

echo
echo "########################## Point 41: Ensure local login warning banner is configured properly ##########################"
local_banner=$(cat /etc/issue)
if [[ "$local_banner" == "Authorized uses only. All activity may be monitored and reported." ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/issue' current_message:'$local_banner'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/issue' current_message:'$local_banner' new_message:'Authorized uses only. All activity may be monitored and reported.'"
			echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/issue' current_message:'$local_banner'"

      fi
fi

echo
echo "########################## Point 42: Ensure remote login warning banner is configured properly ##########################"
remote_banner=$(cat /etc/issue.net)
if [[ "$remote_banner" == "Authorized uses only. All activity may be monitored and reported." ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/issue.net' current_message:'$remote_banner'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/issue.net' current_message:'$remote_banner' new_message:'Authorized uses only. All activity may be monitored and reported.'"
			echo "Authorized uses only. All activity may be monitored and reported." > /etc/issue.net
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/issue.net' current_message:'$remote_banner'"

      fi
fi

echo
echo "############################# Point 43: Ensure permissions on /etc/motd are configured #############################"
motd_file=$(readlink /etc/motd)
motd_perm=$(stat -c "%a" $motd_file)
if [[ "$motd_perm" == 644 ]]
then
		echo "Compliant (Action Not Required) - file:'$motd_file' current_permission:'$motd_perm'"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - file:'$motd_file' current_permission:'$motd_perm' new_permission:'644'"
			chmod 644 $motd_file

		else
			echo "Not Compliant (Action Required) - file:'$motd_file' current_permission:'$motd_perm'"

		fi
fi

echo
echo "############################# Point 44: Ensure permissions on /etc/issue are configured #############################"
issue_file=$(readlink /etc/issue | cut -d "." -f3)
issue_perm=$(stat -c "%a" $issue_file)
if [[ "$issue_perm" == 644 ]]
then
		echo "Compliant (Action Not Required) - file:'$issue_file' current_permission:'$issue_perm'"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - file:'$issue_file' current_permission:'$issue_perm' new_permission:'644'"
			chmod 644 $issue_file

		else
			echo "Not Compliant (Action Required) - file:'$issue_file' current_permission:'$issue_perm'"

		fi
fi


echo
echo "########################## Point 45: Ensure permissions on /etc/issue.net are configured ##########################"
etc_issuenet_file=$(readlink /etc/issue.net | cut -d "." -f3)
etc_issuenet_uid=$(stat $etc_issuenet_file -c "%U")
etc_issuenet_gid=$(stat $etc_issuenet_file -c "%G")
etc_issuenet_per=$(stat $etc_issuenet_file -c "%a")
if [[ "$etc_issuenet_uid" == "root" ]] && [[ "$etc_issuenet_gid" == "root" ]] && [[ "$etc_issuenet_per" -eq 644 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/issue.net' current_owner_user:'$etc_issuenet_uid' current_owner_group:'$etc_issuenet_gid' current_permission:'$etc_issuenet_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/issue.net' current_owner_user:'$etc_issuenet_uid' current_owner_group:'$etc_issuenet_gid' current_permission:'$etc_issuenet_per'"
			chown root:root $etc_issuenet_file
			chmod 644 $etc_issuenet_file
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/issue.net' current_owner_user:'$etc_issuenet_uid' current_owner_group:'$etc_issuenet_gid' current_permission:'$etc_issuenet_per'"

      fi
fi

echo
echo "############################# Point 47: Ensure X11 Server components are not installed #############################"
if [[ "$(rpm -qa xorg-x11-server* | wc -l)" -ge 1 ]]
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'rsync'"
			yum remove xorg-x11-server* -y

		else
			echo "Not Compliant (Action Required) - $(rpm -qa xorg-x11-server*)"

		fi
else
		echo "Compliant (Action Not Required) - package xorg-x11-server* not installed"

fi

echo
echo "############################# Point 48: Ensure Avahi Server is not installed #############################"
if rpm -q avahi-autoipd >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - stopping 'avahi-daemon.socket' and removing 'avahi-autoipd'"
			systemctl stop avahi-daemon.socket
			yum remove avahi-autoipd -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q avahi-autoipd)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q avahi-autoipd)"

fi
if rpm -q avahi >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - stopping 'avahi-daemon.service' and removing 'avahi'"
			systemctl stop avahi-daemon.service
			yum remove avahi -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q avahi)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q avahi)"

fi

echo
echo "############################# Point 49: Ensure CUPS is not installed #############################"
if rpm -q cups >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'cups'"
			yum remove cups -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q cups)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q cups)"

fi

echo
echo "############################# Point 50: Ensure DHCP Server is not installed #############################"
if rpm -q dhcp >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'dhcp'"
			yum remove dhcp -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q dhcp)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q dhcp)"

fi

echo
echo "############################# Point 51: Ensure LDAP Server is not installed #############################"
if rpm -q openldap-servers >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'openldap-servers'"
			yum remove openldap-servers -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q openldap-servers)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q openldap-servers)"

fi

echo
echo "############################# Point 52: Ensure DNS Server is not installed #############################"
if rpm -q bind >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'bind'"
			yum remove bind -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q bind)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q bind)"

fi

echo
echo "############################# Point 53: Ensure FTP Server is not installed #############################"
if rpm -q vsftpd >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'vsftpd'"
			yum remove vsftpd -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q vsftpd)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q vsftpd)"

fi

echo
echo "############################# Point 54: Ensure HTTP Server is not installed #############################"
if rpm -q httpd >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'httpd'"
			yum remove httpd -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q httpd)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q httpd)"

fi

echo
echo "############################# Point 55: Ensure IMAP and POP3 Server is not installed #############################"
if rpm -q dovecot >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'dovecot'"
			yum remove dovecot -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q dovecot)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q dovecot)"

fi


echo
echo "############################# Point 56: Ensure Samba is not installed #############################"
if rpm -q samba >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'samba'"
			yum remove samba -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q samba)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q samba)"

fi


echo
echo "############################# Point 57: Ensure HTTP Proxy Server is not installed #############################"
if rpm -q squid >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'squid'"
			yum remove squid -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q squid)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q squid)"

fi


echo
echo "############################# Point 58: Ensure net-snmp is not installed #############################"
if rpm -q net-snmp >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'net-snmp'"
			yum remove net-snmp -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q net-snmp)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q net-snmp)"

fi

echo
echo "############################# Point 59: Ensure NIS Server is not installed #############################"
if rpm -q ypserv >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'ypserv'"
			yum remove ypserv -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q ypserv)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q ypserv)"

fi

echo
echo "############################# Point 60: Ensure telnet-server is not installed #############################"
if rpm -q telnet-server >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'telnet-server'"
			yum remove telnet-server -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q telnet-server)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q telnet-server)"

fi


echo
echo "############################# Point 61: Ensure mail transfer agent is configured for local-only mode #############################"
file_status "/etc/postfix/main.cf"
if [[ "$status" == 1 ]]
then
		etc_postfix=$(grep -i "^inet_interfaces" /etc/postfix/main.cf)
		if [[ "$etc_postfix" == "inet_interfaces = loopback-only" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_postfix' file:'/etc/postfix/main.cf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^inet_interfaces" /etc/postfix/main.cf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_postfix' modifying_line:'inet_interfaces = loopback-only' file:'/etc/postfix/main.cf'"
								sed -i "s/^inet_interfaces.*/inet_interfaces = loopback-only/i" /etc/postfix/main.cf
								systemctl restart postfix

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_postfix' addying_line:'inet_interfaces = loopback-only' file:'/etc/postfix/main.cf'"
								echo "inet_interfaces = loopback-only" >> /etc/postfix/main.cf
								systemctl restart postfix

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_postfix' file:'/etc/postfix/main.cf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/postfix/main.cf' file not found"

fi

echo
echo "############################# Point 62: Ensure nfs-utils is not installed or the nfs-server service is masked #############################"
if rpm -q nfs-utils >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'nfs-utils'"
			yum remove nfs-utils -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q nfs-utils)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q nfs-utils)"

fi


echo
echo "############################# Point 63: Ensure rpcbind is not installed or the rpcbind services are masked #############################"
if rpm -q rpcbind >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'rpcbind'"
			yum remove rpcbind -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q rpcbind)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q rpcbind)"

fi

echo
echo "############################# Point 64: Ensure rsync is not installed or the rsyncd service is masked #############################"
if rpm -q rsync >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'rsync'"
			yum remove rsync -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q rsync)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q rsync)"

fi

echo
echo "############################# Point 66: Ensure chrony is configured #############################"
file_status "/etc/chrony.conf"
if [[ "$status" == 1 ]]
then
		etc_chrony=$(grep -i "^server" /etc/chrony.conf)
		if [[ "$etc_chrony" == "server 10.1.7.84"$'\n'"server 10.225.12.230" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_chrony' file:'/etc/chrony.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^server" /etc/chrony.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_chrony' modifying_line:'server 10.1.7.84 server 10.225.12.230' file:'/etc/chrony.conf'"
								sed -i '/^server/d' /etc/chrony.conf
								echo "server 10.1.7.84" >> /etc/chrony.conf
								echo "server 10.225.12.230" >> /etc/chrony.conf

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_chrony' addying_line:'server 10.1.7.84 server 10.225.12.230' file:'/etc/chrony.conf'"
								echo "server 10.1.7.84" >> /etc/chrony.conf
								echo "server 10.225.12.230" >> /etc/chrony.conf

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_chrony' file:'/etc/chrony.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/chrony.conf' file not found"

fi

echo
echo "############################# Point 68: Ensure NIS client is not installed #############################"
if rpm -q ypbind >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'ypbind'"
			yum remove ypbind -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q ypbind)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q ypbind)"

fi

echo
echo "############################# Point 69: Ensure rsh client is not installed #############################"
if rpm -q rsh >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'rsh'"
			yum remove rsh -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q rsh)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q rsh)"

fi

echo
echo "############################# Point 70: Ensure talk client is not installed #############################"
if rpm -q talk >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'talk'"
			yum remove talk -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q talk)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q talk)"

fi

echo
echo "############################# Point 71: Ensure telnet client is not installed #############################"
if rpm -q telnet >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'telnet'"
			yum remove telnet -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q telnet)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q telnet)"

fi


echo
echo "############################# Point 72: Ensure LDAP client is not installed #############################"
if rpm -q openldap-clients >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - removing 'openldap-clients'"
			yum remove openldap-clients -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q openldap-clients)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q openldap-clients)"

fi


echo
echo "############################# Point 74: Ensure IP forwarding is disabled #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_ipv4_frwd=$(grep -i "^net.ipv4.ip_forward" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ipv4_frwd" == "net.ipv4.ip_forward = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ipv4_frwd' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.ip_forward" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_frwd' modifying_line:'net.ipv4.ip_forward = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.ip_forward.*/net.ipv4.ip_forward = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.ip_forward=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_frwd' addying_line:'net.ipv4.ip_forward = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.ip_forward=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ipv4_frwd' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_ipv6_frwd=$(grep -i "^net.ipv6.conf.all.forwarding" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ipv6_frwd" == "net.ipv6.conf.all.forwarding = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ipv6_frwd' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv6.conf.all.forwarding" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv6_frwd' modifying_line:'net.ipv6.conf.all.forwarding = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv6.conf.all.forwarding.*/net.ipv6.conf.all.forwarding = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv6.conf.all.forwarding=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv6_frwd' addying_line:'net.ipv6.conf.all.forwarding = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv6.conf.all.forwarding = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv6.conf.all.forwarding=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ipv6_frwd' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 75: Ensure packet redirect sending is disabled #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_red=$(grep -i "^net.ipv4.conf.all.send_redirects" /etc/sysctl.conf)
		if [[ "$etc_sysctl_red" == "net.ipv4.conf.all.send_redirects = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_red' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.all.send_redirects" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_red' modifying_line:'net.ipv4.conf.all.send_redirects = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.all.send_redirects.*/net.ipv4.conf.all.send_redirects = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.send_redirects=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_red' addying_line:'net.ipv4.conf.all.send_redirects = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.send_redirects=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_red' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_red2=$(grep -i "^net.ipv4.conf.default.send_redirects" /etc/sysctl.conf)
		if [[ "$etc_sysctl_red2" == "net.ipv4.conf.default.send_redirects = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_red2' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.default.send_redirects" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_red2' modifying_line:'net.ipv4.conf.default.send_redirects = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.default.send_redirects.*/net.ipv4.conf.default.send_redirects = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.send_redirects=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_red2' addying_line:'net.ipv4.conf.default.send_redirects = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.send_redirects=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_red2' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi


echo
echo "############################# Point 76: Ensure source routed packets are not accepted #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_ipv4_srcrou_pack=$(grep -i "^net.ipv4.conf.all.accept_source_route" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ipv4_srcrou_pack" == "net.ipv4.conf.all.accept_source_route = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ipv4_srcrou_pack' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.all.accept_source_route" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_srcrou_pack' modifying_line:'net.ipv4.conf.all.accept_source_route = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.all.accept_source_route.*/net.ipv4.conf.all.accept_source_route = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.accept_source_route=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_srcrou_pack' addying_line:'net.ipv4.conf.all.accept_source_route = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.accept_source_route=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ipv4_srcrou_pack' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_ipv4_defsrcrou_pack=$(grep -i "^net.ipv4.conf.default.accept_source_route" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ipv4_defsrcrou_pack" == "net.ipv4.conf.default.accept_source_route = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ipv4_defsrcrou_pack' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.default.accept_source_route" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_defsrcrou_pack' modifying_line:'net.ipv4.conf.default.accept_source_route = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.default.accept_source_route.*/net.ipv4.conf.default.accept_source_route = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.accept_source_route=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_defsrcrou_pack' addying_line:'net.ipv4.conf.default.accept_source_route = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.accept_source_route=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ipv4_defsrcrou_pack' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 77: Ensure ICMP redirects are not accepted #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_ipv4_icmp_redirect=$(grep -i "^net.ipv4.conf.all.accept_redirects" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ipv4_icmp_redirect" == "net.ipv4.conf.all.accept_redirects = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ipv4_icmp_redirect' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.all.accept_redirects" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_icmp_redirect' modifying_line:'net.ipv4.conf.all.accept_redirects = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.all.accept_redirects.*/net.ipv4.conf.all.accept_redirects = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.accept_redirects=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_icmp_redirect' addying_line:'net.ipv4.conf.all.accept_redirects = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.accept_redirects=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ipv4_icmp_redirect' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_ipv4_icmp_defredirect=$(grep -i "^net.ipv4.conf.default.accept_redirects" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ipv4_icmp_defredirect" == "net.ipv4.conf.default.accept_redirects = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ipv4_icmp_defredirect' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.default.accept_redirects" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_icmp_defredirect' modifying_line:'net.ipv4.conf.default.accept_redirects = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.default.accept_redirects.*/net.ipv4.conf.default.accept_redirects = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.accept_redirects=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ipv4_icmp_defredirect' addying_line:'net.ipv4.conf.default.accept_redirects = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.accept_redirects=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ipv4_icmp_defredirect' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 78: Ensure secure ICMP redirects are not accepted #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_sec_red=$(grep -i "^net.ipv4.conf.all.secure_redirects" /etc/sysctl.conf)
		if [[ "$etc_sysctl_sec_red" == "net.ipv4.conf.all.secure_redirects = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_sec_red' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.all.secure_redirects" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red' modifying_line:'net.ipv4.conf.all.secure_redirects = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.all.secure_redirects.*/net.ipv4.conf.all.secure_redirects = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.secure_redirects=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red' addying_line:'net.ipv4.conf.all.secure_redirects = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.secure_redirects=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_sec_red' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_sec_red2=$(grep -i "^net.ipv4.conf.default.secure_redirects" /etc/sysctl.conf)
		if [[ "$etc_sysctl_sec_red2" == "net.ipv4.conf.default.secure_redirects = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_sec_red2' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.default.secure_redirects" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red2' modifying_line:'net.ipv4.conf.default.secure_redirects = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.default.secure_redirects.*/net.ipv4.conf.default.secure_redirects = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.secure_redirects=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red2' addying_line:'net.ipv4.conf.default.secure_redirects = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.secure_redirects=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_sec_red2' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 79: Ensure suspicious packets are logged #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_sec_red=$(grep -i "^net.ipv4.conf.all.log_martians" /etc/sysctl.conf)
		if [[ "$etc_sysctl_sec_red" == "net.ipv4.conf.all.log_martians = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_sec_red' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.all.log_martians" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red' modifying_line:'net.ipv4.conf.all.log_martians = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.all.log_martians.*/net.ipv4.conf.all.log_martians = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.log_martians=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red' addying_line:'net.ipv4.conf.all.log_martians = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.log_martians=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_sec_red' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_sec_red2=$(grep -i "^net.ipv4.conf.default.log_martians" /etc/sysctl.conf)
		if [[ "$etc_sysctl_sec_red2" == "net.ipv4.conf.default.log_martians = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_sec_red2' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.default.log_martians" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red2' modifying_line:'net.ipv4.conf.default.log_martians = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.default.log_martians.*/net.ipv4.conf.default.log_martians = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.log_martians=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_sec_red2' addying_line:'net.ipv4.conf.default.log_martians = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.log_martians=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_sec_red2' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 80: Ensure broadcast ICMP requests are ignored #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_ign_brdcst=$(grep -i "^net.ipv4.icmp_echo_ignore_broadcasts" /etc/sysctl.conf)
		if [[ "$etc_sysctl_ign_brdcst" == "net.ipv4.icmp_echo_ignore_broadcasts = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_ign_brdcst' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.icmp_echo_ignore_broadcasts" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ign_brdcst' modifying_line:'net.ipv4.icmp_echo_ignore_broadcasts = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.icmp_echo_ignore_broadcasts.*/net.ipv4.icmp_echo_ignore_broadcasts = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_ign_brdcst' addying_line:'net.ipv4.icmp_echo_ignore_broadcasts = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_ign_brdcst' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi


echo
echo "############################# Point 81: Ensure bogus ICMP responses are ignored #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_bgs_res=$(grep -i "^net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf)
		if [[ "$etc_sysctl_bgs_res" == "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_bgs_res' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_bgs_res' modifying_line:'net.ipv4.icmp_ignore_bogus_error_responses = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.icmp_ignore_bogus_error_responses.*/net.ipv4.icmp_ignore_bogus_error_responses = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_bgs_res' addying_line:'net.ipv4.icmp_ignore_bogus_error_responses = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_bgs_res' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 82: Ensure Reverse Path Filtering is enabled #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_rp_filter=$(grep -i "^net.ipv4.conf.all.rp_filter" /etc/sysctl.conf)
		if [[ "$etc_sysctl_rp_filter" == "net.ipv4.conf.all.rp_filter = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_rp_filter' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.all.rp_filter" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_rp_filter' modifying_line:'net.ipv4.conf.all.rp_filter = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.all.rp_filter.*/net.ipv4.conf.all.rp_filter = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.rp_filter=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_rp_filter' addying_line:'net.ipv4.conf.all.rp_filter = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.all.rp_filter=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_rp_filter' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_rp_filter2=$(grep -i "^net.ipv4.conf.default.rp_filter" /etc/sysctl.conf)
		if [[ "$etc_sysctl_rp_filter2" == "net.ipv4.conf.default.rp_filter = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_rp_filter2' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.conf.default.rp_filter" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_rp_filter2' modifying_line:'net.ipv4.conf.default.rp_filter = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.conf.default.rp_filter.*/net.ipv4.conf.default.rp_filter = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.rp_filter=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_rp_filter2' addying_line:'net.ipv4.conf.default.rp_filter = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.conf.default.rp_filter=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_rp_filter2' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 83: Ensure TCP SYN Cookies is enabled #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		tcp_synck=$(grep -i "^net.ipv4.tcp_syncookies" /etc/sysctl.conf)
		if [[ "$tcp_synck" == "net.ipv4.tcp_syncookies = 1" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$tcp_synck' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv4.tcp_syncookies" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$tcp_synck' modifying_line:'net.ipv4.tcp_syncookies = 1' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv4.tcp_syncookies.*/net.ipv4.tcp_syncookies = 1/i" /etc/sysctl.conf
								sysctl -w net.ipv4.tcp_syncookies=1
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$tcp_synck' addying_line:'net.ipv4.tcp_syncookies = 1' file:'/etc/sysctl.conf'"
								echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
								sysctl -w net.ipv4.tcp_syncookies=1
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$tcp_synck' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

echo
echo "############################# Point 84: Ensure IPv6 router advertisements are not accepted #############################"
file_status "/etc/sysctl.conf"
if [[ "$status" == 1 ]]
then
		etc_sysctl_accept_ra=$(grep -i "^net.ipv6.conf.all.accept_ra" /etc/sysctl.conf)
		if [[ "$etc_sysctl_accept_ra" == "net.ipv6.conf.all.accept_ra = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_accept_ra' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv6.conf.all.accept_ra" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_accept_ra' modifying_line:'net.ipv6.conf.all.accept_ra = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv6.conf.all.accept_ra.*/net.ipv6.conf.all.accept_ra = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv6.conf.all.accept_ra=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_accept_ra' addying_line:'net.ipv6.conf.all.accept_ra = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv6.conf.all.accept_ra=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_accept_ra' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi

if [[ "$status" == 1 ]]
then
		etc_sysctl_accept_ra2=$(grep -i "^net.ipv6.conf.default.accept_ra" /etc/sysctl.conf)
		if [[ "$etc_sysctl_accept_ra2" == "net.ipv6.conf.default.accept_ra = 0" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$etc_sysctl_accept_ra2' file:'/etc/sysctl.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep -i "^net.ipv6.conf.default.accept_ra" /etc/sysctl.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_accept_ra2' modifying_line:'net.ipv6.conf.default.accept_ra = 0' file:'/etc/sysctl.conf'"
								sed -i "s/^net.ipv6.conf.default.accept_ra.*/net.ipv6.conf.default.accept_ra = 0/i" /etc/sysctl.conf
								sysctl -w net.ipv6.conf.default.accept_ra=0
								sysctl -w net.ipv4.route.flush=1

						else
								echo "Not Compliant (Remediating) - current_status:'$etc_sysctl_accept_ra2' addying_line:'net.ipv6.conf.default.accept_ra = 0' file:'/etc/sysctl.conf'"
								echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf
								sysctl -w net.ipv6.conf.default.accept_ra=0
								sysctl -w net.ipv4.route.flush=1

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_sysctl_accept_ra2' file:'/etc/sysctl.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/sysctl.conf' file not found"

fi


echo
echo "############################# Point 85: Ensure firewalld is installed #############################"
if rpm -q firewalld >/dev/null 2>&1
then
		echo "Compliant (Action Not Required) - $(rpm -q firewalld)"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - installing 'firewalld'"
			yum install firewalld -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q firewalld)"

		fi
fi
if rpm -q iptables-nft >/dev/null 2>&1
then
		echo "Compliant (Action Not Required) - $(rpm -q iptables-nft)"

else
		if [ "$require_remediation" == "" ]
		then
			echo "Not Compliant (Remediating) - installing 'iptables-nft'"
			yum install iptables -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q iptables-nft)"

		fi
fi

echo
echo "############################# Point 86: Ensure iptables-services not installed with firewalld #############################"
if rpm -q iptables-services >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - stopping and removing 'iptables' 'ip6tables'"
			systemctl stop iptables
			systemctl stop ip6tables
			yum remove iptables-services -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q iptables-services)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q iptables-services)"

fi

echo
echo "############################# Point 94: Ensure iptables-services not installed with nftables #############################"
if rpm -q iptables-services >/dev/null 2>&1
then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - stopping and removing 'iptables' 'ip6tables'"
			systemctl stop iptables
			systemctl stop ip6tables
			yum remove iptables-services -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q iptables-services)"

		fi
else
		echo "Compliant (Action Not Required) - $(rpm -q iptables-services)"

fi



echo
echo "########################## Point 119: Ensure permissions on all logfiles are configured ##########################"
log_files_count=$(find /var/log -type f | wc -l)
if [[ "$log_files_count" -ge 1 ]]
then
		find /var/log -type f | while read -r log_files
		do
				log_file_perm=$(stat -c "%a" $log_files)
				if [[ "$log_file_perm" == *"40" ]]
				then
						echo "Compliant (Action Not Required) - file:'$log_files' current_permission:'$log_file_perm'"

				else
						if [ "$require_remediation" == "yes" ]
						then
								echo "Not Compliant (Remediating) - file:'$log_files' current_permission:'$log_file_perm' new_permission:'*40'"
								chmod g-wx,o-rwx,g+r $log_files

						else
								echo "Not Compliant (Action Required) - file:'$log_files' current_permission:'$log_file_perm'"

						fi
				fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - 'No log' file found under '/var/log'"

fi


echo
echo "############################# Point 120: Ensure rsyslog is installed #############################"
if rpm -q rsyslog >/dev/null 2>&1
then
		echo "Compliant (Action Not Required) - $(rpm -q rsyslog)"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - installing 'rsyslog'"
			yum install rsyslog -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q rsyslog)"

		fi
fi

echo
echo "########################## Point 121: Ensure rsyslog Service is enabled and running ##########################"
if rpm -q rsyslog >/dev/null 2>&1
then
    if [ "$(systemctl is-enabled rsyslog)" == "enabled"  ] && [  "$(systemctl status rsyslog | grep 'Active: active (running)' | wc -l)" == "1" ]
    then
            echo "Compliant (Action Not Required) - 'rsyslog' is enabled and running"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - Enabling and changing 'rsyslog' state to active"
                systemctl --now enable rsyslog
                
            else
                echo "Not Compliant (Action Required) - rsyslog is $(systemctl is-enabled rsyslog) and $(systemctl status rsyslog | grep 'Active: active (running)')"
                
            fi
    fi
else
    echo "Not Compliant (Manual Intervention Required) - $(rpm -q rsyslog)"

fi

echo
echo "########################## Point 122: Ensure rsyslog default file permissions configured ##########################"
file_status "/etc/rsyslog.conf"
if [[ "$status" == 1 ]]
then
		filecreatemode_entry=$(grep ^\$FileCreateMode /etc/rsyslog.conf)
		if [[ "$filecreatemode_entry" == "\$FileCreateMode 0640" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$filecreatemode_entry' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep ^\$FileCreateMode /etc/rsyslog.conf | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$filecreatemode_entry' modifying_line:'\$FileCreateMode 0640' file:'/etc/rsyslog.conf'"
								sed -i "s/^\$FileCreateMode.*/\$FileCreateMode 0640/i" /etc/rsyslog.conf

						else
								echo "Not Compliant (Remediating) - current_status:'$filecreatemode_entry' addying_line:'$FileCreateMode 0640' file:'/etc/rsyslog.conf'"
								echo "\$FileCreateMode 0640" >> /etc/rsyslog.conf

						fi
				else
							echo "Not Compliant (Action Required) - current_status:'$filecreatemode_entry' file:'/etc/rsyslog.conf'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/rsyslog.conf' file not found"

fi

echo
echo "########################## Point 123: Ensure logging is configured ##########################"
file_status "/etc/rsyslog.conf"
if [[ "$status" == 1 ]]
then
		rsyslog_logging_line1=$(grep -w "^\*.emerg :omusrmsg:*" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line1" == "*.emerg :omusrmsg:*" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line1' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line1' modifying_line:'*.emerg :omusrmsg:*' file:'/etc/rsyslog.conf'"
						echo "*.emerg :omusrmsg:*" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line1' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line2=$(grep -w "^auth,authpriv\.\* /var/log/secure" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line2" == "auth,authpriv.* /var/log/secure" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line2' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line2' modifying_line:'auth,authpriv.* /var/log/secure' file:'/etc/rsyslog.conf'"
						echo "auth,authpriv.* /var/log/secure" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line2' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line3=$(grep -w "mail\.\* -/var/log/mail" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line3" == "mail.* -/var/log/mail" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line3' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line3' modifying_line:'mail.* -/var/log/mail' file:'/etc/rsyslog.conf'"
						echo "mail.* -/var/log/mail" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line3' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line4=$(grep -w "mail\.info -/var/log/mail\.info" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line4" == "mail.info -/var/log/mail.info" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line4' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line4' modifying_line:'mail.info -/var/log/mail.info' file:'/etc/rsyslog.conf'"
						echo "mail.info -/var/log/mail.info" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line4' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line5=$(grep -w "mail\.warning -/var/log/mail\.warn" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line5" == "mail.warning -/var/log/mail.warn" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line5' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line5' modifying_line:'mail.warning -/var/log/mail.warn' file:'/etc/rsyslog.conf'"
						echo "mail.warning -/var/log/mail.warn" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line5' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line6=$(grep -w "mail\.err /var/log/mail\.err" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line6" == "mail.err /var/log/mail.err" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line6' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line6' modifying_line:'mail.err /var/log/mail.err' file:'/etc/rsyslog.conf'"
						echo "mail.err /var/log/mail.err" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line6' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line7=$(grep -w "news\.crit -/var/log/news/news\.crit" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line7" == "news.crit -/var/log/news/news.crit" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line7' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line7' modifying_line:'news.crit -/var/log/news/news.crit' file:'/etc/rsyslog.conf'"
						echo "news.crit -/var/log/news/news.crit" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line7' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line8=$(grep -w "news\.err -/var/log/news/news\.err" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line8" == "news.err -/var/log/news/news.err" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line8' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line8' modifying_line:'news.err -/var/log/news/news.err' file:'/etc/rsyslog.conf'"
						echo "news.err -/var/log/news/news.err" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line8' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line9=$(grep -w "news\.notice -/var/log/news/news\.notice" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line9" == "news.notice -/var/log/news/news.notice" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line9' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line9' modifying_line:'news.notice -/var/log/news/news.notice' file:'/etc/rsyslog.conf'"
						echo "news.notice -/var/log/news/news.notice" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line9' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line10=$(grep -w "\*\.=warning;\*\.=err -/var/log/warn" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line10" == "*.=warning;*.=err -/var/log/warn" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line10' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line10' modifying_line:'*.=warning;*.=err -/var/log/warn' file:'/etc/rsyslog.conf'"
						echo "*.=warning;*.=err -/var/log/warn" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line10' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line11=$(grep -w "\*\.crit /var/log/warn" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line11" == "*.crit /var/log/warn" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line11' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line11' modifying_line:'*.crit /var/log/warn' file:'/etc/rsyslog.conf'"
						echo "*.crit /var/log/warn" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line11' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line12=$(grep -w "\*\.\*;mail\.none;news\.none -/var/log/messages" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line12" == "*.*;mail.none;news.none -/var/log/messages" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line12' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line12' modifying_line:'*.*;mail.none;news.none -/var/log/messages' file:'/etc/rsyslog.conf'"
						echo "*.*;mail.none;news.none -/var/log/messages" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line12' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line13=$(grep -w "local0,local1\.\* -/var/log/localmessages" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line13" == "local0,local1.* -/var/log/localmessages" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line13' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line13' modifying_line:'local0,local1.* -/var/log/localmessages' file:'/etc/rsyslog.conf'"
						echo "local0,local1.* -/var/log/localmessages" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line13' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line14=$(grep -w "local2,local3\.\* -/var/log/localmessages" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line14" == "local2,local3.* -/var/log/localmessages" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line14' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line14' modifying_line:'local2,local3.* -/var/log/localmessages' file:'/etc/rsyslog.conf'"
						echo "local2,local3.* -/var/log/localmessages" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line14' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line15=$(grep -w "local4,local5\.\* -/var/log/localmessages" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line15" == "local4,local5.* -/var/log/localmessages" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line15' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line15' modifying_line:'local4,local5.* -/var/log/localmessages' file:'/etc/rsyslog.conf'"
						echo "local4,local5.* -/var/log/localmessages" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line15' file:'/etc/rsyslog.conf'"

				fi
		fi
		rsyslog_logging_line16=$(grep -w "local6,local7\.\* -/var/log/localmessages" /etc/rsyslog.conf)
		if [[ "$rsyslog_logging_line16" == "local6,local7.* -/var/log/localmessages" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_logging_line16' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$rsyslog_logging_line16' modifying_line:'local4,local5.* -/var/log/localmessages' file:'/etc/rsyslog.conf'"
						echo "local6,local7.* -/var/log/localmessages" >> /etc/rsyslog.conf

				else
						echo "Not Compliant (Action Required) - current_status:'$rsyslog_logging_line16' file:'/etc/rsyslog.conf'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/rsyslog.conf' file not found"

fi



echo
echo "############################# Point 124: Ensure rsyslog is configured to send logs to a remote log host #############################"
file_status "/etc/rsyslog.conf"
if [[ "$status" == 1 ]]
then
		if [[ "$(grep '^\*\.\* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' /etc/rsyslog.conf)" == '*.* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$(grep '^\*\.\* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' /etc/rsyslog.conf)' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$(grep '^\*\.\* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' /etc/rsyslog.conf)' addying_line:'*.* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' file:'/etc/rsyslog.conf'"
						echo '*.* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' >> /etc/rsyslog.conf
						systemctl restart rsyslog


				else
							echo "Not Compliant (Action Required) - current_status:'$(grep '^\*\.\* action(type="omfwd" target="192.168.2.100" port="514" protocol="tcp" action.resumeRetryCount="100" queue.type="LinkedList" queue.size="1000")' /etc/rsyslog.conf)'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/rsyslog.conf' file not found"

fi


echo
echo "############################# Point 125: Ensure remote rsyslog messages are only accepted on designated log hosts. #############################"
file_status "/etc/rsyslog.conf"
if [[ "$status" == 1 ]]
then
		rsyslog_modload=$(grep '^\$ModLoad imtcp' /etc/rsyslog.conf)
		if [[ "$rsyslog_modload" == "\$ModLoad imtcp" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_modload' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep '^\$ModLoad imtcp' /etc/rsyslog.conf | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$rsyslog_modload' modifying_line:'\$ModLoad imtcp' file:'/etc/rsyslog.conf'"
								sed -i "s/^\# $ModLoad imtcp.*/\$ModLoad imtcp/i" /etc/rsyslog.conf
								systemctl restart rsyslog

						else
								echo "Not Compliant (Remediating) - current_status:'$rsyslog_modload' addying_line:'\$ModLoad imtcp' file:'/etc/rsyslog.conf'"
								echo "\$ModLoad imtcp" >> /etc/rsyslog.conf
								systemctl restart rsyslog

						fi
				else
							echo "Not Compliant (Action Required) - current_status:'$rsyslog_modload' file:'/etc/rsyslog.conf'"

				fi
			fi
			
		rsyslog_intcpserverrun=$(grep '^\$InputTCPServerRun 514' /etc/rsyslog.conf)
		if [[ "$rsyslog_intcpserverrun" == "\$InputTCPServerRun 514" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$rsyslog_intcpserverrun' file:'/etc/rsyslog.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep '^\$InputTCPServerRun 514' /etc/rsyslog.conf | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$rsyslog_intcpserverrun' modifying_line:'\$InputTCPServerRun 514' file:'/etc/rsyslog.conf'"
								sed -i "s/^\# $InputTCPServerRun 514.*/\$InputTCPServerRun 514/i" /etc/rsyslog.conf
								systemctl restart rsyslog

						else
								echo "Not Compliant (Remediating) - current_status:'$rsyslog_intcpserverrun' addying_line:'\$InputTCPServerRun 514' file:'/etc/rsyslog.conf'"
								echo "\$InputTCPServerRun 514" >> /etc/rsyslog.conf
								systemctl restart rsyslog

						fi
				else
							echo "Not Compliant (Action Required) - current_status:'$rsyslog_intcpserverrun' file:'/etc/rsyslog.conf'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/rsyslog.conf' file not found"

fi

echo
echo "########################## Point 126: Ensure journald is configured to send logs to rsyslog ##########################"
if [ "$(grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf)" == "ForwardToSyslog=yes" ]
then
        echo "Compliant (Action Not Required) - file:'/etc/systemd/journald.conf' current_status:'$(grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf)'"

else
        if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - adding line:'ForwardToSyslog=yes' file:'/etc/systemd/journald.conf'"
            echo "ForwardToSyslog=yes" >> /etc/systemd/journald.conf
            
        else
            echo "Not Compliant (Action Required) - file:'/etc/systemd/journald.conf' current_status:'$(grep -E ^\s*ForwardToSyslog /etc/systemd/journald.conf)'"
            
        fi
fi

echo
echo "########################## Point 127: Ensure journald is configured to compress large log files ##########################"
if [ "$(grep -E '^\s*Compress=yes' /etc/systemd/journald.conf)" == "Compress=yes" ]
then
        echo "Compliant (Action Not Required) - file:'/etc/systemd/journald.conf' current_status:'$(grep -E ^\s*Compress=yes /etc/systemd/journald.conf)'"

else
        if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - adding line:'Compress=yes' file:'/etc/systemd/journald.conf'"
            echo "Compress=yes" >> /etc/systemd/journald.conf
            
        else
            echo "Not Compliant (Action Required) - file:'/etc/systemd/journald.conf' current_status:'$(grep -E ^\s*Compress=yes /etc/systemd/journald.conf)'"
            
        fi
fi


echo
echo "############################# Point 128: Ensure journald is configured to write logfiles to persistent disk #############################"
file_status "/etc/systemd/journald.conf"
if [[ "$status" == 1 ]]
then
		jour_storage=$(grep -i "^Storage" /etc/systemd/journald.conf)
		if [[ "$jour_storage" == "Storage=persistent" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$jour_storage' file:'/etc/systemd/journald.conf'"

		else
			  if [ "$require_remediation" == "yes" ]
				  then
						if [ "$(grep -i "^Storage" /etc/systemd/journald.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$jour_storage' modifying_line:'Storage=persistent' file:'/etc/systemd/journald.conf'"
								sed -i "s/^Storage=.*/Storage=persistent/gi" /etc/systemd/journald.conf

						else
								echo "Not Compliant (Remediating) - current_status:'$jour_storage' addying_line:'Storage=persistent' file:'/etc/systemd/journald.conf'"
								echo "Storage=persistent" >> /etc/systemd/journald.conf

						fi
			  else
				 echo "Not Compliant (Action Required) - current_status:'$jour_storage' file:'/etc/systemd/journald.conf'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/systemd/journald.conf' file not found"

fi

echo
echo "############################# Point 130: Ensure access to the su command is restricted #############################"
file_status "/etc/pam.d/su"
if [[ "$status" == 1 ]]
then
		grp_sugroup=$(grep -wi '^sugroup' /etc/group | cut -d: -f1)
		if [[ "$grp_sugroup" == "sugroup" ]] && [[ "$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)" == "auth required pam_wheel.so use_uid group=sugroup" ]]
		then
				echo "Compliant (Action Not Required) - '$(grep -wi '^sugroup' /etc/group)' current_status:'$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)' file:'/etc/pam.d/su'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [[ "$grp_sugroup" == "sugroup" ]]
						then
								echo "Not Compliant (Remediating) - '$(grep -wi '^sugroup' /etc/group)' current_status:'$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)' addying_line:'auth required pam_wheel.so use_uid group=sugroup' file:'/etc/pam.d/su'"
								echo "auth required pam_wheel.so use_uid group=sugroup" >> /etc/pam.d/su

						elif [[ "$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)" ==  "auth required pam_wheel.so use_uid group=sugroup" ]]
						then
								echo "Not Compliant (Remediating) - creating_group:'sugroup' current_status:'$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)'  file:'/etc/pam.d/su'"
								groupadd sugroup

						else
								echo "Not Compliant (Remediating) - creating_group:'sugroup' current_status:'$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)' addying_line:'auth required pam_wheel.so use_uid group=sugroup' file:'/etc/pam.d/su'"
								groupadd sugroup
								echo "auth required pam_wheel.so use_uid group=sugroup" >> /etc/pam.d/su

						fi
				else
						echo "Not Compliant (Action Required) - sugroup_status:'$grp_sugroup' current_status:'$(grep 'auth required pam_wheel.so use_uid group=sugroup' /etc/pam.d/su)'  file:'/etc/pam.d/su'"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/pam.d/su' file not found"

fi


echo
echo "########################## Point 131: Ensure cron daemon is enabled and running ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(systemctl is-enabled crond)
    output2=$(systemctl status crond | grep 'Active: active (running)' | wc -l)
    if [[ "$output1" = "enabled" && "$output2" == "1" ]]
    then
            echo "Compliant (Action Not Required) - 'crond' is active and running"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - Enabaling and changing 'crond' state to 'active'"
                systemctl --now enable crond
                
            else
                echo "Not Compliant (Action Required) - 'crond' is $output1 and $(systemctl status crond | grep 'Active: active (running)')"
                
            fi
    fi
else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi


echo
echo "########################## Point 132: Ensure permissions on /etc/crontab are configured ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(stat /etc/crontab -c "%U")
    output2=$(stat /etc/crontab -c "%G")
    output3=$(stat /etc/crontab -c "%a")
    if [[ "$output1" = "root" && "$output2" == "root" && "$output3" == "600" ]]
    then
            echo "Compliant (Action Not Required) - dir:'/etc/cron.hourly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - dir:'/etc/cron.hourly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                chown root:root /etc/crontab
                chmod 600 /etc/crontab
                
            else
                echo "Not Compliant (Action Required) - dir:'/etc/cron.hourly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                
            fi
    fi
else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi


echo
echo "########################## Point 133: Ensure permissions on /etc/cron.hourly are configured ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(stat /etc/cron.hourly/ -c "%U")
    output2=$(stat /etc/cron.hourly/ -c "%G")
    output3=$(stat /etc/cron.hourly/ -c "%a")
    if [[ "$output1" = "root" && "$output2" == "root" && "$output3" == "700" ]]
    then
            echo "Compliant (Action Not Required) - dir:'/etc/cron.hourly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - dir:'/etc/cron.hourly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                chown root:root /etc/cron.hourly/
                chmod 700 /etc/cron.hourly/
                
            else
                echo "Not Compliant (Action Required) - dir:'/etc/cron.hourly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                
            fi
    fi
else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi

echo
echo "########################## Point 134: Ensure permissions on /etc/cron.daily are configured ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(stat /etc/cron.daily/ -c "%U")
    output2=$(stat /etc/cron.daily/ -c "%G")
    output3=$(stat /etc/cron.daily/ -c "%a")
    if [[ "$output1" = "root" && "$output2" == "root" && "$output3" == "700" ]]
    then
            echo "Compliant (Action Not Required) - dir:'/etc/cron.daily' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - dir:'/etc/cron.daily' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                chown root:root /etc/cron.daily/
                chmod 700 /etc/cron.daily/
                
            else
                echo "Not Compliant (Manual Intervention Required) - dir:'/etc/cron.daily' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                
            fi
    fi
else
    echo "Not Compliant (Action Required) - 'cronie' service not installed"

fi

echo
echo "########################## Point 135: Ensure permissions on /etc/cron.weekly are configured ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(stat /etc/cron.weekly -c "%U")
    output2=$(stat /etc/cron.weekly -c "%G")
    output3=$(stat /etc/cron.weekly -c "%a")
    if [[ "$output1" = "root" && "$output2" == "root" && "$output3" == "700" ]]
    then
            echo "Compliant (Action Not Required) - dir:/etc/cron.weekly owner_uid:$output1 owner_gid:$output2 current_permission:$output3"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - dir:'/etc/cron.weekly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                chown root:root /etc/cron.weekly
                chmod 700 /etc/cron.weekly
                
            else
                echo "Not Compliant (Action Required) - dir:'/etc/cron.weekly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                
            fi
    fi
else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi

echo
echo "########################## Point 136: Ensure permissions on /etc/cron.monthly are configured ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(stat /etc/cron.monthly/ -c "%U")
    output2=$(stat /etc/cron.monthly/ -c "%G")
    output3=$(stat /etc/cron.monthly/ -c "%a")
    if [[ "$output1" = "root" && "$output2" == "root" && "$output3" == "700" ]]
    then
            echo "Compliant (Action Not Required) - dir:'/etc/cron.monthly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - dir:'/etc/cron.monthly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                chown root:root /etc/cron.monthly
                chmod 700 /etc/cron.monthly
                
            else
                echo "Not Compliant (Action Required) - dir:'/etc/cron.monthly' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                
            fi
    fi
else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi

echo
echo "########################## Point 137: Ensure permissions on /etc/cron.d are configured ##########################"
if rpm -q cronie >/dev/null 2>&1
then
    output1=$(stat /etc/cron.d -c "%U")
    output2=$(stat /etc/cron.d -c "%G")
    output3=$(stat /etc/cron.d -c "%a")
    if [[ "$output1" = "root" && "$output2" == "root" && "$output3" == "700" ]]
    then
            echo "Compliant (Action Not Required) - dir:'/etc/cron.d' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - dir:'/etc/cron.d' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                chown root:root /etc/cron.d
                chmod 700 /etc/cron.d
                
            else
                echo "Not Compliant (Action Required) - dir:'/etc/cron.d' owner_uid:'$output1' owner_gid:'$output2' current_permission:'$output3'"
                
            fi
    fi

else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi


echo
echo "########################## Point 138: Ensure cron is restricted to authorized users ##########################"
if rpm -q cronie >/dev/null 2>&1
then
	file_status "/etc/cron.allow"
	if [[ "$status" == 1 ]]
	then
    output2=$(stat /etc/cron.allow -c "%U")
    output3=$(stat /etc/cron.allow -c "%G")
    output4=$(stat /etc/cron.allow -c "%a")
    if [ ! -f "/etc/cron.deny" ] && [ "$output2" == "root" ] && [ "$output3" == "root" ] && [ "$output4" == "600" ]
    then
            echo "Compliant (Action Not Required) - 'cron.deny' file is absent and file:'/etc/cron.allow' owner_uid:'$output2' owner_gid:'$output3' current_permission:'$output4'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				if [ -f "/etc/cron.deny" ]
				then
					echo "Not Compliant (Remediating) - Removing '/etc/cron.deny'"
					rm -f /etc/cron.deny

				fi
				if [ "$output2" != "root" ] || [ "$output3" != "root" ] || [ "$output4" != "600" ]
				then
					echo "Not Compliant (Remediating) - file:'/etc/cron.allow' owner_uid:'$output2' owner_gid:'$output3' current_permission:'$output4'"
					touch /etc/cron.allow
					chown root:root /etc/cron.allow
					chmod 600 /etc/cron.allow

				fi
            else
                if [ -f "/etc/cron.deny" ]
				then
					echo "Not Compliant (Action Required) - File found:'/etc/cron.deny'"

				fi
				if [ "$output2" != "root" ] || [ "$output3" != "root" ] || [ "$output4" != "600" ]
				then
					echo "Not Compliant (Action Required) - file:'/etc/cron.allow' owner_uid:'$output2' owner_gid:'$output3' current_permission:'$output4'"

				fi
            fi
    fi
	else
		echo "Not Compliant (Manual Intervention Required) - '/etc/cron.allow' file not found"
	fi
else
    echo "Not Compliant (Manual Intervention Required) - 'cronie' service not installed"

fi

echo
echo "########################## Point 139: Ensure at is restricted to authorized users ##########################"
if rpm -q at >/dev/null 2>&1
then
	file_status "/etc/cron.allow"
	if [[ "$status" == 1 ]]
	then
    output2=$(stat /etc/at.allow -c "%U")
    output3=$(stat /etc/at.allow -c "%G")
    output4=$(stat /etc/at.allow -c "%a")
    if [ ! -f "/etc/at.deny" ] && [ "$output2" == "root" ] && [ "$output3" == "root" ] && [ "$output4" == "600" ]
    then
            echo "Compliant (Action Not Required) - 'at.deny' file is absent and file:'/etc/cron.allow' owner_uid:'$output2' owner_gid:'$output3 ' current_permission:'$output4'"
            
    else
            if [ "$require_remediation" == "yes" ]
			then
				if [ -f "/etc/at.deny" ]
				then
					echo "Not Compliant (Remediating) - Removing '/etc/at.deny'"
					rm -f /etc/at.deny

				fi
				if [ "$output2" != "root" ] || [ "$output3" != "root" ] || [ "$output4" != "600" ]
				then
					echo "Not Compliant (Remediating) - File:'/etc/at.allow' owner_uid:'$output2' owner_gid:'$output3' current_permission:'$output4'"
					touch /etc/at.allow
					chown root:root /etc/at.allow
					chmod 600 /etc/at.allow

				fi
            else
                if [ -f "/etc/at.deny" ]
				then
					echo "Not Compliant (Action Required) - file_found:'/etc/at.deny'"

				else
					echo "Not Compliant (Action Required) - '/etc/at.deny' file not found"

				fi
				if [ "$output2" != "root" ] || [ "$output3" != "root" ] || [ "$output4" != "600" ]
				then
					echo "Not Compliant (Action Required) - file:'/etc/at.allow' owner_uid:'$output2' owner_gid:'$output3' permission:'$output4'"

				fi
            fi
    fi
	else
		echo "Not Compliant (Manual Intervention Required) - '/etc/cron.allow' file not found"
	fi
else
    echo "Not Compliant (Manual Intervention Required) - 'at' service not installed"

fi

echo
echo "############################# Point 140: Ensure sudo is installed #############################"
if rpm -q sudo >/dev/null 2>&1
then
		echo "Compliant (Action Not Required) - $(rpm -q sudo)"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - installing 'sudo'"
			yum install sudo -y

		else
			echo "Not Compliant (Action Required) - $(rpm -q sudo)"

		fi
fi

echo
echo "########################## Point 141: Ensure sudo commands use pty ##########################"
output1=$(grep -Ei '^\s*Defaults\s+([^#]\S+,\s*)?use_pty\b' /etc/sudoers /etc/sudoers.d/* | cut -d ":" -f 2 2>&1)
if [ "$output1" == "Defaults use_pty" ]
then
        echo "Compliant (Action Not Required) - current_status:'$output1' file:'/etc/sudoers'"

else
        if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - adding_line:'Defaults use_pty' file:'/etc/sudoers'"
            echo "Defaults use_pty" >>  /etc/sudoers
            
        else
            echo "Not Compliant (Action Required) - current_status:'$output1' file:'/etc/sudoers'"
            
        fi
fi

echo
echo "########################## Point 142: Ensure sudo log file exists ##########################"
output1=$(grep -Ei '^\s*Defaults\s+([^#;]+,\s*)?logfile\s*=\s*(")?[^#;]+(")?' /etc/sudoers  | cut -d ':' -f 2 2>&1)
if [ "$output1" == 'Defaults logfile="/var/log/sudo.log"' ]
then
        echo "Compliant (Action Not Required) -  current_status:'$output1' file:'/etc/sudoers'"

else
        if [ "$require_remediation" == "yes" ]
		then
            echo "Not Compliant (Remediating) - adding_line:'Defaults logfile=\"/var/log/sudo.log' file:'/etc/sudoers'"
            echo 'Defaults logfile="/var/log/sudo.log"' >>  /etc/sudoers
            
        else
            echo "Not Compliant (Action Required) - current_status:'$output1' file:'/etc/sudoers'"
            
        fi
fi

echo
echo "########################## Point 143: Ensure permissions on /etc/ssh/sshd_config are configured ##########################"
sshd_config_uid=$(stat /etc/ssh/sshd_config -c "%U")
sshd_config_gid=$(stat /etc/ssh/sshd_config -c "%G")
sshd_config_perm=$(stat /etc/ssh/sshd_config -c "%a")
if [ "$sshd_config_uid" == "root" ] && [ "$sshd_config_gid" == "root" ] && [ "$sshd_config_perm" == "600" ]
then
        echo "Compliant (Action Not Required) - file:'/etc/ssh/sshd_config' owner_uid:'$sshd_config_uid' owner_gid:'$sshd_config_gid' current_permission:'$sshd_config_perm'"

else
        if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - file:'/etc/ssh/sshd_config' owner_uid:'$sshd_config_uid' owner_gid:'$sshd_config_gid' current_permission:'$sshd_config_perm'"
            chown root:root /etc/ssh/sshd_config
            chmod og-rwx /etc/ssh/sshd_config
            
        else
            echo "Not Compliant (Action Required) - file:'/etc/ssh/sshd_config' owner_uid:'$sshd_config_uid' owner_gid:'$sshd_config_gid' current_permission:'$sshd_config_perm'"
            
        fi
fi

echo
echo "########################## Point 144: Ensure permissions on SSH private host key files are configured ##########################"
ssh_prv_hostkeyfile_count=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key' | wc -l)
if [[ "$ssh_prv_hostkeyfile_count" -ge 1 ]]
then
		find /etc/ssh -xdev -type f -name 'ssh_host_*_key' | while read -r ssh_prv_hostkeyfile
		do
				ssh_prv_hostkeyfile_uid=$(stat -c "%U" $ssh_prv_hostkeyfile)
				ssh_prv_hostkeyfile_gid=$(stat -c "%G" $ssh_prv_hostkeyfile)
				ssh_prv_hostkeyfile_perm=$(stat -c "%a" $ssh_prv_hostkeyfile)
				if [[ "$ssh_prv_hostkeyfile_uid" == "root" ]] && [[ "$ssh_prv_hostkeyfile_gid" == "root" ]] && [[ "$ssh_prv_hostkeyfile_perm" -eq 600 ]]
				then
						echo "Compliant (Action Not Required) - file:'$ssh_prv_hostkeyfile' current_owner:'$ssh_prv_hostkeyfile_uid' current_owner_group:'$ssh_prv_hostkeyfile_gid' current_permission:'$ssh_prv_hostkeyfile_perm'"

				else
						if [ "$require_remediation" == "yes" ]
						then
								echo "Not Compliant (Remediating) - file:'$ssh_prv_hostkeyfile' current_owner:'$ssh_prv_hostkeyfile_uid' current_owner_group:'$ssh_prv_hostkeyfile_gid' current_permission:'$ssh_prv_hostkeyfile_perm'"
								chmod 600 $ssh_prv_hostkeyfile
								chown root:root $ssh_prv_hostkeyfile

						else
								echo "Not Compliant (Action Required) - file:'$ssh_prv_hostkeyfile' current_owner:'$ssh_prv_hostkeyfile_uid' current_owner_group:'$ssh_prv_hostkeyfile_gid' current_permission:'$ssh_prv_hostkeyfile_perm'"

						fi
				fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - No private host key file found under '/etc/ssh' dir"

fi


echo
echo "########################## Point 145: Ensure permissions on SSH public host key files are configured ##########################"
ssh_pub_hostkeyfile_count=$(find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' | wc -l)
if [[ "$ssh_pub_hostkeyfile_count" -ge 1 ]]
then
		find /etc/ssh -xdev -type f -name 'ssh_host_*_key.pub' | while read -r ssh_pub_hostkeyfile
		do
				ssh_pub_hostkeyfile_uid=$(stat -c "%U" $ssh_pub_hostkeyfile)
				ssh_pub_hostkeyfile_gid=$(stat -c "%G" $ssh_pub_hostkeyfile)
				ssh_pub_hostkeyfile_perm=$(stat -c "%a" $ssh_pub_hostkeyfile)
				if [[ "$ssh_pub_hostkeyfile_uid" == "root" ]] && [[ "$ssh_pub_hostkeyfile_gid" == "root" ]] && [[ "$ssh_pub_hostkeyfile_perm" -eq 600 ]]
				then
						echo "Compliant (Action Not Required) - file:'$ssh_pub_hostkeyfile' current_owner:'$ssh_pub_hostkeyfile_uid' current_owner_group:'$ssh_pub_hostkeyfile_gid' current_permission:'$ssh_pub_hostkeyfile_perm'"

				else
						if [ "$require_remediation" == "yes" ]
						then
								echo "Not Compliant (Remediating) - file:'$ssh_pub_hostkeyfile' current_owner:'$ssh_pub_hostkeyfile_uid' current_owner_group:'$ssh_pub_hostkeyfile_gid' current_permission:'$ssh_pub_hostkeyfile_perm'"
								chmod 600 $ssh_pub_hostkeyfile
								chown root:root $ssh_pub_hostkeyfile

						else
								echo "Not Compliant (Action Required) - file:'$ssh_pub_hostkeyfile' current_owner:'$ssh_pub_hostkeyfile_uid' current_owner_group:'$ssh_pub_hostkeyfile_gid' current_permission:'$ssh_pub_hostkeyfile_perm'"

						fi
				fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - No public host key file found under '/etc/ssh'"

fi

echo
echo "############################# Point 146: Ensure SSH access is limited #############################"
file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
		grep /bin/bash /etc/passwd | cut -d: -f1 | while read -r users
		do
			allow_user=$(grep -i "AllowUsers $users" /etc/ssh/sshd_config)
			if [[ "$allow_user" == "AllowUsers $users" ]]
			then
					echo "Compliant (Action Not Required) - current_status:'$allow_user' file:'/etc/ssh/sshd_config'"

			else
					if [ "$require_remediation" == "yes" ]
					then
							echo "Not Compliant (Remediating) - current_status:'$allow_user' addying_line:'AllowUsers $users' file:'/etc/ssh/sshd_config'"
							echo "AllowUsers $users" >> /etc/ssh/sshd_config

					else
							echo "Not Compliant (Action Required) - current_status:'$allow_user' file:'/etc/ssh/sshd_config'"

					fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/passwd' file not found"

fi

file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
		grep /bin/bash /etc/passwd | cut -d: -f4 | while read -r users_gid
		do
			grp_name=$(grep -w "$users_gid" /etc/group | cut -d: -f1)
			allow_groups=$(grep -i "AllowGroups $grp_name" /etc/ssh/sshd_config)
			if [[ "$allow_groups" == "AllowGroups $grp_name" ]]
			then
					echo "Compliant (Action Not Required) - current_status:'$allow_groups' file:'/etc/ssh/sshd_config'"

			else
					if [ "$require_remediation" == "yes" ]
					then
							echo "Not Compliant (Remediating) - current_status:'$allow_groups' addying_line:'AllowGroups $grp_name' file:'/etc/ssh/sshd_config'"
							echo "AllowGroups $grp_name" >> /etc/ssh/sshd_config

					else
							echo "Not Compliant (Action Required) - current_status:'$allow_groups' file:'/etc/ssh/sshd_config'"

					fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/passwd' file not found"

fi

echo
echo "########################## Point 147: Ensure SSH LogLevel is appropriate ##########################"
loglevel=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep loglevel)
if [[ "$loglevel" == "loglevel VERBOSE" ]]
then
      echo "Compliant (Action Not Required) - '$loglevel'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^loglevel" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$loglevel' modifying_line:'LogLevel VERBOSE' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^LogLevel.*/LogLevel VERBOSE/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$loglevel' adding_line:'LogLevel VERBOSE' file:'/etc/ssh/sshd_config'"
                                sed -i "/# Logging/a LogLevel VERBOSE" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$loglevel'"

      fi
fi

echo
echo "########################## Point 148: Ensure SSH MaxAuthTries is set to 4 or less ##########################"
maxauthtries=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep maxauthtries)
maxauthtries_count=$(echo $maxauthtries | cut -d " " -f2)
if [[ "$maxauthtries_count" -le 4 ]]
then
      echo "Compliant (Action Not Required) - current_status:'$maxauthtries' "

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^MaxAuthTries" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$maxauthtries' modifying_line:'MaxAuthTries 4' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^MaxAuthTries.*/MaxAuthTries 4/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$maxauthtries' adding_line:'MaxAuthTries 4' file:'/etc/ssh/sshd_config'"
                                sed -i "/# Authentication/a MaxAuthTries 4" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$maxauthtries'"

      fi
fi


echo
echo "########################## Point 149: Ensure SSH IgnoreRhosts is enabled ##########################"
ignorerhosts=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep ignorerhosts)
if [[ "$ignorerhosts" == "ignorerhosts yes" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$ignorerhosts'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^IgnoreRhosts" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
                echo "Not Compliant (Remediating) - current_status:'$ignorerhosts' modifying_line:'IgnoreRhosts yes' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^IgnoreRhosts.*/IgnoreRhosts yes/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$ignorerhosts' adding_line:'IgnoreRhosts yes' file:'/etc/ssh/sshd_config'"
                                sed -i "/# For this to work you will also need host keys/a IgnoreRhosts yes" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$ignorerhosts'"

      fi
fi

echo
echo "########################## Point 150: Ensure SSH HostbasedAuthentication is disabled ##########################"
hostbasedauthentication=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep hostbasedauthentication)
if [[ "$hostbasedauthentication" == "hostbasedauthentication no" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$hostbasedauthentication'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^HostbasedAuthentication" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$hostbasedauthentication' modifying_line:'HostbasedAuthentication no' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^HostbasedAuthentication.*/HostbasedAuthentication no/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$hostbasedauthentication' adding_line:'HostbasedAuthentication no' file:'/etc/ssh/sshd_config'"
                                sed -i "/# For this to work you will also need host keys/a HostbasedAuthentication no" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$hostbasedauthentication'"

      fi
fi

echo
echo "########################## Point 151: Ensure SSH root login is disabled ##########################"
permitrootlogin=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitrootlogin)
if [[ "$permitrootlogin" == "permitrootlogin no" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$permitrootlogin'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^PermitRootLogin" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$permitrootlogin' modifying_line:'PermitRootLogin no' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^PermitRootLogin.*/PermitRootLogin no/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$permitrootlogin' adding_line:'PermitRootLogin no' file:'/etc/ssh/sshd_config'"
                                sed -i "/# Authentication/a PermitRootLogin no" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$permitrootlogin'"

      fi
fi



echo
echo "########################## Point 152: Ensure SSH PermitEmptyPasswords is disabled #######################"
permitemptypasswords=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permitemptypasswords)
if [[ "$permitemptypasswords" == "permitemptypasswords no" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$permitemptypasswords'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^PermitEmptyPasswords" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$permitemptypasswords' modifying_line:'PermitEmptyPasswords no' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^PermitEmptyPasswords.*/PermitEmptyPasswords no/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$permitemptypasswords' adding_line:'PermitEmptyPasswords no' file:'/etc/ssh/sshd_config'"
                                sed -i "/# restarting sshd in the default instance launch configuration/a PermitEmptyPasswords no" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$permitemptypasswords'"

      fi
fi



echo
echo "########################## Point 153: Ensure SSH PermitUserEnvironment is disabled #######################"
permituserenvironment=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep permituserenvironment)
if [[ "$permituserenvironment" == "permituserenvironment no" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$permituserenvironment'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^PermitUserEnvironment" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$permituserenvironment' modifying_line:'PermitUserEnvironment no' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^PermitUserEnvironment.*/PermitUserEnvironment no/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$permituserenvironment' adding_line:'PermitUserEnvironment no' file:'/etc/ssh/sshd_config'"
                                sed -i "/# restarting sshd in the default instance launch configuration/a PermitUserEnvironment no" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$permituserenvironment'"

      fi
fi


echo
echo "############################# Point 154: Ensure only strong Ciphers are used #############################"
file_status "/etc/ssh/sshd_config"
if [[ "$status" == 1 ]]
then
		strong_ciphers=$(grep -i "^Ciphers" /etc/ssh/sshd_config)
		if [[ "$strong_ciphers" == "Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$strong_ciphers'"

		else
			  if [ "$require_remediation" == "yes" ]
				  then
						if [ "$(grep -i "^Ciphers" /etc/ssh/sshd_config | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$strong_ciphers' modifying_line:'Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr' file:'/etc/ssh/sshd_config'"
								sed -i "s/^Ciphers .*/Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr/i" /etc/ssh/sshd_config

						else
								echo "Not Compliant (Remediating) - current_status:'$strong_ciphers' addying_line:'Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr' file:'/etc/ssh/sshd_config'"
								sed -i "/# Ciphers and keying/a Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr" /etc/ssh/sshd_config

						fi
			  else
				 echo "Not Compliant (Action Required) - current_status:'$strong_ciphers' file:'/etc/ssh/sshd_config'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/ssh/sshd_config' file not found"

fi

echo
echo "############################# Point 155: Ensure only strong MAC algorithms are used #############################"
file_status "/etc/ssh/sshd_config"
if [[ "$status" == 1 ]]
then
		strong_mac=$(grep -i "^MACs" /etc/ssh/sshd_config)
		if [[ "$strong_mac" == "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$strong_mac'"

		else
			  if [ "$require_remediation" == "yes" ]
				  then
						if [ "$(grep -i "^MACs" /etc/ssh/sshd_config | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$strong_mac' modifying_line:'MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256' file:'/etc/ssh/sshd_config'"
								sed -i "s/^MACs .*/MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256/i" /etc/ssh/sshd_config

						else
								echo "Not Compliant (Remediating) - current_status:'$strong_mac' addying_line:'MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256' file:'/etc/ssh/sshd_config'"
								echo "MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256" >> /etc/ssh/sshd_config

						fi
			  else
				 echo "Not Compliant (Action Required) - current_status:'$strong_mac' file:'/etc/ssh/sshd_config'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/ssh/sshd_config' file not found"

fi

echo
echo "############################# Point 156: Ensure only strong Key Exchange algorithms are used #############################"
file_status "/etc/ssh/sshd_config"
if [[ "$status" == 1 ]]
then
		strong_key=$(grep -i "^KexAlgorithms" /etc/ssh/sshd_config)
		if [[ "$strong_key" == "KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$strong_key'"

		else
			  if [ "$require_remediation" == "yes" ]
				  then
						if [ "$(grep -i "^KexAlgorithms" /etc/ssh/sshd_config | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$strong_key' modifying_line:'KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256' file:'/etc/ssh/sshd_config'"
								sed -i "s/^KexAlgorithms .*/KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256/i" /etc/ssh/sshd_config

						else
								echo "Not Compliant (Remediating) - current_status:'$strong_key' addying_line:'KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256' file:'/etc/ssh/sshd_config'"
								echo "KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256" >> /etc/ssh/sshd_config

						fi
			  else
				 echo "Not Compliant (Action Required) - current_status:'$strong_key' file:/etc/ssh/sshd_config"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/ssh/sshd_config' file not found"

fi


echo
echo "########################## Point 157: Ensure SSH Idle Timeout Interval is configured ##########################"
clientaliveinterval=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientaliveinterval)
clientaliveinterval_count=$(echo $clientaliveinterval | cut -d " " -f2)
if [[ "$clientaliveinterval_count" -ge 1 && "$clientaliveinterval_count" -le 900 ]]
then
      echo "Compliant (Action Not Required) - current_status:'$clientaliveinterval'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^ClientAliveInterval" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$clientaliveinterval' modifying_line:'ClientAliveInterval 900' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^ClientAliveInterval.*/ClientAliveInterval 900/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$clientaliveinterval' adding_line:'ClientAliveInterval 900' file:'/etc/ssh/sshd_config'"
                                sed -i "/# problems/a ClientAliveInterval 900" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$clientaliveinterval'"

      fi
fi

clientalivecountmax=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep clientalivecountmax)
clientalivecountmax_count=$(echo $clientalivecountmax | cut -d " " -f2)
if [[ "$clientalivecountmax_count" -eq 0 ]]
then
      echo "Compliant (Action Not Required) - current_status:'$clientalivecountmax'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^ClientAliveCountMax" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$clientalivecountmax' modifying_line:'ClientAliveCountMax 0' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^ClientAliveCountMax.*/ClientAliveCountMax 0/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$clientalivecountmax' adding_line:'ClientAliveCountMax 0' file:'/etc/ssh/sshd_config'"
                                sed -i "/# problems/a ClientAliveCountMax 0" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$clientalivecountmax'"

      fi
fi

echo
echo "########################## Point 158 : Ensure SSH LoginGraceTime is set to one minute or less ##########################"
logingracetime_line=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep logingracetime)
logingracetime=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep logingracetime | cut -d " " -f2)
if [[ "$logingracetime" -le 60 ]]
then
      echo "Compliant (Action Not Required) - current_status:'$logingracetime_line'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^LoginGraceTime" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$logingracetime_line' modifying_line:'LoginGraceTime 60' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^LoginGraceTime.*/LoginGraceTime 60/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$logingracetime_line' adding_line:'LoginGraceTime 60' file:'/etc/ssh/sshd_config'"
                                sed -i "/^# Authentication/a LoginGraceTime 60" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$logingracetime_line'"

      fi
fi

echo
echo "########################## Point 159: Ensure SSH warning banner is configured ##########################"
banner=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep banner)
if [[ "$banner" == "banner /etc/issue.net" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$banner'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^Banner" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$banner' modifying_line:'Banner /etc/issue.net' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^Banner.*/Banner \/etc\/issue.net/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$banner' adding_line:'Banner /etc/issue.net' file:'/etc/ssh/sshd_config'"
                                sed -i "/default banner path/a Banner \/etc\/issue.net" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$banner'"

      fi
fi


echo
echo "########################## Point 160: Ensure SSH PAM is enabled ##########################"
usepam=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i usepam)
if [[ "$usepam" == "usepam yes" ]]
then
      echo "Compliant (Action Not Required) - '$usepam'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^UsePAM" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$usepam' modifying_line:'UsePAM yes' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^UsePAM.*/UsePAM yes/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$usepam' adding_line:'UsePAM yes' file:'/etc/ssh/sshd_config'"
                                sed -i "/# problems/a UsePAM yes" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$usepam'"

      fi
fi


echo
echo "########################## Point 161: Ensure SSH MaxStartups is configured ##########################"
maxstartups=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -iw maxstartups)
if [[ "$maxstartups" == "maxstartups 10:30:60" ]]
then
      echo "Compliant (Action Not Required) - current_status:'$maxstartups'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^MaxStartups" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$maxstartups' modifying_line:'MaxStartups 10:30:60' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^MaxStartups.*/MaxStartups 10:30:60/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$maxstartups' adding_line:'MaxStartups 10:30:60' file:'/etc/ssh/sshd_config'"
                                sed -i "/# problems/a MaxStartups 10:30:60" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$maxstartups'"

      fi
fi

echo
echo "########################## Point 162: Ensure SSH MaxSessions is limited ##########################"
maxsessions=$(sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i maxsessions)
maxsessions_count=$(echo $maxsessions | cut -d " " -f2)
if [[ "$maxsessions_count" -le 10 ]]
then
      echo "Compliant (Action Not Required) - current_status:'$maxsessions'"

else
      if [ "$require_remediation" == "yes" ]
          then
                        if [ "$(grep -i "^MaxSessions" /etc/ssh/sshd_config | wc -l)" == 1 ]
                        then
								echo "Not Compliant (Remediating) - current_status:'$maxsessions' modifying_line:'MaxSessions 10' file:'/etc/ssh/sshd_config'"
                                sed -i "s/^MaxSessions.*/MaxSessions 10/i" /etc/ssh/sshd_config
                                
                        else
                                echo "Not Compliant (Remediating) - current_status:'$maxsessions' adding_line:'MaxSessions 10' file:'/etc/ssh/sshd_config'"
                                sed -i "/# Authentication:/a MaxSessions 10" /etc/ssh/sshd_config
                                
                        fi
      else
         echo "Not Compliant (Action Required) - current_status:'$maxsessions'"

      fi
fi

echo
echo "############################# Point 163: Ensure password creation requirements are configured #############################"
file_status "/etc/security/pwquality.conf"
if [[ "$status" == 1 ]]
then
		min_len=$(grep '^minlen' /etc/security/pwquality.conf)
		min_class=$(grep '^minclass' /etc/security/pwquality.conf)
		if [[ "$min_len" == "minlen = 14" ]] && [[ "$min_class" == "minclass = 4" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$min_len $min_class' file:'/etc/security/pwquality.conf'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						if [ "$(grep '^minlen' /etc/security/pwquality.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$min_len' modifying_line:'minlen = 14' file:'/etc/security/pwquality.conf'"
								sed -i "s/^minlen.*/minlen = 14/i" /etc/security/pwquality.conf

						else
								echo "Not Compliant (Remediating) - current_status:'$min_len' addying_line:'minlen = 14' file:'/etc/security/pwquality.conf'"
								echo "minlen = 14" >> /etc/security/pwquality.conf

						fi
						if [ "$(grep '^minclass' /etc/security/pwquality.conf | wc -l)" -ge 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$min_class' modifying_line:'minclass = 4' file:'/etc/security/pwquality.conf'"
								sed -i "s/^minclass.*/minclass = 4/i" /etc/security/pwquality.conf

						else
								echo "Not Compliant (Remediating) - current_status:'$min_class' addying_line:'minclass = 4' file:'/etc/security/pwquality.conf'"
								echo "minclass = 4" >> /etc/security/pwquality.conf

						fi
				else
						echo "Not Compliant (Action Required) - current_status:'$etc_chrony' file:/etc/security/pwquality.conf"

				fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/security/pwquality.conf' file not found"

fi


echo
echo "############################# Point 164: Ensure lockout for failed password attempts is configured #############################"
file_status "/etc/pam.d/password-auth"
if [[ "$status" == 1 ]]
then
		pass_auth_preauth=$(grep '^auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900' /etc/pam.d/password-auth)
		if [[ "$pass_auth_preauth" == "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pass_auth_preauth' file:'/etc/pam.d/password-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pass_auth_preauth' addying_line:'auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900' file:'/etc/pam.d/password-auth'"
						echo "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900" >> /etc/pam.d/password-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pass_auth_preauth' file:'/etc/pam.d/password-auth'"

				fi
			fi
			
		pass_auth_authfail=$(grep '^auth \[default=die\] pam_faillock.so authfail audit deny=5 unlock_time=900' /etc/pam.d/password-auth)
		if [[ "$pass_auth_authfail" == "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pass_auth_authfail' file:'/etc/pam.d/password-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pass_auth_authfail' addying_line:'auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900' file:'/etc/pam.d/password-auth'"
						echo "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900" >> /etc/pam.d/password-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pass_auth_authfail' file:'/etc/pam.d/password-auth'"

				fi
			fi
			
		pass_auth_req=$(grep '^account required pam_faillock.so' /etc/pam.d/password-auth)
		if [[ "$pass_auth_req" == "account required pam_faillock.so" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pass_auth_req' file:'/etc/pam.d/password-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pass_auth_req' addying_line:'account required pam_faillock.so' file:'/etc/pam.d/password-auth'"
						echo "account required pam_faillock.so" >> /etc/pam.d/password-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pass_auth_req' file:'/etc/pam.d/password-auth'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/pam.d/password-auth' file not found"

fi

file_status "/etc/pam.d/system-auth"
if [[ "$status" == 1 ]]
then
		pass_auth_preauth=$(grep '^auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900' /etc/pam.d/system-auth)
		if [[ "$pass_auth_preauth" == "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pass_auth_preauth' file:'/etc/pam.d/system-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pass_auth_preauth' addying_line:'auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900' file:'/etc/pam.d/system-auth'"
						echo "auth required pam_faillock.so preauth silent audit deny=5 unlock_time=900" >> /etc/pam.d/system-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pass_auth_preauth' file:'/etc/pam.d/system-auth'"

				fi
			fi
			
		pass_auth_authfail=$(grep '^auth \[default=die\] pam_faillock.so authfail audit deny=5 unlock_time=900' /etc/pam.d/system-auth)
		if [[ "$pass_auth_authfail" == "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pass_auth_authfail' file:'/etc/pam.d/system-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pass_auth_authfail' addying_line:'auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900' file:'/etc/pam.d/system-auth'"
						echo "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900" >> /etc/pam.d/system-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pass_auth_authfail' file:'/etc/pam.d/system-auth'"

				fi
			fi
			
		pass_auth_req=$(grep '^account required pam_faillock.so' /etc/pam.d/system-auth)
		if [[ "$pass_auth_req" == "account required pam_faillock.so" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pass_auth_req' file:'/etc/pam.d/system-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pass_auth_req' addying_line:'account required pam_faillock.so' file:'/etc/pam.d/system-auth'"
						echo "account required pam_faillock.so" >> /etc/pam.d/system-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pass_auth_req' file:'/etc/pam.d/system-auth'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/pam.d/system-auth' file not found"

fi

echo
echo "############################# Point 166: Ensure password reuse is limited #############################"
file_status "/etc/pam.d/password-auth"
if [[ "$status" == 1 ]]
then
		pamd_pass_auth=$(grep '^password required pam_pwhistory.so remember=5' /etc/pam.d/password-auth)
		if [[ "$pamd_pass_auth" == "password required pam_pwhistory.so remember=5" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pamd_pass_auth' file:'/etc/pam.d/password-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pamd_pass_auth' addying_line:'password required pam_pwhistory.so remember=5' file:'/etc/pam.d/password-auth' file:'/etc/pam.d/password-auth'"
						echo "password required pam_pwhistory.so remember=5" >> /etc/pam.d/password-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pamd_pass_auth' file:'/etc/pam.d/password-auth'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/pam.d/password-auth' file not found"

fi

file_status "/etc/pam.d/system-auth"
if [[ "$status" == 1 ]]
then
		pamd_sys_auth=$(grep '^password required pam_pwhistory.so remember=5' /etc/pam.d/system-auth)
		if [[ "$pamd_sys_auth" == "password required pam_pwhistory.so remember=5" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$pamd_sys_auth' file:'/etc/pam.d/system-auth'"

		else
				if [ "$require_remediation" == "yes" ]
				then
						echo "Not Compliant (Remediating) - current_status:'$pamd_sys_auth' addying_line:'password required pam_pwhistory.so remember=5' file:'/etc/pam.d/system-auth'"
						echo "password required pam_pwhistory.so remember=5" >> /etc/pam.d/system-auth

				else
							echo "Not Compliant (Action Required) - current_status:'$pamd_sys_auth' file:'/etc/pam.d/system-auth'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/pam.d/system-auth' file not found"

fi


echo
echo "############################# Point 168: Ensure default group for the root account is GID 0 #############################"
file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
		root_gid=$(grep "^root:" /etc/passwd | cut -f4 -d:)
		if [[ "$root_gid" == "0" ]]
		then
				echo "Compliant (Action Not Required) - $(grep "^root:" /etc/passwd)"

		else
				echo "Not Compliant (Manual Intervention Required) - user:'root' gid:'$root_gid'"

		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/passwd' file not found"

fi

echo
echo "############################# Point 169: Ensure default user shell timeout is configured #############################"
file_status "/etc/bashrc"
if [[ "$status" == 1 ]]
then
		bashrc_readonly=$(grep "^readonly TMOUT=900 ; export TMOUT" /etc/bashrc)
		if [[ "$bashrc_readonly" == "readonly TMOUT=900 ; export TMOUT" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$bashrc_readonly' file:'/etc/bashrc'"

		else
				if [ "$require_remediation" == "yes" ]
				then
							echo "Not Compliant (Remediating) - current_status:'$bashrc_readonly' addying_line:'readonly TMOUT=900 ; export TMOUT' file:'/etc/bashrc'"
							echo "readonly TMOUT=900 ; export TMOUT" >> /etc/bashrc

				else
							echo "Not Compliant (Action Required) - current_status:'$bashrc_readonly' file:'/etc/bashrc'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/bashrc' file not found"

fi

file_status "/etc/profile"
if [[ "$status" == 1 ]]
then
		profile_readonly=$(grep "^readonly TMOUT=900 ; export TMOUT" /etc/profile)
		if [[ "$profile_readonly" == "readonly TMOUT=900 ; export TMOUT" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$profile_readonly' file:'/etc/profile'"

		else
				if [ "$require_remediation" == "yes" ]
				then
							echo "Not Compliant (Remediating) - current_status:'$profile_readonly' addying_line:'readonly TMOUT=900 ; export TMOUT' file:'/etc/profile'"
							echo "readonly TMOUT=900 ; export TMOUT" >> /etc/profile

				else
							echo "Not Compliant (Action Required) - current_status:'$profile_readonly' file:'/etc/profile'"

				fi
			fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/profile' file not found"

fi

ls /etc/profile.d/*.sh | while read -r profile_filenames
do
		bashrc_readonly=$(grep "^readonly TMOUT=900 ; export TMOUT" $profile_filenames)
		if [[ "$bashrc_readonly" == "readonly TMOUT=900 ; export TMOUT" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$bashrc_readonly' file:'$profile_filenames'"

		else
				if [ "$require_remediation" == "yes" ]
				then
							echo "Not Compliant (Remediating) - current_status:'$bashrc_readonly' addying_line:'readonly TMOUT=900 ; export TMOUT' file:'$profile_filenames'"
							echo "readonly TMOUT=900 ; export TMOUT" >> $profile_filenames

				else
							echo "Not Compliant (Action Required) - current_status:'$bashrc_readonly' file:'$profile_filenames'"

				fi
		fi

		profile_readonly=$(grep "^readonly TMOUT=900 ; export TMOUT" $profile_filenames)
		if [[ "$profile_readonly" == "readonly TMOUT=900 ; export TMOUT" ]]
		then
				echo "Compliant (Action Not Required) - current_status:'$profile_readonly' file:'$profile_filenames'"

		else
				if [ "$require_remediation" == "yes" ]
				then
							echo "Not Compliant (Remediating) - current_status:'$profile_readonly' addying_line:'readonly TMOUT=900 ; export TMOUT' file:'$profile_filenames'"
							echo "readonly TMOUT=900 ; export TMOUT" >> $profile_filenames

				else
							echo "Not Compliant (Action Required) - current_status:'$profile_readonly' file:'$profile_filenames'"

				fi
		fi
done


echo
echo "############################# Point 171: Ensure password expiration is 365 days or less #############################"
file_status "/etc/login.defs"
if [[ "$status" == 1 ]]
then
		pass_max_days=$(grep -i "^PASS_MAX_DAYS" /etc/login.defs)
		pass_max_days_count=$(grep -i "^PASS_MAX_DAYS" /etc/login.defs | awk '{print $2}')
		if [[ "$pass_max_days_count" == "365" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$pass_max_days' file:/etc/login.defs"

		else
			  if [ "$require_remediation" == "yes" ]
				  then
						if [ "$(grep -i "^PASS_MAX_DAYS" /etc/login.defs | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$pass_max_days' modifying_line:'PASS_MAX_DAYS 365' file:'/etc/login.defs'"
								sed -i "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 365/i" /etc/login.defs

						else
								echo "Not Compliant (Remediating) - current_status:'$pass_max_days' addying_line:'PASS_MAX_DAYS 365' file:'/etc/login.defs'"
								sed -i "/^# Password aging controls:*/a PASS_MAX_DAYS 365" /etc/login.defs

						fi
			  else
				 echo "Not Compliant (Action Required) - current_status:'$pass_max_days' file:'/etc/login.defs'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/login.defs' file not found"

fi

file_status "/etc/shadow"
if [[ "$status" == 1 ]]
then
		grep /bin/bash /etc/passwd | cut -d: -f1 | while read -r users
		do
			#grep -i '$users' /etc/shadow | cut -d: -f5
			users_pass_max_days=$(grep -wi "$users" /etc/shadow | cut -d: -f5)
			if [[ "$users_pass_max_days" == "365" ]]
			then
					echo "Compliant (Action Not Required) - user:'$users' pass_max_days:'$users_pass_max_days'"

			else
					if [ "$require_remediation" == "yes" ]
					then
							echo "Not Compliant (Remediating) - user:'$users' pass_max_days:'$users_pass_max_days'"

							chage --maxdays 365 $users
					else
							echo "Not Compliant (Action Required) - user:'$users' pass_max_days:'$users_pass_max_days'"

					fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/login.defs' file not found"

fi


echo
echo "############################# Point 172: Ensure minimum days between password changes is configured #############################"
file_status "/etc/login.defs"
if [[ "$status" == 1 ]]
then
		pass_min_days=$(grep -i "^PASS_MIN_DAYS" /etc/login.defs)
		pass_min_days_count=$(grep -i "^PASS_MIN_DAYS" /etc/login.defs | awk '{print $2}')
		if [[ "$pass_min_days_count" == "1" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$pass_min_days' file:'/etc/login.defs'"

		else
			  if [ "$require_remediation" == "yes" ]
			  then
						if [ "$(grep -i "^PASS_MIN_DAYS" /etc/login.defs | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$pass_min_days' modifying_line:'PASS_MIN_DAYS 1' file:'/etc/login.defs'"
								sed -i "s/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 1/i" /etc/login.defs

						else
								echo "Not Compliant (Remediating) - current_status:'$pass_min_days' addying_line:'PASS_MIN_DAYS 1' file:'/etc/login.defs'"
								sed -i "/^# Password aging controls:*/a PASS_MIN_DAYS 1" /etc/login.defs

						fi
			  else
						echo "Not Compliant (Action Required) - current_status:'$pass_min_days' file:'/etc/login.defs'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/login.defs' file not found"

fi

file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
		grep /bin/bash /etc/passwd | cut -d: -f1 | while read -r users
		do
			users_pass_min_days=$(grep -wi "$users" /etc/shadow | cut -d: -f4)
			if [[ "$users_pass_min_days" == "1" ]]
			then
					echo "Compliant (Action Not Required) - user:'$users' pass_min_days:'$users_pass_min_days'"

			else
					if [ "$require_remediation" == "yes" ]
					then
							echo "Not Compliant (Remediating) - user:'$users' current_pass_min_days:'$users_pass_min_days' new_pass_min_days:'1'"

							chage --mindays 1 $users
					else
							echo "Not Compliant (Action Required) - user:'$users' current_pass_min_days:'$users_pass_min_days'"

					fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/passwd' file not found"

fi

echo
echo "############################# Point 173: Ensure password expiration warning days is 7 or more #############################"
file_status "/etc/login.defs"
if [[ "$status" == 1 ]]
then
		pass_warn_age=$(grep -i "^PASS_WARN_AGE" /etc/login.defs)
		pass_warn_age_count=$(grep -i "^PASS_WARN_AGE" /etc/login.defs | awk '{print $2}')
		if [[ "$pass_warn_age_count" == "7" ]]
		then
			  echo "Compliant (Action Not Required) - current_status:'$pass_warn_age' file:'/etc/login.defs'"

		else
			  if [ "$require_remediation" == "yes" ]
			  then
						if [ "$(grep -i "^PASS_WARN_AGE" /etc/login.defs | wc -l)" == 1 ]
						then
								echo "Not Compliant (Remediating) - current_status:'$pass_warn_age' modifying_line:'PASS_WARN_AGE 7' file:'/etc/login.defs'"
								sed -i "s/^PASS_WARN_AGE.*/PASS_WARN_AGE 7/i" /etc/login.defs

						else
								echo "Not Compliant (Remediating) - current_status:'$pass_warn_age' addying_line:'PASS_WARN_AGE 7' file:'/etc/login.defs'"
								sed -i "/^# Password aging controls:*/a PASS_WARN_AGE 7" /etc/login.defs

						fi
			  else
						echo "Not Compliant (Action Required) - current_status:'$pass_warn_age' file:'/etc/login.defs'"

			  fi
		fi
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/login.defs' file not found"

fi

file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
		grep /bin/bash /etc/passwd | cut -d: -f1 | while read -r users
		do
			users_pass_warn_age=$(grep -wi "$users" /etc/shadow | cut -d: -f6)
			if [[ "$users_pass_warn_age" == "7" ]]
			then
					echo "Compliant (Action Not Required) - user:'$users' pass_warn_age:'$users_pass_warn_age'"

			else
					if [ "$require_remediation" == "yes" ]
					then
							echo "Not Compliant (Remediating) - user:'$users' current_pass_warn_age:'$users_pass_warn_age' new_pass_warn_age:'7'"

							chage --warndays 7 $users
					else
							echo "Not Compliant (Action Required) - user:'$users' pass_warn_age:'$users_pass_warn_age'"

					fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/login.defs' file not found"

fi


echo
echo "############################# Point 174: Ensure inactive password lock is 30 days or less #############################"
file_status "/etc/shadow"
if [[ "$status" == 1 ]]
then
		grep /bin/bash /etc/passwd | cut -d: -f1 | while read -r users
		do
			users_pass_inc_lock=$(grep -wi "$users" /etc/shadow | cut -d: -f7)
			if [[ "$users_pass_inc_lock" == "30" ]]
			then
					echo "Compliant (Action Not Required) - user:'$users' current_inactive_pass_lock:'$users_pass_inc_lock'"

			else
					if [ "$require_remediation" == "yes" ]
					then
							echo "Not Compliant (Remediating) - user:'$users' current_inactive_pass_lock:'$users_pass_inc_lock' new_inactive_pass_lock:'30'"

							chage --inactive 30 $users
					else
							echo "Not Compliant (Action Required) - user:'$users' current_inactive_pass_lock:'$users_pass_inc_lock'"

					fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/shadow' file not found"

fi


echo
echo "########################## Point 176: Ensure permissions on /etc/passwd are configured ##########################"
etc_passwd_uid=$(stat /etc/passwd -c "%U")
etc_passwd_gid=$(stat /etc/passwd -c "%G")
etc_passwd_per=$(stat /etc/passwd -c "%a")
if [[ "$etc_passwd_uid" == "root" ]] && [[ "$etc_passwd_gid" == "root" ]] && [[ "$etc_passwd_per" -le 644 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/passwd' current_owner_user:'$etc_passwd_uid' current_owner_group:'$etc_passwd_gid' current_permission:'$etc_passwd_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/passwd' current_owner_user:'$etc_passwd_uid' current_owner_group:'$etc_passwd_gid' current_permission:'$etc_passwd_per'"
			chown root:root /etc/passwd
			chmod 644 /etc/passwd
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/passwd' current_owner_user:'$etc_passwd_uid' current_owner_group:'$etc_passwd_gid' current_permission:'$etc_passwd_per'"

      fi
fi


echo
echo "########################## Point 177: Ensure permissions on /etc/passwd- are configured ##########################"
etc_passwd2_uid=$(stat /etc/passwd- -c "%U")
etc_passwd2_gid=$(stat /etc/passwd- -c "%G")
etc_passwd2_per=$(stat /etc/passwd- -c "%a")
if [[ "$etc_passwd2_uid" == "root" ]] && [[ "$etc_passwd2_gid" == "root" ]] && [[ "$etc_passwd2_per" -le 644 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/passwd-' current_owner_user:'$etc_passwd2_uid' current_owner_group:'$etc_passwd2_gid' current_permission:'$etc_passwd2_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/passwd-' current_owner_user:'$etc_passwd2_uid' current_owner_group:'$etc_passwd2_gid' current_permission:'$etc_passwd2_per'"
			chown root:root /etc/passwd-
			chmod 644 /etc/passwd-
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/passwd-' current_owner_user:'$etc_passwd2_uid' current_owner_group:'$etc_passwd2_gid' current_permission:'$etc_passwd2_per'"

      fi
fi

echo
echo "########################## Point 178: Ensure permissions on /etc/shadow are configured ##########################"
etc_shadow_uid=$(stat /etc/shadow -c "%U")
etc_shadow_gid=$(stat /etc/shadow -c "%G")
etc_shadow_per=$(stat /etc/shadow -c "%a")
if [[ "$etc_shadow_uid" == "root" ]] && [[ "$etc_shadow_gid" == "root" ]] && [[ "$etc_shadow_per" -eq 0 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/shadow' current_owner_user:'$etc_shadow_uid' current_owner_group:'$etc_shadow_gid' current_permission:'$etc_shadow_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/shadow' current_owner_user:'$etc_shadow_uid' current_owner_group:'$etc_shadow_gid' current_permission:'$etc_shadow_per'"
			chown root:root /etc/shadow
			chmod 000 /etc/shadow
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/shadow' current_owner_user:'$etc_shadow_uid' current_owner_group:'$etc_shadow_gid' current_permission:'$etc_shadow_per'"

      fi
fi


echo
echo "########################## Point 179: Ensure permissions on /etc/shadow- are configured ##########################"
etc_shadow2_uid=$(stat /etc/shadow- -c "%U")
etc_shadow2_gid=$(stat /etc/shadow- -c "%G")
etc_shadow2_per=$(stat /etc/shadow- -c "%a")
if [[ "$etc_shadow2_uid" == "root" ]] && [[ "$etc_shadow2_gid" == "root" ]] && [[ "$etc_shadow2_per" -eq 0 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/shadow-' current_owner_user:'$etc_shadow2_uid' current_owner_group:'$etc_shadow2_gid' current_permission:'$etc_shadow2_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/shadow-' current_owner_user:'$etc_shadow2_uid' current_owner_group:'$etc_shadow2_gid' current_permission:'$etc_shadow2_per'"
			chown root:root /etc/shadow-
			chmod 000 /etc/shadow-
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/shadow-' current_owner_user:'$etc_shadow2_uid' current_owner_group:'$etc_shadow2_gid' current_permission:'$etc_shadow2_per'"

      fi
fi

echo
echo "########################## Point 180: Ensure permissions on /etc/gshadow- are configured ##########################"
etc_gshadow2_uid=$(stat /etc/gshadow- -c "%U")
etc_gshadow2_gid=$(stat /etc/gshadow- -c "%G")
etc_gshadow2_per=$(stat /etc/gshadow- -c "%a")
if [[ "$etc_gshadow2_uid" == "root" ]] && [[ "$etc_gshadow2_gid" == "root" ]] && [[ "$etc_gshadow2_per" -eq 0 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/gshadow-' current_owner_user:'$etc_gshadow2_uid' current_owner_group:'$etc_gshadow2_gid' current_permission:'$etc_gshadow2_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/gshadow-' current_owner_user:'$etc_gshadow2_uid' current_owner_group:'$etc_gshadow2_gid' current_permission:'$etc_gshadow2_per'"
			chown root:root /etc/gshadow-
			chmod 000 /etc/gshadow-
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/gshadow-' current_owner_user:'$etc_gshadow2_uid' current_owner_group:'$etc_gshadow2_gid' current_permission:'$etc_gshadow2_per'"

      fi
fi

echo
echo "########################## Point 181: Ensure permissions on /etc/gshadow are configured ##########################"
etc_gshadow_uid=$(stat /etc/gshadow -c "%U")
etc_gshadow_gid=$(stat /etc/gshadow -c "%G")
etc_gshadow_per=$(stat /etc/gshadow -c "%a")
if [[ "$etc_gshadow_uid" == "root" ]] && [[ "$etc_gshadow_gid" == "root" ]] && [[ "$etc_gshadow_per" -eq 0 ]]
then
      echo "Compliant (Action Not Required) - file:'/etc/gshadow' current_owner_user:'$etc_gshadow_uid' current_owner_group:'$etc_gshadow_gid' current_permission:'$etc_gshadow_per'"

else
      if [ "$require_remediation" == "yes" ]
      then
			echo "Not Compliant (Remediating) - file:'/etc/gshadow' current_owner_user:'$etc_gshadow_uid' current_owner_group:'$etc_gshadow_gid' current_permission:'$etc_gshadow_per'"
			chown root:root /etc/gshadow
			chmod 000 /etc/gshadow
            
      else
			echo "Not Compliant (Action Required) - file:'/etc/gshadow' current_owner_user:'$etc_gshadow_uid' current_owner_group:'$etc_gshadow_gid' current_permission:'$etc_gshadow_per'"

      fi
fi


echo
echo "############################# Point 182: Ensure permissions on /etc/group are configured #############################"
etc_grp_perm=$(stat /etc/group -c "%a")
etc_grp_own_uid=$(stat /etc/group -c "%U")
etc_grp_own_gid=$(stat /etc/group -c "%G")
if [ "$etc_grp_perm" -le 644 ] &&  [ "$etc_grp_own_uid" == "root" ] && [ "$etc_grp_own_gid" == "root" ]
then
		echo "Compliant (Action Not Required) - file:'/etc/group'  owner_uid:'$etc_grp_own_uid' owner_gid:'$etc_grp_own_gid' current_permission:'$etc_grp_perm'"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - file:'/etc/group'  owner_uid:'$etc_grp_own_uid' owner_gid:'$etc_grp_own_gid' current_permission:'$etc_grp_perm'"
			chown root:root /etc/group
			chmod u-x,g-wx,o-wx /etc/group

		else
			echo "Not Compliant (Action Required) - file:'/etc/group' owner_uid:'$etc_grp_own_uid' owner_gid:'$etc_grp_own_gid' current_permission:'$etc_grp_perm'"

		fi
fi

echo
echo "############################# Point 183: Ensure permissions on /etc/group- are configured #############################"
etc_grp2_perm=$(stat /etc/group- -c "%a")
etc_grp2_own_uid=$(stat /etc/group- -c "%U")
etc_grp2_own_gid=$(stat /etc/group- -c "%G")
if [ "$etc_grp2_perm" -le 644 ] &&  [ "$etc_grp2_own_uid" == "root" ] && [ "$etc_grp2_own_gid" == "root" ]
then
		echo "Compliant (Action Not Required) - file:'/etc/group-'  owner_uid:'$etc_grp2_own_uid' owner_gid:'$etc_grp2_own_gid' current_permission:'$etc_grp2_perm'"

else
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - File:'/etc/group-'  owner_uid:'$etc_grp2_own_uid' owner_gid:'$etc_grp2_own_gid' current_permission:'$etc_grp2_perm'"
			chown root:root /etc/group-
			chmod u-x,go-wx /etc/group-

		else
			echo "Not Compliant (Action Required) - File:'/etc/group-'  owner_uid:'$etc_grp2_own_uid' owner_gid:'$etc_grp2_own_gid' current_permission:'$etc_grp2_perm'"

		fi
fi

echo
echo "############################# Point 199: Ensure all users' home directories exist #############################"
awk -F: '($1!~/(halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir
do
	if [ ! -d "$dir" ]
	then
		if [ "$require_remediation" == "yes" ]
		then
			echo "Not Compliant (Remediating) - user:'$user' home_dir:'$dir'"
			mkdir "$dir"
			chmod g-w,o-wrx "$dir"
			chown "$user" "$dir"

		else
			echo "Not Compliant (Action Required) - user:'$user' home_dir:'$dir'"

		fi
	else
		echo "Compliant (Action Not Required) - user:'$user' home_dir:'$dir'"

	fi
done


echo
echo "############################# Point 200: Ensure users own their home directories #############################"
file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
		awk -F: '($1!~/(halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir
		do
			if [ ! -d "$dir" ]
			then
				echo "Pending - user:'$user' home_dir:'$dir does not exist'"

			else
				owner=$(stat -L -c "%U" "$dir")
				if [ "$owner" != "$user" ]
				then
					if [ "$require_remediation" == "yes" ]
					then
						echo "Not Compliant (Remediating) - user:'$user' home_dir:'$dir' current_owner:'$owner'"
						chmod g-w,o-rwx "$dir"
						chown "$user" "$dir"

					else
						echo "Not Compliant (Action Required) - user:'$user' home_dir:'$dir' current_owner:'$owner'"

					fi
				else
					echo "Compliant (Action Not Required) - user:'$user' home_dir:'$dir' current_owner:'$owner'"

				fi
			fi
		done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/passwd' file not found"

fi


echo
echo "############################# Point 201: Ensure users' home directories permissions are 750 or more restrictive #############################"
file_status "/etc/passwd"
if [[ "$status" == 1 ]]
then
awk -F: '($1!~/(halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) {print $1 " " $6}' /etc/passwd | while read -r user dir
do
	if [ ! -d "$dir" ]
	then
		echo "Not Compliant (Manual Intervention Required) - user:'$user' home_dir:'$dir doesnot exist'"

	else
		dirperm=$(stat -L -c "%A" "$dir")
		if [ "$(echo "$dirperm" | cut -c6)" != "-" ] || [ "$(echo "$dirperm" | cut -c8)" != "-" ] || [ "$(echo "$dirperm" | cut -c9)" != "-" ] || [ "$(echo "$dirperm" | cut -c10)" != "-" ]
		then
			if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - user:'$user' home_dir:'$dir' current_permission:'$dirperm'"
				chmod g-w,o-rwx "$dir"

			else
				echo "Not Compliant (Action Required) - user:'$user' home_dir:'$dir' current_permission:'$dirperm'"

			fi
		else
			echo "Compliant (Action Not Required) - user:'$user' home_dir:'$dir' current_permission:'$dirperm'"

		fi
	fi
done
else
		echo "Not Compliant (Manual Intervention Required) - '/etc/passwd' file not found"

fi


echo
echo "############################# Point 203: Ensure no users have .forward files #############################"
awk -F: '($1!~/(root|halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir
do
	if [ -d "$dir" ]
	then
		file="$dir/.forward"
		if [ ! -h "$file" ] && [ -f "$file" ]
		then
			if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - user:'$user' removing_file:'$file'"
				rm -r "$file"

			else
				echo "Not Compliant (Action Required) - user:'$user' file:'$file'"

			fi 
		else
			echo "Compliant (Action Not Required) - user:'$user' file:'$file not found'"

		fi
	fi
done


echo
echo "############################# Point 204: Ensure no users have .netrc files #############################"
awk -F: '($1!~/(root|halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir
do
	if [ -d "$dir" ]
	then
		file="$dir/.netrc"
		if [ ! -h "$file" ] && [ -f "$file" ]
		then
			if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - user:'$user' removing_file:'$file'"
				rm -r "$file"

			else
				echo "Not Compliant (Action Required) - user:'$user' file:'$file'"

			fi 
		else
			echo "Compliant (Action Not Required) - user:'$user' file:'$file not found'"

		fi
	fi
done

echo
echo "############################# Point 205: Ensure no users have .rhosts files #############################"
awk -F: '($1!~/(root|halt|sync|shutdown|nfsnobody)/ && $7!~/^(\/usr)?\/sbin\/nologin(\/)?$/ && $7!~/(\/usr)?\/bin\/false(\/)?$/) { print $1 " " $6 }' /etc/passwd | while read -r user dir
do
	if [ -d "$dir" ]
	then
		file="$dir/.rhosts"
		if [ ! -h "$file" ] && [ -f "$file" ]
		then
			if [ "$require_remediation" == "yes" ]
			then
				echo "Not Compliant (Remediating) - user:'$user' file:'$file'"
				rm -r "$file"

			else
				echo "Not Compliant (Action Required) - user:'$user' file:'$file'"

			fi 
		else
			echo "Compliant (Action Not Required) - user:'$user' file:'$file not found'"

		fi
	fi
done

#sed -i '1i Point No,Baseline Name,Compliant,Remediation Performed' $baseline_report
