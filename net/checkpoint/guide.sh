
# установка ip
set interface eth0 ipv4-address 10.20.0.2 mask-length 24
# маршрут (примеры)
set static-route 192.0.2.100 nexthop gateway address 192.0.2.155 on
set static-route 192.0.2.100 nexthop gateway address 192.0.2.18 off
set static-route 192.0.2.0/24 off
set static-route 192.0.2.100 nexthop blackhole
set static-route 192.0.2.0/24 rank 2
show route static

# проверить статус демона на SMC


# проверить нагрузку (по соединениям)
fw tab -s -t connections 
# статистика по соединениям
watch --interval=1 'cpstat fw' 
# лог дропнутых соединений
fw ctl zdebug drop
