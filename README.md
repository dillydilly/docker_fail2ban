# docker_fail2ban
Docker image for fail2ban using debian:latest.


Fail2Ban for docker environment. This is compatible with docker web hosts.

You should use action **docker-iptables-multiport** which works as iptables-multiport

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
    
If you want to use your own jail.local and your own filters:
```
$ docker run -d -it \
-v /path/to/filter.d/custom_filter.conf:/etc/fail2ban/filter.d/custom_filter.conf \
-v /path/to/jail.local:/etc/fail2ban/jail.local \
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

### Lots of filters and actions

If you have a lot of custom rules, build your own docker image
```
$ git clone https://github.com/dillydilly/docker_fail2ban.git
$ cd docker-fail2ban
```
Copy your filters in filter.d folder, your actions in action.d and your jail.local in the current folder.

Then build your image
```
$ docker build -t your-custom-fail2ban .
```

When your image is ready, run it:
```
$ docker run -d -it \
-v /var/log:/var/log \
--name fail2ban \
--net host \
--privileged \
your-custom-fail2ban
```
