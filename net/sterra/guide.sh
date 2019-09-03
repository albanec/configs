########################################################################################################################
### Общие настройки
########################################################################################################################

### маппинг интерфейсов для VM
/bin/netifcfg enum > /home/map1
/bin/netifcfg map /home/map1
reboot


### сертификаты
# регистрация ca серта
cert_mgr import -f /certs/ca.cer -t
# генерация запроса 
cert_mgr create -subj "C=RU,O=test,OU=test OU,CN=HUB" -GOST_R341012_256 -fb64 /home/gw_req
# импорт сертификата шлюза
cert_mgr import -f media:041F-4C1B/gw1.cer
# проверка
cert_mgr show
# CRL
crypto pki trustpoint s-terra_technological_trustpoint
crl download group GROUP http://10.0.221.179/certsrv/certcrl.crl
crl download time <интервал в минутах>
# отключить CRL
revocation-check none


## перерегистрация лицензии 
[] run lic_mgr set -p PRODUCT_CODE -c CUSTOMER_CODE -n LICENSE_NUMBER -l LICENSE_CODE


## настройка времени
run date -s "01/31/2017 15:00"

## настройка NTP
# в файле /etc/ntp.conf
server <server_addr>
restrict  default  ignore 
restrict 127.0.0.1 nomodify notrap
restrict <server_addr> nomodify notrap
driftfile /var/lib/ntp/ntp.drift
logfile /var/log/ntpstats
# /etc/default/ntp
NTPD_OPTS='-g'
# перезапуск и проверка
/etc/init.d/ntp restart
ntpq -p



########################################################################################################################
### GW 4.2
########################################################################################################################

### первоначальная настройка & инициализация шлюза

# при запуске запускается initial_cli, учетка по-умолчанию administrator/s-terra
    # для перехода в bash: system
    # для перехода в cisco-like_console: configure, учётка по-умолчанию cscons/csp
initialize
run csconf_mgr activate

# лицензии
Product Code: GATE
Customer Code: DEMO
License Number: 1001882
License Code: 42000-00A0P-P5HE7-MCXUM-EAJ5V

Customer Code: DEMO
Product Code: L2VPN
License Number: 113064
License Code: 42000-0000P-YK70K-174R6-ZVCAP

# сменить пароль пользователя (в системе)
[] change user password

### настройка туннелей
crypto isakmp identity dn
crypto isakmp keepalive 10 2
crypto isakmp keepalive retry-count 5
# IKE
crypto isakmp policy 1
    authentication gost-sig
    encr gost
    hash gost341112-256-tc26
    group vko2
# IPsec
crypto ipsec transform-set TSET esp-gost28147-4m-imit
#
ip access-list extended LIST
    permit ip 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255
    permit ip 192.168.3.0 0.0.0.255 192.168.2.0 0.0.0.255
ip access-list extended LIST2
    permit ip 192.168.1.0 0.0.0.255 192.168.3.0 0.0.0.255
    permit ip 192.168.2.0 0.0.0.255 192.168.3.0 0.0.0.255
#
ip access-list extended FW
    permit ahp host 172.17.255.2 host 172.17.255.1
    permit esp host 172.17.255.2 host 172.17.255.1
    permit ip host 172.17.255.2 eq 500 host 172.17.255.1 eq 500
    permit icmp any any
#
crypto map CMAP 1 ipsec-isakmp
    match address LIST
    set transform-set TSET
    set pfs vko2
    set peer 10.1.2.2
crypto map CMAP 2 ipsec-isakmp
    match address LIST2
    set transform-set TSET
    set pfs vko2
    set peer 10.1.3.2
#
interface GigabitEthernet 0/1
    crypto map CMAP
    ip access-group FW in


########################################################################################################################
### GW 10G
########################################################################################################################

## инициализации
initialize
    # этапы:
    # настройка ipsm_dpdk.cfg (установка числа тредов)
        # число ядер минус 6
    # PCI_ID WAN-интерфейса
    # l3_ip/l3_mask/default_gw
    # PCI_ID LAN-интерфейса
    # настройки L2 туннеля (src/dst - это произвольные адреса)
    # настройки MTU для wan/lan
run csconf_mgr 

# для перезапуска инициализации, запустить скрипт в shell: /opt/VPNagent/bin/configure_dp.sh
# конфигурация сохраняется в /opt/VPNagent/etc/ipsm_dpdk.cfg

## настройка ssh
system
ifconfig -a | grep eth
# в файле /etc/network/interfaces добавить
    auto eth0
    iface eth0 inet static
    address 192.168.1.1
    netmask 255.255.255.0
cat /etc/network/interfaces
ifup eth0
passwd

### настройка туннеля
crypto isakmp identity dn
crypto isakmp keepalive 10 2
crypto isakmp keepalive retry-count 5
# параметры IKE
crypto isakmp policy 1
    authentication gost-sig
        # для PSK
        # authentication pre-share
    encr gost
    hash gost341112-256-tc26
    group vko2
# ключи для PSK
crypto isakmp key KEY address 40.40.40.1
# параметры IPSEC
crypto ipsec transform-set TSET esp-gost28147-4m-imit
mode tunnel
#
ip access-list extended LIST
    permit ip host 172.16.0.1 host 172.16.0.2
#
crypto map CMAP 1 ipsec-isakmp
    match address LIST
    set transform-set TSET
    set pfs vko2
    set peer 10.1.1.2
    set security-association lifetime kilobytes 4294967295
#
ip route 0.0.0.0 0.0.0.0 10.1.1.2
#
interface DP0
    crypto map CMAP




########################################################################################################################
### GW 4.1
########################################################################################################################

passwd root
/opt/VPNagent/bin/init.sh

# лицензии
Customer Code: DEMO
Product Code: GATE100
License Number: 110203
License Code: D19F239DD83A94D1

# переход в cli
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

## настройка Radius
# установка модуля PAM
dpkg -i /home/libpam-radius-auth_1.3.16-4.4_amd64.deb
dpkg -i /home/libpam-script_1.1.5-1_amd64.deb
# настройка подключения к серверу
echo '192.168.1.5:1645 secret1 3' > /etc/pam_radius_auth.conf
# настройка sshd модуля
echo 'auth optional pam_script.so 
auth required pam_radius_auth.so' > /etc/pam.d/sshd

# скрипт для автоматического создания новых пользователей, при попытке подключения через SSH
touch /usr/share/libpam-script/pam_script_auth
echo '#!/bin/bash
if ! getent passwd $PAM_USER > /dev/null 2>&1; then
adduser $PAM_USER --disabled-password --quiet --gecos "" --shell /opt/VPNagent/bin/cs_console
fi' >  /usr/share/libpam-script/pam_script_auth
chmod +x /usr/share/libpam-script/pam_script_auth

## КП
# типы пользователей
VDB_ADMINISTRATOR  - главный администратор
VDB_USER - пользователь (нет возможности управлять сертификатами)
VDB_OBSERVER - read only