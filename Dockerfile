FROM debian:latest
MAINTAINER Dave Dobson <ddobson@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y -q && \
    apt-get install -y -q --no-install-recommends \
    fail2ban \
    iptables \
    exim4 \
    bsd-mailx \
    whois \
	procps \
    && rm -rf /var/lib/apt/lists/*

ADD docker-entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh

COPY filter.d/ /etc/fail2ban/filter.d/
COPY action.d/ /etc/fail2ban/action.d/
COPY jail.conf /etc/fail2ban/jail.local

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/bin/python3 /usr/bin/fail2ban-server"]
