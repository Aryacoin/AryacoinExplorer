#!/bin/bash

print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

print_style "Are you sure you want to reset configurations?\n" "error"
printf "y/N:"

read CONFIRMATION

if [ -z "$CONFIRMATION" ] ; then
    CONFIRMATION="n"
fi

echo $CONFIRMATION;

if [ ${CONFIRMATION} == "y" ] || [ ${CONFIRMATION} == "Y" ] ; then
   print_style "Initialize\n" "info"
else
    exit 0;
fi

print_style "→ Please change db variables.\n" "warning"

print_style "Enter value for MONGO_DB_ROOT_USERNAME:\n" "info"
read MONGO_DB_ROOT_USERNAME
export MONGO_DB_ROOT_USERNAME

print_style "Enter value for MONGO_DB_ROOT_PASSWORD:\n" "info"
read MONGO_DB_ROOT_PASSWORD
export MONGO_DB_ROOT_PASSWORD

print_style "Enter value for MONGO_DB_DATABASE:\n" "info"
read MONGO_DB_DATABASE
export MONGO_DB_DATABASE

print_style "Enter value for MONGO_DB_USERNAME:\n" "info"
read MONGO_DB_USERNAME
export MONGO_DB_USERNAME

print_style "Enter value for MONGO_DB_PASSWORD:\n" "info"
read MONGO_DB_PASSWORD
export MONGO_DB_PASSWORD

print_style "→ Please change rpc variables.\n" "warning"
print_style "Enter value for RPC_USER:\n" "info"
read RPC_USER
export RPC_USER

print_style "Enter value for RPC_PASSWORD:\n" "info"
read RPC_PASSWORD
export RPC_PASSWORD

envsubst '$MONGO_DB_DATABASE $MONGO_DB_USERNAME $MONGO_DB_PASSWORD $RPC_USER $RPC_PASSWORD $MONGO_DB_ROOT_PASSWORD $MONGO_DB_ROOT_USERNAME' < ./.env.example > ./.env

envsubst '$RPC_USER $RPC_PASSWORD' < ./aryacoin/aryacoin.conf.example > ./aryacoin/aryacoin.conf
chown 1000:1000 ./aryacoin/aryacoin.conf

mkdir -p data/aryacoin
chown -R 1000:1000 data/aryacoin

envsubst '$MONGO_DB_DATABASE $MONGO_DB_USERNAME $MONGO_DB_PASSWORD $RPC_USER $RPC_PASSWORD' < ./explorer/src/settings.json.template > ./explorer/src/settings.json

print_style "Run containers?\n" "error"
printf "y/N:"

read CONFIRMATION_RUN

if [ -z "$CONFIRMATION_RUN" ] ; then
    CONFIRMATION_RUN="n"
fi

if [ ${CONFIRMATION_RUN} == "y" ] || [ ${CONFIRMATION_RUN} == "Y" ] ; then
  print_style "Start containers\n" "info"

  docker-compose build --parallel
  docker-compose up -d
else
    exit 0;
fi

