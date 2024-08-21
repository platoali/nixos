#!/usr/bin/env -S bash 

if [[ $(systemctl --user status sshuttle.service | grep Activ | awk ' {print $2}') = "active" ]]
then
    systemctl --user stop sshuttle.service
else
    systemctl --user start sshuttle.service
fi
