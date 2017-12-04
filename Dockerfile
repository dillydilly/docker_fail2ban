FROM debian:latest

MAINTAINER Dave Dobson <ddobson@gmail.com>

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -y -q && \
    apt-get install -y -q --no-install-recommends \
    iptables \
    exim4 \
    bsd-mailx \
    whois \
    python \
    python3 \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/src
RUN git clone -b debian-0.10 http://github.com/fail2ban/fail2ban.git
RUN cd fail2ban
RUN /usr/bin/python3 setup.py install

COPY filter.d/ /etc/fail2ban/filter.d/
COPY action.d/ /etc/fail2ban/action.d/
COPY jail.conf /etc/fail2ban/jail.local

RUN mkdir -p /var/run/fail2ban
RUN rm -f /etc/fail2ban/jail.d/defaults-debian.conf

CMD ["-f", "start"]
ENTRYPOINT ["/usr/local/bin/fail2ban-server"]
