# openvpn-LINE-notify
Notify when a client connect or disconnect to the OpenVPN server by LINE notify.

# Pre-requirements
- For CentOS system
```
yum install GeoIP-devel # to get country from IP
```
- For Ubuntu system
```
sudo apt-get install geoip-bin
```

# How to?

## 1. Create LINE notify
https://notify-bot.line.me/my/

get a 'LINE token'

## 2. Change OpenVPN config
Open and edit configuration file on `/etc/openvpn/server.conf` or ``/etc/openvpn/server/server.conf``, and add below lines.
```
# Send notify when clien connect/disconnect
script-security 2
client-connect /etc/openvpn/server/notify_connect_disconnect.sh
client-disconnect /etc/openvpn/server/notify_connect_disconnect.sh
```

## 3. Download LINE notify script file
Download script
```
sudo wget -O /etc/openvpn/server/notify_connect_disconnect.sh https://raw.githubusercontent.com/newini/openvpn-LINE-notify/master/notify_connect_disconnect.sh
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
