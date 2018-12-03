## Первоначальная настройка через CLI
set expert-password plain
# в expert-mode
expert
touch /etc/.wizard_accepted
# в CLI
cpconfig

## Настройка интерфейсов
set interface eth0 ipv4-address 10.20.0.2 mask-length 24
set interface eth2 comments "Internal Interface" 
set interface eth2 link-speed 1000M/full
set interface eth2 state on
show interface eth1

## Работа с маршрутами
set static-route 192.0.2.100 nexthop gateway address 192.0.2.155 on
set static-route 192.0.2.100 nexthop gateway address 192.0.2.18 off
set static-route default nexthop gateway address 172.26.115.1 on
set static-route 192.0.2.0/24 off
set static-route 192.0.2.100 nexthop blackhole
set static-route 192.0.2.0/24 rank 2
show route static
show route
netstat -rn
# IPv6
set IPv6-state [on|off]
show IPv6-state


## DHCP сервер
add dhcp server <parameter> <value>
    netmask <value>
    include-ip-pool start <value> end <value>
    exclude-ip-pool start <value> end <value>

##

## Агрегация линков
# active/standby
add bonding group 1
set interface bond1 state on
add bonding group 1 interface eth1
add bonding group 1 interface eth2
set bonding group 1 mode active-backup
set bonding group 1 primary eth1
set interface bond1 ipv4-address 192.168.10.1 mask-length 24
set interface bond1 comments "Internal"
set interface eth1 state on
set interface eth2 state on
#  LACP
add bonding group 1
set interface bond1 state on
add bonding group 1 interface eth1
add bonding group 1 interface eth2
set bonding group 1 mode 8023AD
# проверка
cat /proc/net/bonding/bond1

# commit
save config

# проверить статус демона на SMC

# проверить нагрузку (по соединениям)
fw tab -s -t connections 
# статистика по соединениям
watch --interval=1 'cpstat fw' 
# лог дропнутых соединений
fw ctl zdebug drop watch --interval=1 'cpstat fw'

### Некоторые команды
fw ctl pstat 
# общая информация
fw stat
#
fw fetch mastername
push_cert –s Cust_CMA –u admin –p adminpw –o examplegw –k test123


### SecureXL
# отключить SecureXL
fwaccel off
# статистика SecureXL
fwaccel stat
fwaccel stats -s
fwaccel conns

### CoreXL
sim affinity -l
# распределение нагрузки по ядрам
fw ctl multik stat
# включить Dynamic Dispatcher
fw ctl multik dynamic_dispatching on
    # без приоритезации очередей
    fw ctl multik prioq 2
## Multi-Queue
# использование Multi-Queue 
cpmq get
# включение Multi-Queue на интерфейсе
cpmq set




# gateway performance (cpu, memory, connections,...)
cpview
# CP process status
cpwd_admin list
# монитор трафика
fw monitor
fw monitor -o monitorfile.pcap
fw monitor -e "accept src=203.0.113.100 or dst=10.1.1.201 and dport=21;" -ci 20 -o monitorfile2.pcap
    # общий вид
    fw monitor -e "accept <expression>;" -o <filename>
        # выражения
        host [<IP_Address>]
        net [<Network_IP_Address>, <Mask_Length>]
        port [<IANA_Port_Number>]
# информация о интерфейсах
fw getifs
# таймаут на cli
set inactivity-timeout <value>
# поставить блокировку базы
config-lock [on|off]
# снять блокировку базы
lock database override
# переменные окружения cli
set clienv <parameter>
save client
# количество строк в выводе cli
rows <integer>
# уровень дебага
debug [0 - 6]
# баннер
set message banner on msgvalue "This system is private and confidential"

# сохранить конфиг в скрипт
save configuration <scriptname>
# загрузить конфиг из скрипта
load configuration <scriptname>
# вывести конфиг
show configuration

# enable or disable core dumps
set core-dump [enable|disable]

#
mgmt_cli show groups
mgmt_cli add access-rule
mgmt_cli install-policy
# show diff between dates
mgmt_cli show changes from-date "2017-02-01T08:20:50" to-date "2017-02-21" --format json
# show unused objects
mgmt_cli show unused-objects offset 0 limit 50 details-level "standard" --format json
# run script
mgmt_cli run-script script-name "ifconfig" script "ifconfig" targets.1 "corporate-gateway" --format json

# список фич 
show commands feature $NAME

## Настройка SNMPv3
set snmp agent on
set snmp contact "$CONTACT"
set snmp location "$LOCATION"
add snmp address "$FIREWALL_IP"
set snmp agent-version v3-only
add snmp usm user $SNMPUSER security-level authPriv auth-pass-phrase $COMPLEX_PHRASE privacy-pass-phrase $ANOTHER_COMPEX_PHRASE

# authentication = MD5 and encryption = DES56

set snmp agent-version any
delete snmp community public read-only
set snmp agent-version v3-only

## Базовые команды
set hostname $HOSTNAME
set interface eth0 ipv4-address $IP_ADDRESS mask-length 24
set interface eth0 ipv4-address $IP_ADDRESS subnet-mask 255.255.255.0
set interface eth0 link-speed 1000M/full
set static-route 192.168.0.0/24 nexthop
set dns primary ipv4-address $DNS_IP
set dns suffix <value>
set timezone EUROPE/LONDON
set time HH:MM:SS
set date YYYY-MM-DD
set ntp active on
set ntp server primary $IP_ADDRESS version #
set edition 64-bit
#
save config
reboot
halt
rollback
#
show hostname
show version all
show interfaces
show interface eth0
show uptime
show version all
show version os edition

