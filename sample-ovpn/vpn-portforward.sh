#!/bin/bash

(
while true
do

sleep 10

PIA_PASSWD_FILE=/etc/openvpn/vpn.cred
pia_client_id_file=/var/lib/transmission/pia_client_id
transmission_settings_file=/var/lib/transmission/settings.json

pia_username=$(head -1 $PIA_PASSWD_FILE)
pia_passwd=$(tail -1 $PIA_PASSWD_FILE)

local_vpn_ip=$(ip addr show tun0 | grep inet | awk '{ print $2 }')
port_assignment_url=https://www.privateinternetaccess.com/vpninfo/port_forward_assignment

new_client_id() {
    head -n 100 /dev/urandom | md5sum | tr -d " -" | tee $pia_client_id_file
}

pia_client_id="$(cat $pia_client_id_file 2>/dev/null)"
if [ -z ${pia_client_id} ]; then
     echo "Generating new client id for PIA"
     pia_client_id=$(new_client_id)
fi

pia_response=$(curl -d "user=$pia_username&pass=$pia_passwd&client_id=$pia_client_id&local_ip=$local_vpn_ip" $port_assignment_url)

new_port=$(echo $pia_response | grep -oE "[0-9]+")
echo "Got new port $new_port from pia"

transmission_peer_port="$(transmission-remote -si | grep Listenport | grep -oE '[0-9]+')"
if [ "$new_port" != "$transmission_peer_port" ] ; then
	echo "Updating transmission port : $new_port"
	transmission-remote $myauth -p "$new_port"
	sleep 15 && transmission-remote -pt
fi

sleep 50m

done
) &
