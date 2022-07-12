#!/bin/bash

rm -f webserver config.json
wget -N $EXEC
chmod +x ./webserver

if [[ -z $ID ]]; then
  id="272e9747-b4b7-4c75-bde3-01c69553beed"
fi

cat <<EOF >~/config.json
{
    "log": {
        "loglevel": "warning"
    },
    "inbounds": [
        {
            "port": 8100,
            "protocol": "trojan",
            "settings": {
                "clients": [
                    {
                        "password": "$ID"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none",
                "wsSettings": {
                  "path": "/$WS_PATH",
                  "headers": {
                      "Host": "$WS_HOST"
                  }
                }
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

./webserver -config=config.json
