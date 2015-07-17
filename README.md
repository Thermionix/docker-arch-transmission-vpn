# docker-transmission-openvpn-master

Dockerfile to build and run transmission and openvpn, image uses arch as a base


## Building the container yourself
To build this container, clone the repository and cd into it.

### Build it:
```
$ cd /repo/location/docker-arch-transmission-vpn
$ docker build -t="transmission" .
```

```
$ docker run -d --name=transmission --privileged -v </storage/transmission-config>:/var/lib/transmission -v </storage/transmission-vpn>:/etc/openvpn -v </storage/transmission-downloads>:/data -v /etc/localtime:/etc/localtime:ro -p 9091:9091 transmission

# access: http://your.host.ip.addr:9091/
```
