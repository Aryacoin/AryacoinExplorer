#!/usr/bin/env bash

cron &

cd /explorer

npm i

rm -f /explorer/tmp/cluster.pid
rm -f /explorer/tmp/index.pid
rm -f /explorer/tmp/db_index.pid
rm -f /explorer/tmp/market.pid

npm start
