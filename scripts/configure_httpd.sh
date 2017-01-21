#!/bin/bash
mv /tmp/preseed.conf /etc/httpd/conf.d/preseed.conf
chown root: /etc/httpd/conf.d/preseed.conf
# need to change the type of the file in SELinux to avoid permissions errors
chcon -t httpd_config_t /etc/httpd/conf.d/preseed.conf
service httpd restart
