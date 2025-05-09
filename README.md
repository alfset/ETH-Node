how to install
git clone https://github.com/alfset/ETH-Node
cd ETH-NODE
chmod +x start.sh && ./start.sh

docker ps


check service logs

docker logs -f execution

check lh logs

docker logs -f beacon


query sync
curl -X POST http://localhost:8545 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}'

peers on service
curl -X POST http://localhost:8545 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":1}'


lh status
curl http://localhost:5052/eth/v1/node/syncing


since beacon lh need fully sync service you can stop it first and run again after your service nethermind sync
docker stop beacon

start again

docker start beacon

stop and remove data
cd ETH-NODE
docker-compose down
