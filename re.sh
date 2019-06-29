#!/bin/bash

# Accept two command line parms
#   parm 1 = virtual host configuration
#   parm 2 = which service directive we wanted to use
CONFIG="$1"
COMMAND="$2"

# Get the valid sites available in the Apache2 folder
VHOSTS_PATH=/etc/apache2/sites-available/*.conf

BOLVALIDHOST="false"
STRFULLNAME="/etc/apache2/sites-available/""$CONFIG"".conf" 
clear
 

# Insure two parms were entered
if [ $# -eq 2 ] 
then
    # only allow reload or restart.
    if [ "$COMMAND" == "reload" ] || [ "$COMMAND" == "restart" ]
    then
        # Check if the configuration entered on command line
        #   is in the configuration set
        for FILENAME in $VHOSTS_PATH
        do
            if [ "$STRFULLNAME" = "$FILENAME" ]
            then
                BOLVALIDHOST="true"
            fi
            
        done

        if [ "$BOLVALIDHOST" = "false" ]
        then
            echo " "
            echo -e "\e[1m\e[31mERROR: \e[0mInvalid host entered"
            echo " "
            echo -e "You entered host name = ""\e[33m$CONFIG"
            echo " "
            echo -e "\e[33mFollowing hosts are available:\e[0m"

            # Echo back the valid hosts
            for FILENAME in $VHOSTS_PATH
            do
                echo "   $FILENAME" 
            done
          
            echo " " 


            exit 1
        else



            # Move the current execution state to the proper directory
            cd /etc/apache2/sites-available
            
            # Disable a vhost configuration
            sudo a2dissite "$CONFIG"
            sudo service apache2 "$COMMAND"

            # Enable a vhost configuration
            sudo a2ensite "$CONFIG"
            sudo service apache2 "$COMMAND"
        fi

    else
        echo -e  "\e[1m\e[31mERROR: \e[33m$COMMAND \e[0mis an invalid service command {restart|reload}"
        exit 1
    fi

else
    echo -e "\e[1m\e[31mERROR: \e[33m$0 \e[0mrequires two parameters {virtual-host} {restart|reload}"
    exit 1
fi
