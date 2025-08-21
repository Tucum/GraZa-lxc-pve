#!/bin/bash
# 1. Instalação do Grafana

# 1.1 Instalacao de prerequisitos
apt-get install -y apt-transport-https software-properties-common wget

# 2 import the GPG key:
mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null

# 3 add a repository for stable releases
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list

# 4  Updates the list of available packages
apt-get update

# Instalar o grafana mais recente
apt-get install grafana -y

# Habilitar para inciar automaticamente
/bin/systemctl enable grafana-server

# Iniciar o grafana-server
/bin/systemctl start grafana-server

# Acessar http://localhost:3000
# login: admin
# senha: admin

# Instalar o plugin para integrar com o zabbix
grafana-cli plugins install alexanderzobnin-zabbix-app

# Reiniciar o grafana-server
/bin/systemctl restart grafana-server

# Ativar o plugin do zabbix
# Criar nova fonte de dados no grafana
# http://{ip do zabbix}/zabbix/api_jsonrpc.php
# login: Admin
# senha: zabbix
# sendo o teste bem sucedido, a integração foi feita e já podemos criar dashboards 
