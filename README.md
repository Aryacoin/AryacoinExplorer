# Prerequisite

* docker
* docker-compose

# Startup

Run this command and follow instructions
```shell script
./init.sh
```

If you something do wrong, you can reset state with this command. This will delete mongo database and aryacoin blockchain.
```shell script
rm -rf data/*
./init.sh
```