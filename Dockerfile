FROM centos:7

COPY files/influxdb.repo /etc/yum.repos.d
RUN yum install -y telegraf \
    && yum clean all \
    && mkdir -p /usr/local/cpanel/logs \
    && mkdir -p /etc/telegraf/grok_patterns

COPY files/spamd_error_log /usr/local/cpanel/logs
COPY files/telegraf.conf /etc/telegraf/telegraf.conf
COPY files/spamd.txt /etc/telegraf/grok_patterns
RUN chmod 644 /usr/local/cpanel/logs/spamd_error_log

USER telegraf

ENTRYPOINT ["/usr/bin/telegraf", "-config", "/etc/telegraf/telegraf.conf", "-config-directory", "/etc/telegraf/telegraf.d", "--debug", "--test-wait", "10"]
