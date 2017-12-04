# docker_fail2ban
Docker image for fail2ban using debian:latest.


Fail2Ban for docker environment. This is compatible with docker web hosts.

Default ban action = **docker-iptables-multiport** which works as iptables-multiport except on the 'docker0' iface.

### Usage
To run it:
```
$ docker run -d -it \
-v /var/log:/var/log \
--name fail2ban \
--net host \
--privileged \
dillybob/fail2ban:latest
```


Default: no jails are enabled, add your config (see below). See source repo for the default 'jail.conf' for you to use/modify.
```
$ docker run -d -it \
-v ./custom_filter.conf:/etc/fail2ban/filter.d/custom_filter.conf \
-v ./jail.local:/etc/fail2ban/jail.local \
-v /var/log:/var/log \
--name fail2ban \
--net host \
--privileged \
dillybob/fail2ban:latest
```

### docker-compose
```
version: "3.2"
services:
  fail2ban:
    image: dillybob/fail2ban:latest
    container_name: fail2ban
    restart: always
    volumes:
      - ./custom_filter.conf:/etc/fail2ban/filter.d/custom_filter.conf
      - ./jail.local:/etc/fail2ban/jail.local
      - /var/log:/var/log
    privileged: true
    network_mode: "host"
```


If you want to sync fail2ban docker timezone with your host, add this argument
```
-v /etc/timezone:/etc/timezone.host:ro
```


### Build your own:

If you have a lot of custom rules, build your own docker image
```
$ git clone https://github.com/dillydilly/docker_fail2ban.git
$ cd docker_fail2ban
```
Copy your filters in filter.d folder, your actions in action.d and your jail.conf in the current folder.

Then build your image
```
$ docker build -t your_custom_fail2ban .
```

Run it:
```
$ docker run -d -it \
-v /var/log:/var/log \
--name fail2ban \
--net host \
--privileged \
your_custom_fail2ban
```
