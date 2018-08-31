
# настройка интерфейсов
set interface eth0 ipv4-address 10.20.0.2 mask-length 24
set interface eth2 comments "Internal Interface" 
set interface eth2 link-speed 1000M/full
set interface eth2 state on
show interface eth1

# работа с маршрутами
set static-route 192.0.2.100 nexthop gateway address 192.0.2.155 on
set static-route 192.0.2.100 nexthop gateway address 192.0.2.18 off
set static-route default nexthop gateway address 172.26.115.1 on
set static-route 192.0.2.0/24 off
set static-route 192.0.2.100 nexthop blackhole
set static-route 192.0.2.0/24 rank 2
show route static
show route

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
show commands feature $name

