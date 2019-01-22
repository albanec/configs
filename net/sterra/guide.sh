# инициализация шлюза
passwd root
/opt/VPNagent/bin/init.sh

# маппинг интерфейсов
/bin/netifcfg enum > /home/map1
/bin/netifcfg map /home/map1

## сертификаты
# регистрация ca серта
cert_mgr import -f /certs/ca.cer -t
# генерация запроса 
cert_mgr create -subj "C=RU,O=test,OU=test OU,CN=HUB" -GOST_R341012_256 -fb64 /home/gw_req

# переход в cli
cs_console

## настройка туннелей
# выбор router_id в ISAKMP
crypto isakmp identity dn
# ACL для трафика
ip access-list extended LIST
    permit ip 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255
    permit ip 192.168.3.0 0.0.0.255 192.168.2.0 0.0.0.255
# параметры DPD
crypto isakmp keepalive 10 2
crypto isakmp keepalive retry-count 5
# IKE phase 1
crypto isakmp policy 1
    authentication gost-sig
    encr gost
    hash gost341112-256-tc26
    group vko2   
crypto ipsec transform-set TSET esp-gost28147-4m-imit
# IKE phase 2
crypto map CMAP 1 ipsec-isakmp
    match address LIST
    set transform-set TSET
    set pfs vko2
    set peer 10.1.2.2
# настройка списка отозванных сертов
crypto pki trustpoint s-terra_technological_trustpoint
    crl download group GROUP http://10.0.221.179/certsrv/certcrl.crl
    crl download time 120
# привязка к интерфейсу
interface GigabitEthernet 0/1
    crypto map CMAP

# проверка статуса туннелей
sa_mgr show