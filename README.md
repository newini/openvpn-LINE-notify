# openvpn-LINE-notify

# How to?

## 1. Create LINE notify
https://notify-bot.line.me/my/

get a 'LINE token'

## 2. Change OpenVPN config
open and edit /etc/openvpn/server.conf

add below lines.
```
# Send notify when clien connect/disconnect
script-security 2
client-connect /etc/openvpn/server/notify_connect_disconnect.sh
client-disconnect /etc/openvpn/server/notify_connect_disconnect.sh
```

## 3. Download LINE notify script file
Download script
```
sudo wget -O /etc/openvpn/server/notify_connect_disconnect.sh 
```
and open to edit LINE_TOKEN

then, change permission
```
sudo chmod +x /etc/openvpn/server/notify_connect_disconnect.sh
sudo chmod +x /etc/openvpn/server/
```


## 4. Restart OpenVPN
```
systemctl restart openvpn-server@server.service
```
