#!/bin/bash
set -e

install_docker() {
    echo "installing docker"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
}

install_docker_compose() {
    echo "Instal Docker Compose"
    apt install docker-compose
}

if ! command -v docker &> /dev/null;
then
    install_docker
fi

if ! docker-compose version &> /dev/null;
then
    install_docker_compose
fi



mkdir -p data/nethermind data/lighthouse jwtsecret
sudo chown -R $USER:$USER ./data/nethermind
sudo chmod -R 755 ./data/nethermind
sudo chown -R $USER:$USER ./data/lighthouse
sudo chmod -R 755 ./data/lighthouse

if [ ! -f jwtsecret/engine.jwt ];
then
    openssl rand -hex 32 > jwtsecret/engine.jwt
fi

echo "Starting ETH Sepolia"
docker-compose up -d

