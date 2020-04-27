#!/bin/bash

if [[ ! -f ~/.aryacoin/aryacoin.conf ]]; then
    cp ~/aryacoin.conf ~/.aryacoin
fi

aryacoind $@
