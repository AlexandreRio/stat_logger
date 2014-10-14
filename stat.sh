#!/bin/bash

JQ="jq"
BTC_ADDRESS=""
LOG="/var/log/stat_logger.csv"
DATA="/tmp/data.json"


TIME=`date +"%d/%m/%y %T"`
wget http://wafflepool.com/tmp_api?address=$BTC_ADDRESS -O $DATA

TOTAL_HASH_RATE=`cat $DATA | $JQ '.hash_rate'`
WORKER1_HASH_RATE=`cat $DATA | $JQ ''.worker_hashrates[1].hashrate''`
WORKER2_HASH_RATE=`cat $DATA | $JQ ''.worker_hashrates[2].hashrate''`

CONFIRMED=`cat $DATA | $JQ '.balances.confirmed'`
SENT=`cat $DATA | $JQ '.balances.sent'`
UNCONVERTED=`cat $DATA | $JQ '.balances.unconverted'`

echo $TIME,$TOTAL_HASH_RATE,$WORKER1_HASH_RATE,$WORKER2_HASH_RATE,$CONFIRMED,$SENT,$UNCONVERTED >> $LOG
rm $DATA
