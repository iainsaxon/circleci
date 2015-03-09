#!/bin/sh

rabbitmq-plugins enable rabbitmq_management
rabbitmqctl add_user username password
rabbitmqctl set_user_tags username administrator
rabbitmqctl set_permissions -p "/" username ".*" ".*" ".*"