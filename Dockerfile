FROM voxxit/consul:latest

RUN mkdir /etc/consul.d && \
    cd /etc/consul.d && \
    wget https://raw.githubusercontent.com/justintime/nagios-plugins/master/check_mem/check_mem.pl && \
    chmod +x check_mem.pl && \
    apk update && \
    apk add nagios-plugins

ADD host.json /etc/consul.d/
