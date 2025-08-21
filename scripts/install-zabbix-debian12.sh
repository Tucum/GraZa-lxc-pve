#!/bin/bash
# 1. Instalação do Zabbix

cd /opt/
# 1.1 Instalação do repositório
wget https://repo.zabbix.com/zabbix/7.4/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.4+debian12_all.deb
dpkg -i zabbix-release_latest_7.4+debian12_all.deb
apt update

# 1.2. Instalação do  frontend e o agente Zabbix
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y

# 1.2.3 Instalação do SGBD, caso não possua
apt install mariadb-server mariadb-client -y
systemctl enable mariadb
systemctl start mariadb

apt-get install -y expect

#./mysql_secure_installation.exp
expect << EOF
	set timeout 10
	set rootpass "rootmaria"

	spawn mysql_secure_installation

	expect "Enter current password for root*"
	send "\r"

	expect "Switch to unix_socket authentication*"
	send "Y\r"

	expect "Change the root password*"
	send "Y\r"

	expect "New password:"
	send "$rootpass\r"

	expect "Re-enter new password:"
	send "$rootpass\r"

	expect "Remove anonymous users*"
	send "Y\r"

	expect "Disallow root login remotely*"
	send "Y\r"

	expect "Remove test database*"
	send "Y\r"

	expect "Reload privilege tables now*"
	send "Y\r"

expect eof
EOF

# 1.2.4 Criar banco de dados

mysql -u root -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -u root -e "create user zabbix@localhost identified by 'password';"
mysql -u root -e "grant all privileges on zabbix.* to zabbix@localhost;"
mysql -u root -e "set global log_bin_trust_function_creators = 1;"



# 1.2.5 Importação do esquema inicial e dados
zcat /usr/share/zabbix/sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uroot zabbix

# 1.2.6 Desabilitar og_bin_trust_function_creators

mysql -u root -e "set global log_bin_trust_function_creators = 0;"

# 1.2.7 Configurar o banco de dados para o servidor editando /etc/zabbix/zabbix_server.conf
echo "DBPassword=password" | tee -a /etc/zabbix/zabbix_server.conf

# 1.2.8 Iniciar o zabbix
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

#corrigir erro linguagem
sed -i 's/^# \(en_US\.UTF-8 UTF-8\)/\1/' /etc/locale.gen

locale-gen
update-locale LANG=en_US.UTF-8
update-locale LANG=en_US.UTF-8
locale

systemctl restart zabbix-server zabbix-agent apache2

#RESOLVER ERRO MEMORIA
#wget https://raw.githubusercontent.com/kvaps/zabbix-linux-container-template/master/zabbix_container.conf -O /etc/zabbix/zabbix_agentd.d/zabbix_container.conf

#importar template do agent do zabbix
#alterar configuração do widget do dashboard principal para ct.memory.size[pused]
