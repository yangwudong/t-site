#!/bin/bash

rm -f web config.json
wget -N https://raw.githubusercontent.com/yangwudong/t-site/main/linux-amd64/web
chmod +x ./web

if [[ -z $id ]]; then
    id="272e9747-b4b7-4c75-bde3-01c69553beed"
fi

cat <<EOF > ~/config.json
{
  "run_type": "server",
  "local_addr": "0.0.0.0",
  "local_port": $PORT,
  "remote_addr": "127.0.0.1",
  "remote_port": 80,
  "password": ["$ID"],
  "ssl": {
    "cert": "your_cert.crt",
    "key": "your_key.key",
    "sni": "www.your-awesome-domain-name.com"
  },
  "websocket": {
      "enabled": true,
      "path": "/$PATH",
      "hostname": "$HOST"
  }
}

{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$id"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

./web -config=config.json