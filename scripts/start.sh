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
    mkdir -p ~/.docker/cli-plugins/
    curl -SL https://github.com/docker/compose/release/download/v2.24.5/docker-compose-linux-x86_64 \
    -o ~/.docker/cli-plugins/docker-compose
    chmod +x ~/.docker/cli-plugins/docker-compose
    export PATH=$PATH:~/.docker/cli-plugins
}

if ! command -v docker &> /dev/null;
then
    install_docker
fi

if ! docker compose version &> /dev/null;
then
    install_docker_compose
fi



mkdir -p data/nethermind data/lighthouse jwtsecret

if [ ! -f jwtsecret/engine.jwt ];
then
    openssl rand -hex 32 > jwtsecret/engine.jwt
fi

echo "Starting ETH Sepolia"
docker-compose up -d