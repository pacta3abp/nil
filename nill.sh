#!/bin/bash

clear
sleep 1 && curl -s https://raw.githubusercontent.com/pacta3abp/logo/main/logo.sh | bash && sleep 1


apt update
apt upgrade -y
apt install apt-transport-https ca-certificates curl software-properties-common -y

clear
sleep 1 && curl -s https://raw.githubusercontent.com/pacta3abp/logo/main/logo.sh | bash && sleep 1


docker pull nillion/verifier:v1.0.1

mkdir -p nillion/accuser

docker run -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 initialise

sudo cat /root/nillion/verifier/credentials.json


CRED=$(cat /root/nillion/verifier/credentials.json)
clear
sleep 1 && curl -s https://raw.githubusercontent.com/pacta3abp/logo/main/logo.sh | bash && sleep 1

echo "Сохрани данные ноды"
echo $CRED
echo "Ступай на https://verifier.nillion.com/verifier и подключай кошельки"
echo "Запроси токены на свой кошелек и кошелек ноды https://faucet.testnet.nillion.com/ "
read -p "Жми ENTER для продолжения"

sleep 1

docker run -d -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 verify --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com"


sleep 1
echo "Ниллион подняли, поднимаем аллору" 
cd allora-chain/allora-huggingface-walkthrough/
docker compose down
docker compose pull
docker compose up -d --build

sleep 1
docker ps
echo "Проверяй список контейнеров: должно быть 3 шт"
rm -rf /root/logo.sh
