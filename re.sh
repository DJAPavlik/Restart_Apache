#!/bin/bash

# Accept two command line parms
#   parm 1 = virtual host configuration
#   parm 2 = which service directive we wanted to use
CONFIG="$1"
COMMAND="$2"

# Insure two parms were entered
if [ $# -eq 2 ] 
then
    # only allow reload or restart.
    if [ "$COMMAND" == "reload" ] || [ "$COMMAND" == "restart" ]
    then
        # Move the current execution state to the proper directory
        cd /etc/apache2/sites-available

        # Disable a vhost configuration
        sudo a2dissite "$CONFIG"
        sudo service apache2 "$COMMAND"

        # Enable a vhost configuration
        sudo a2ensite "$CONFIG"
        sudo service apache2 "$COMMAND"

    else
        echo "ERROR: $COMMAND is an invalid service command {restart|reload}"
        exit 1
    fi

else
    echo "ERROR: $0 requires two parameters {virtual-host} {restart|reload}"
    exit 1
fi
