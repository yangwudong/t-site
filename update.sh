#!/bin/bash

wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip temp.zip xray && rm -f temp.zip

rm -f ./linux-amd64/webserver
mv xray ./linux-amd64/webserver