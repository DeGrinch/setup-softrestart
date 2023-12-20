#!bin/bash

# This script will install kexec-tools
# It will create a scripts directory
# It will create a reboot.sh script for user selectbale reboot options
# It will create a softrestart.sh where option 1 is automatically selected and the system reboots

# Kexec-Tools as well as the additional scripts, are desinged to restart the kernel without
# Recycling or rebooting the power to the system or server hardware
# Once this install has completed, rebooting the system without restarting the hardware
# is as simple as running:  /scripts/softrestart.sh from your teminal.

# About the Kexec-tools and kexec-reboot.sh
# This script reads kernel information from the GRUB menu to pass to "kexec".
# Save a script as, e.g., /usr/local/sbin/kexec-reboot and make it executable
# using chmod +x.

# The script takes an item number as its first parameter. E.g., to boot the
# first item in the GRUB menu, type:
#     kexec-reboot 1

# Alternatively, if no number is given, the script will interactively prompt
# for a number.

# The error checking is very basic.
# Written by Isaac G, 2010
# Modified by Greg Fitzgerald, 2011
# Ripped from the Arch Wiki "kexec" page 7 May 2012:
#     https://wiki.archlinux.org/index.php?title=kexec

# Creating scripts directory, and navigating to it

cd /
mkdir scripts
cd /scripts
sleep 1

# Creating the script reboot.sh
touch reboot.sh
nano reboot.sh

# Creating the contents of reboot.sh
cat << 'EOF' > reboot.sh
#!/bin/bash

# This script will initiate the reboot process using kexec-tools
echo "Please select the next step in this process by selecting the corresponding number from the list, and then press enter."
echo "In future for a STANDARD reboot run: /scripts/softrestart.sh"
sudo /usr/local/sbin/kexec-reboot
EOF

# Making reboot.sh executable
chmod +x reboot.sh

# Creating the script softrestart.sh
touch softrestart.sh
nano softrestart.sh

# Create the contents of softrestart.sh
cat << 'EOF' > softrestart.sh
#!/bin/bash

# This script will initiate the reboot process using kexec-tools
echo "Please wait, restarting the kernal now"
sudo /usr/local/sbin/kexec-reboot 1
EOF

# Make softrestart.sh executable
chmod +x softrestart.sh

# Navigating back to root directory
cd /

# Install kexec-tools
echo "Installing the kexec-tools"
sudo apt-get install -y kexec-tools

# Download kexec-reboot script
echo "Downloading the kexec-reboot script"
wget https://raw.githubusercontent.com/vadmium/kexec-reboot/master/kexec-reboot

# Make kexec-reboot executable
echo "Making the kexec-reboot script executable"
chmod +x kexec-reboot

# Move kexec-reboot to /usr/local/sbin/
echo "Moving the kexec-reboot to /usr/local/sbin/"
sudo mv kexec-reboot /usr/local/sbin/kexec-reboot

# Run kexec-reboot
echo "Now RUNNING AN  EXAMPLE   kexec-reboot .... Press CTRL+C to terminate the prompt"
echo "Now RUNNING AN  EXAMPLE   kexec-reboot .... Press CTRL+C to terminate the prompt"
echo "Now RUNNING AN  EXAMPLE   kexec-reboot .... Press CTRL+C to terminate the prompt"
echo "Now RUNNING AN  EXAMPLE   kexec-reboot .... Press CTRL+C to terminate the prompt"
echo "In future, to review this reboot process with options run: /scripts/reboot.sh"
sudo /usr/local/sbin/kexec-reboot

