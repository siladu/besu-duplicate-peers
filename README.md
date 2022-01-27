# besu-duplicate-peers

This repo is a modified version of https://github.com/macfarla/besu-duplicate-peers with the addition of static-nodes.

To reproduce https://github.com/hyperledger/besu/issues/3322 follow the instructions below and leave both nodes running for a good while.

Check for presence of self-references and duplicates like so:

besu1:
```
curl --location --request POST 'http://localhost:8545' \
--header 'Content-Type: application/json' \
--data-raw '{
    "jsonrpc": "2.0",
    "method": "admin_peers",
    "params": [],
    "id": 1
}' | jq '.result | .[] | .enode' | sort | uniq -c
```

besu2:
```
curl --location --request POST 'http://localhost:8555' \
--header 'Content-Type: application/json' \
--data-raw '{
    "jsonrpc": "2.0",
    "method": "admin_peers",
    "params": [],
    "id": 1
}' | jq '.result | .[] | .enode' | sort | uniq -c
```

# Before running

Run `./create-static-nodes.sh` to run besu, inspect the enodes and generate a static nodes file

# Running
setup to reproduce duplicate peers in besu

If I start besu1 and then besu2, besu2 gets 2 peers 100% of the time.

besu --config-file=besu1.conf

besu --config-file=besu2.conf

extract from log files in besu1.log and besu2.log
result of admin_peers in besu1-admin-peers and besu2-admin-peers

If I then stop besu1 and restart it, besu2 goes from 2 to 1 peers and then back to 2 once they reconnect

besu --version
besu/v22.1.0-RC2-dev-2786ce91/osx-x86_64/oracle_openjdk-java-11
* Java version: [`java -version`]
openjdk version "11.0.10" 2021-01-19
OpenJDK Runtime Environment (build 11.0.10+9)
OpenJDK 64-Bit Server VM (build 11.0.10+9, mixed mode)
* Kernel Version: [`uname -a`]
Darwin Kernel Version 21.2.0: Sun Nov 28 20:28:54 PST 2021; root:xnu-8019.61.5~1/RELEASE_X86_64 x86_64
