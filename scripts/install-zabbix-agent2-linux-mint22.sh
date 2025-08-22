#!/bin/bash
# Instalar agente do zabbix 

#download do instalador
wget https://repo.zabbix.com/zabbix/7.4/release/ubuntu/pool/main/z/zabbix-release/zabbix-release_latest_7.4+ubuntu24.04_all.deb

# instalação do pacote
dpkg -i zabbix-release_latest_7.4+ubuntu24.04_all.deb
apt update

apt install zabbix-agent2 -y

systemctl enable zabbix-agent2

systemctl restart zabbix-agent2

#nano /etc/zabbix/zabbix_agent2.conf
# Alterar
#Server=127.0.0.1 //para o ip do Servidor Zabbix
#
#ServerActive=127.0.0.1 //comentar se não for usar o Active
#
# Alterar o nome do Hostname se preciso
#Hostname=pc-cliente

systemctl restart zabbix-agent2

#Testar comunicação com o cliente - se for 1 está ok
#zabbix_get -s {ip-cliente} -k "agent.ping"

#listar todas chaves possíveis para monitoramento
#zabbix_agentd -p
