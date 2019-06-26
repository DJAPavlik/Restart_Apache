#!/bin/bash

# Accept two command line parms
#   parm 1 = virtual host configuration
#   parm 2 = which service directive we wanted to use
CONFIG="$1"
COMMAND="$2"

# Insure two parms were entered
if [ $# -ne 2 ]

    # Move the current execution state to the proper directory
    cd /etc/apache2/sites-available

    # Disable a vhost configuration
    sudo a2dissite "$CONFIG"
    sudo service apache2 "$COMMAND"

    # Enable a vhost configuration
    sudo a2ensite "$CONFIG"
    sudo service apache2 "$COMMAND"

then
    echo "$0 requires two parameters {virtual-host} {restart|reload}"
    exit 1
fi
