#!/bin/bash

# Define the list of DNS servers
declare -a DNS_SERVERS=(
	"Shecan DNS|178.22.122.100,185.51.200.2"
	"Begzar DNS|185.55.225.25,185.55.226.26"
	"403 DNS|10.202.10.202,10.202.10.102"
	"Radar DNS|10.202.10.10,10.202.10.11"
	
)

# Get the name of the default network interface
INTERFACE=$(ip route | awk '/^default/ {print $5}')

# Exit the script if no default interface is found
if [[ -z "$INTERFACE" ]]; then
    echo "Unable to detect default network interface. Exiting."
    exit 1
fi

# Function to display the list of DNS servers
display_dns_servers() {
	echo "Select a DNS server to set:"
	for i in "${!DNS_SERVERS[@]}"; do
		IFS="|" read -ra DNS <<< "${DNS_SERVERS[$i]}"
		echo "[$i] ${DNS[0]}"
	done
}

# Function to validate user input
validate_input() {
	local selection="$1"
	if [[ "$selection" =~ ^[0-9]+$ && "$selection" -ge 0 && "$selection" -lt "${#DNS_SERVERS[@]}" ]]; then
		return 0
	else
		echo "Invalid selection. Please try again."
		return 1
	fi
}

# Function to set the DNS servers
set_dns_servers() {
	local servers="$1"
	echo "Setting DNS server to $servers"
	if nmcli dev modify $INTERFACE ipv4.dns "$servers"; then
		echo "Restarting network manager service..."
		if sudo systemctl restart systemd-networkd; then
			echo "Done."
			return 0
		else
			echo "Failed to restart network manager service."
			return 1
		fi
	else
		echo "Failed to set DNS servers."
		return 1
	fi
}

# Function to clear the DNS servers
clear_dns_servers() {
	echo "Clearing DNS servers..."
	if nmcli dev modify $INTERFACE ipv4.dns ""; then
		echo "Restarting network manager service..."
		if sudo systemctl restart systemd-networkd; then
			echo "Done."
			return 0
		else
			echo "Failed to restart network manager service."
			return 1
		fi
	else
		echo "Failed to clear DNS servers."
		return 1
	fi
}

# Main script
echo "Select an action:"
echo "[1] Set DNS servers"
echo "[2] Clear DNS servers"
read -p "Enter a number (1-2): " action

case "$action" in
	1)
		display_dns_servers
		while true; do
			read -p "Enter a number (0-${#DNS_SERVERS[@]}): " selection
			if validate_input "$selection"; then
				IFS="|" read -ra DNS <<< "${DNS_SERVERS[$selection]}"
				SERVERS="${DNS[1]}"
				if set_dns_servers "$SERVERS"; then
					break
				else
					echo "Failed to set DNS servers. Please try again."
				fi
			fi
		done
		;;
	2)
		if clear_dns_servers; then
			exit 0
		else
			echo "Failed to clear DNS servers. Please try again."
			exit 1
		fi
		;;
	*)
		echo "Invalid selection. Exiting."
		exit 1
		;;
esac
