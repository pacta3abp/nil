#!/bin/bash

clear
sleep 1 && curl -s https://raw.githubusercontent.com/pacta3abp/logo/main/logo.sh | bash && sleep 1


apt update
apt upgrade -y
apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
docker version
VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -L "https://github.com/docker/compose/releases/download/"$VER"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version
sudo groupadd docker
sudo usermod -aG docker $USER


clear
sleep 1 && curl -s https://raw.githubusercontent.com/pacta3abp/logo/main/logo.sh | bash && sleep 1


docker pull nillion/verifier:v1.0.1

mkdir -p nillion/accuser

docker run -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 initialise

sudo rm -rf /root/nillion/verifier/credentials.json

clear
sleep 1 && curl -s https://raw.githubusercontent.com/pacta3abp/logo/main/logo.sh | bash && sleep 1

echo "***************************************************"
read -p "Введи привантник из бекапа:  " credentials
echo "***************************************************"

cat <<EOF > /root/nillion/verifier/credentials.json
$credentials
EOF

sleep 1

echo "Иди на https://verifier.nillion.com/verifier, проверяй данные верифера, подключай кошелек и стейкай эфир"
echo "***************************************************"

docker run --name nillion -d -v ./nillion/verifier:/var/tmp nillion/verifier:v1.0.1 verify --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com"

docker logs -f nillion


