#!/bin/bash

rm -f web config.json
wget -N $EXEC
chmod +x ./web

if [[ -z $ID ]]; then
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
  "websocket": {
      "enabled": true,
      "path": "/$PATH",
      "hostname": "$HOST"
  },
  "mux": {
    "enabled": true,
    "concurrency": 8,
    "idle_timeout": 60
  },
}
EOF

./web -config=config.json