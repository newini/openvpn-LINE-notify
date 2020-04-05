#!/bin/bash
#notify_connect_disconnect.sh
# Description: LINE Notify when clien connect/disconnect OpenVPN
# Author: newini
# Date: April 2020
# Reference: https://openvpn.net/community-resources/reference-manual-for-openvpn-2-4/

# Must change this
LINE_TOKEN=jkasdo1uijasdklakfjjlwi123113

#======================================
#               functions
#======================================
# Format byte
function unitify_bytes {
    bytes=$1
    if [ "$bytes" -gt "1073741824" ]; then
        echo $(( $bytes / 1073741824 )) GiB
    elif [ "$bytes" -gt "1048576" ]; then
        echo $(( $bytes / 1048576 )) MiB
    elif [ "$bytes" -gt "1024" ]; then
        echo $(( $bytes / 1024 )) KiB
    else
        echo $bytes B
    fi
}

# Format time
function unitify_seconds {
    local SS=$1

    if [ "$SS" -ge "60" ]; then
        local MM=$(($SS / 60))
        local SS=$(($SS - 60 * $MM))

        if [ "$MM" -ge "60" ]; then
            local HH=$(($MM / 60))
            local MM=$(($MM - 60 * $HH))

            if [ "$HH" -ge "24" ]; then
                local DD=$(($HH / 24))
                local HH=$(($HH - 24 * $DD))
                local time_string="$DD d, $HH h, $MM min and $SS sec"
            else
                local time_string="$HH h, $MM min and $SS sec"
            fi
        else
            local time_string="$MM min and $SS sec"
        fi

    else
        local time_string="$SS sec"
    fi

    echo "$time_string"
}

# Decide connect or disconnect
if [ "$script_type" == "client-connect" ]; then
    action="connected to"
else
    action="disconnected from"
    action_specific_info="\
Session Duration: $(unitify_seconds $time_duration)
Received $(unitify_bytes $bytes_received)
Sent $(unitify_bytes $bytes_sent)"
fi

# Find country
# TODO: find city
country=`geoiplookup ${untrusted_ip} | cut -d ',' -f 2`

# Create notify message
message="~
'$common_name' $action $HOSTNAME
Connection Start: ${time_ascii}
Client WAN IP: ${untrusted_ip}
Client LAN IP: ${ifconfig_pool_remote_ip}
${action_specific_info}"

# Send notify message
/bin/curl -X POST -H "Authorization: Bearer ${LINE_TOKEN}" -F "message=${message}" https://notify-api.line.me/api/notify