# tcpdump
tcpdump -ni eth1
netstat -an
tcpdump -i eth0 icmp -w dumpfile.pcap

### Добавление админа
add user sam uid 200 homedir /home/sam
set user sam newpass Chkp!234
add rba user sam roles adminRole
## управление привами

#
show users

### Backups
# сохраняют .tgz файл в /var/CPbackup/backups/ (на open servers) или /var/log/CPbackup/backups/ на аплаенсах  
## Snapshot
    # ос + конфиги + пакетная база
## System Backup/Restore
    # ос + конфиги
## Migrate
    # только конфиги
# Save/Show/Load Configuration
    # способы (может и в SCP)
    add backup local
    add backup tftp ip <ip>
    add backup [ftp|scp] ip <ip> username <name> password plain
    #
    show backup status
    show backups
    # восстановление
    set backup restore local backup_[backup file name]

### Query Language
[<Field>:]<Filter Criterion>

#Action taken by a security rule
action
# Software Blade
blade
# Level of confidence that an event is malicious
confidence level
# Traffic destination IP address, DNS name, or CheckPoint network object
destination 
dst
# Name of originating Security Gateway
origin
orig
# Name of the protection
protection
# Type of protection
protection_type
# Potential risk from the event
risk
# Service that generated the log entry
service
#Severity of the event
severity
#Traffic source IP address, DNS name or CheckPoint network object name
source
src
# User name
user
# сокращения
Jo*
Jo?
192.168.2.*

# операторы
[<Field>:]<Filter Criterion> AND|OR|NOT [<Field>:]<FieldCriterion>
Action:(drop OR reject OR block)

## примеры
# заблокированное app ctrl
blade: "application control" AND action:block
# данные по обоим адресам
192.0.2.133 10.19.136.101
# данные по обному из адресов
192.0.2.133 OR 10.19.136.101
#
(blade:Firewall OR blade:IPS OR blade:VPN) AND NOT action:drop


### VPN

cpstat vpn -f traffic -o 1

### ClusterXl

## мониторинг состояния кластера
cphaprob state
# расширеный вывод
cphaprob state / cphaprob -a if / cphaprob -l list
# состояние интерфейсов
cphaprob -a if
# нагрузка
cphaprob stat
# состояние синхронизации
fw ctl pstat

# переключение состояний
clusterXL_admin up
clusterXL_admin down

## VMAC
# в ядре
fw ha_vmac_global_param_enabled 1
# в cli
fw ctl set int fwha_vmac_global_param_enabled 1
fw ctl get int fwha_vmac_global_param_enabled


### Upgrade SMS
## Миграция
# перенести архив upgrade tools в /var/log/tmp/
tar -zxvf archive.tgz
cd /var/log/tmp/migrate_tool
./migrate export A-SMS-from-r7730-to-r8010.tgz
# перенести A-SMS-from-r7730-to-r8010.tgz на хост
# после переустановки SMS
cd $FWDIR/bin/upgrade_tools
./migrate import /var/log/Migrate/A-SMS-from-r7730-to-r8010.tgz

### CPInfo
# логи складываются в папку $FWDIR/log/*
# список пакетов
cpinfo -y all
# инспекция и вывод в файл
cpinfo -l -o A-GW-01-cpinfo.txt

### Управление политиками
# отключить активную политику
fw unloadloca
# установить политику с SMS
fw fetch 10.1.1.101

### Процессы & обработка трафика
# CPM включает в себя
    # web_services (обрабатывает запросы от консоли)
    # dle_server (отвечает за логику)
    # object_store (взаимодействие с db):
        # Solr & PostgresSQL
# Основные процессы:
    # fwm - процесс GUI на шлюзах
    # fwd - демон для взаимодействия с ядром
    # fwssd - дочерний процесс fwd для взаимодействия с SMS
    # cpd - core-процесс для SIC
    # cpwd - вотчдог для контроля основных процессов; управляется через cpwd_admin

## Обработка flow трафика
# посмотреть входящие/исходящие chain
fw ctl chain

## Security Servers
# конфигурация в $FWDIR/conf/fwauthd.conf

## Настройка ядра
# вывести настройки таблицы
fw tab -t <tablename>
# вывести список таблиц
fw tab -s
# вывести список сессий
fw tab -t connections -f

## Обработка политики
# скомпилированная хранится на SMS (и шлюзах) в $FWDIR/state/<gateway>
fw fetchlocal -d $FWDIR/state/_tmp/FW1

### API
# типы интерфейсов
    # Management API
    # Threat Prevention API
    # Identity Awareness Web Services API
    # OPSEC SDK

# basic
api status
api start
api stop
login
add
set
show
delete
publish
discard
logout
# примеры
add host name <New Host Name> ip-address <ip address>
add network name "myNetwork" subnet 192.168.0.0 subnet-mask 255.255.255.0
add group name "myGroup" members myHost1
add host name "My Test Host" ip-address 192.168.0.111 groups myGroup
set host name "myHost1" color "blue"
add group name "myGroup1" members.1 "My Test Host" members.2 "A-GUI"


# login
login user <username> password <password> --format json

## mgmt_cli
# для действий нужна аутентификация по sid
mgmt_cli login user 'AdminUser1' password 'teabag' > id.txt
mgmt_cli add host name 'New_Host_1' ip-address '1.1.1.1' -s id.txt
mgmt_cli publish -s id.txt
mgmt_cli logout -s id.txt
mgmt_cli add host --batch hosts1.csv