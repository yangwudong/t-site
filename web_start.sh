#!/bin/bash

rm -f webserver config.json
wget -N $EXEC
chmod +x ./webserver

if [[ -z $ID ]]; then
  id="6364320e-dabb-4422-b871-62e3f9bbff91"
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
        "grpcSettings": {
          "authority": "",
          "multiMode": true,
          "serviceName": "cassette"
        },
        "network": "grpc",
        "security": "none"
      },
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls",
          "quic"
        ]
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
