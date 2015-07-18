#!/bin/bash

sed -i -e 's/"bind-address-ipv4":.*/"bind-address-ipv4": "'"$ifconfig_local"'",/' /var/lib/transmission/settings.json
kill -s SIGHUP `pidof transmission-daemon`
