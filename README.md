# shairport-docker

This is a simple setup to build a minimal docker image with a shairserver-sync and a dokcer-compose prepared for a raspberrypy

``` shell
git clone https://github.com/andreufontb/shairport-docker.git
cd shairport-docker
docker-compose up -d --build
```

## TODO

Airplay uses dynamic ports and also a Bonjour service

- [ ] Read more avout dynamic ports of Airplay and handle them with docker bridge
- [ ] Avoid a 5353 conflict with local raspberry avahi-daemon service