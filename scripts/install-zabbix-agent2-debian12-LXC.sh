#!/bin/bash
# Instalação Zabbix Agent 2 no Debian 12

# 1. Download do repositório correto
wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb

# 2. Instalar repositório
dpkg -i zabbix-release_latest_7.4+debian12_all.deb
apt update -y

# 3. Instalar agente
apt install zabbix-agent2 -y

# 4. Habilitar e iniciar o serviço
systemctl enable zabbix-agent2
systemctl restart zabbix-agent2

#Edite o arquivo /etc/zabbix/zabbix_agent2.conf conforme necessario.

#EDITAR
#Server = ip do servidor
#ListenIP = ip do container
#Hostname = Hostname do cliente
#ServerActive=127.0.0.1 // COMENTAR
