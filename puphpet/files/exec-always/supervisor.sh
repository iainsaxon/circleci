#!/bin/sh

cat /vagrant/etc/supervisor/supervisord.conf >> /etc/supervisor/supervisord.conf
cp /vagrant/etc/supervisor/conf.d/supervisor.conf /etc/supervisor/conf.d/supervisor.conf