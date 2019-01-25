########################################################################################################################
### первоначальная настройка & инициализация шлюза
########################################################################################################################

## для версии 4.1
passwd root
/opt/VPNagent/bin/init.sh

## для версии 4.2
# при запуске запускается initial_cli, учетка по-умолчанию administrator/s-terra
    # для перехода в bash: system
    # для перехода в cisco-like_console: configure, учётка по-умолчанию cscons/csp
initialize
run csconf_mgr activate

# сменить пароль пользователя
change user password


## маппинг интерфейсов для VM
/bin/netifcfg enum > /home/map1
/bin/netifcfg map /home/map1
reboot


### сертификаты
# регистрация ca серта
cert_mgr import -f /certs/ca.cer -t
# генерация запроса 
cert_mgr create -subj "C=RU,O=test,OU=test OU,CN=HUB" -GOST_R341012_256 -fb64 /home/gw_req




########################################################################################################################
## настройка туннелей
########################################################################################################################

# переход в cli (v4.1)
cs_console

# установка сертификатов
crypto pki trustpoint sterra_cert
revocation-check none
# проверка
cert_mgr show

#
logging trap debugging
crypto ipsec df-bit copy
# выбор router_id в ISAKMP
crypto isakmp identity dn
# crypto isakmp identity dn
# ACL для трафика
ip access-list extended LIST
    permit ip 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255
    permit ip 192.168.3.0 0.0.0.255 192.168.2.0 0.0.0.255
# параметры DPD
crypto isakmp keepalive 1 3
crypto isakmp keepalive retry-count 3
# IKE phase 1
crypto isakmp policy 1
    authentication gost-sig
    encryption gost
    hash gost341112-256-tc26
    group vko2   
crypto ipsec transform-set TSET esp-gost28147-4m-imit
    mode tunnel
# IKE phase 2
crypto map CMAP 1 ipsec-isakmp
    match address LIST
    set transform-set TSET
    set pfs vko2
    set peer 10.1.2.2

# для PSK
crypto isakmp policy 1
    authentication pre-share
crypto isakmp key KEY address 40.40.40.1

# настройка списка отозванных сертов
crypto pki trustpoint s-terra_technological_trustpoint
    crl download group GROUP http://10.0.221.179/certsrv/certcrl.crl
    crl download time 120
# привязка к интерфейсу
interface GigabitEthernet 0/1
    crypto map CMAP

## резервирование
# vrrp
int gig0/0
vrrp 2 priority 100
vrrp 2 ip 20.20.20.10
vrrp ip route 20.20.20.1 255.255.255.255 20.20.20.1 src 40.40.40.10
vrrp notify master
vrrp notify backup
vrrp notify fault
# проверка статуса туннелей
sa_mgr show
# провека лицензий
run lic_mgr show