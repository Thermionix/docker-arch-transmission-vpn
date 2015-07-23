FROM base/archlinux
MAINTAINER thermionix

RUN		pacman-key --refresh-keys
RUN		pacman -Syu --noconfirm
RUN		pacman-db-upgrade
RUN		pacman -S --noconfirm supervisor net-tools openvpn transmission-cli
RUN		pacman -Scc --noconfirm

#RUN		echo -e "net.core.rmem_max = 16777216\nnet.core.wmem_max = 4194304" > /etc/sysctl.conf

ADD		iptables.sh /usr/local/bin/iptables.sh
RUN		chmod +x /usr/local/bin/*.sh

ADD		iptables.ini /etc/supervisor.d/iptables.ini
ADD		openvpn.ini /etc/supervisor.d/openvpn.ini
ADD		transmission.ini /etc/supervisor.d/transmission.ini

VOLUME ["/data"]
VOLUME ["/var/lib/transmission"]
VOLUME ["/etc/openvpn"]

EXPOSE 9091

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]

# init with --rpc-bind-address 0.0.0.0 --no-portmap
