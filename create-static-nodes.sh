echo "creating static nodes file..."

# We need a valid static-nodes for besu to start up
echo "[]" > static-nodes.json

besu --config-file=besu1.conf > /dev/null 2>&1 &
BESU1_PID=$!
besu --config-file=besu2.conf > /dev/null 2>&1 &
BESU2_PID=$!

WAITFORSECONDS=10
echo "waiting $WAITFORSECONDS seconds for besu to start to hit RPC..."
sleep $WAITFORSECONDS

ENODE1=`curl -X POST --data '{"jsonrpc":"2.0","method":"net_enode","params":[],"id":1}' http://127.0.0.1:8545 | jq .result`
ENODE2=`curl -X POST --data '{"jsonrpc":"2.0","method":"net_enode","params":[],"id":1}' http://127.0.0.1:8555 | jq .result`

STATICNODES="[\n$ENODE1,\n$ENODE2\n]"

echo $STATICNODES > static-nodes.json

cat static-nodes.json

echo ...saved in static-nodes.json

kill -9 $BESU1_PID
kill -9 $BESU2_PID
