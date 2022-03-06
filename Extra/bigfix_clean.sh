#!/bin/sh

#Pre-Checks
[ -f /opt/BESClient/bin/BESClient ] || exit 0
[ -x /opt/BESClient/bin/BESClient ] || exit 0

totvarspace=$(df -kP /var | awk '{print $2}' | grep '[0-9]')
varspaceavail=$(df -kP /var | awk '{print $4}' | grep '[0-9]')
if [ $totvarspace -gt 500000 ]; then
        if [ $varspaceavail -gt 1000000 ]; then
                exit 0
        fi
fi

#Stop Bigfix
echo "Stopping BigFix Service"
/etc/init.d/besclient stop

echo
echo "Working on BESClient..."

if [[ -L "/var/opt/BESClient" && -d "/opt/BESClient" ]]; then
        echo "Nothing to do..."
else
        if [[ -L "/var/opt" && -d "/opt" ]]; then
                echo "Nothing to do..."
        else
                if [ -d /var/opt/BESClient ]; then
                        echo "Migrating BigFix Configuration file"
                        mv /var/opt/BESClient/besclient.config /opt/BESClient/.
                        echo "Done"
                else
                        echo "/var/opt/BESClient is missing for some reason... will exit with failure"
                        exit 1
                fi
        fi
fi

echo
echo "Working on BESCommon..."


if [[ -L "/var/opt/BESCommon" && -d "/opt/BESCommon" ]]; then
        echo "Nothing to do..."
else
        if [[ -L "/var/opt" && -d "/opt" ]]; then
                echo "Nothing to do..."
        else
                if [ -d /var/opt/BESCommon ]; then
                        echo "Migrating BigFix BESCommon directory"
                        mv /var/opt/BESCommon /opt/.
                        echo "Done"
                else
                        echo "/var/opt/BESCommon is not found. Moving on..."
                fi
        fi
fi

echo
echo "Moving Other related files"
if [ -d /var/opt/ibm ]; then
        ps -ef | grep ibm | awk '{print $2}' | xargs kill -9
        mv /var/opt/ibm /opt/.
fi

if [ -d /var/opt/lsi ]; then
        ps -ef | grep lsi | awk '{print $2}' | xargs kill -9
        mv /var/opt/lsi /opt/.
fi

echo
echo "Working on with directories and symlinks.."

if [[ ! -L "/var/opt/BESClient" ]]; then
        if [[ ! -L "/var/opt" ]]; then
                echo "Removing /var/opt and replacing with Symlinks"
                rm -rf /var/opt
                ln -s /opt /var/opt
        else
                echo "Nothing to do..."
        fi
else
        echo "Nothing to do..."
fi

echo "Start other related IBM process.. (Physical Servers)"
[ -x /etc/init.d/ibmpawatchdogd ] && /etc/init.d/ibmpawatchdogd restart
[ -x /etc/init.d/paslpd ] && /etc/init.d/paslpd restart
[ -x /etc/init.d/icesnmp ] && /etc/init.d/icesnmp restart
[ -x /etc/init.d/cimlistenerd ] && /etc/init.d/cimlistenerd restart
[ -x /etc/init.d/tier1slpinst ] && /etc/init.d/tier1slpinst restart
[ -x /etc/init.d/gathererd ] && /etc/init.d/gathererd restart

echo

# Start BigFix
echo "Starting BigFix Service"
/etc/init.d/besclient start
if [ $? -gt 0 ]; then
        #Prompt Failure code on exit status
        exit 1
fi


exit 0