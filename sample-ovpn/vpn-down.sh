#!/bin/bash

sed -i -e 's/"bind-address-ipv4":.*/"bind-address-ipv4": "127.0.0.1",/' /var/lib/transmission/settings.json
kill -s SIGHUP `pidof transmission-daemon`
