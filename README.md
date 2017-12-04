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
-v ./jail.local:/etc/fail2ban/jail.local \
-v ./custom_filter.conf:/etc/fail2ban/filter.d/custom_filter.conf \
-v ./custom_jail.conf:/etc/fail2ban/jail.d/custom_jail.conf \
-v /var/log:/var/log \
--name fail2ban \
--net host \
--privileged \
dillybob/fail2ban:latest
```


If you want to sync fail2ban docker timezone with your host, add this argument
```
-v /etc/timezone:/etc/timezone.host:ro
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
      - ./jail.local:/etc/fail2ban/jail.local
      - ./custom_filter.conf:/etc/fail2ban/filter.d/custom_filter.conf
      - ./custom_jail.conf:/etc/fail2ban/jail.d/custom_jail.conf
      - /var/log:/var/log
    privileged: true
    network_mode: "host"
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
