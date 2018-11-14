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

## Агрегация линков
# active/standby
add bonding group 1
set interface bond1 state on
add bonding group 1 interface eth1
add bonding group 1 interface eth2
set bonding group 1 mode active-backup
set bonding group 1 primary eth1
set interface bond1 ipv4-address 192.168.10.1 mask-length 24
set interface bond1 comments “Internal”
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

fw ctl pstat 
cphaprob stat
fw stat
fw fetch mastername
push_cert –s Cust_CMA –u admin –p adminpw –o examplegw –k test123
# cluster health status
cphaprob state / cphaprob -a if / cphaprob -l list
# gateway performance (cpu, memory, connections,...)
cpview
# CP process status
cpwd_admin list
#
fw monitor
# информация о интерфейсах
fw getifs
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
#
tcpdump -ni eth1
netstat -an

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

