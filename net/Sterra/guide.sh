# инициализация шлюза
passwd root
/opt/VPNagent/bin/init.sh
# маппинг интерфейсов
/bin/netifcfg enum > /home/map1
/bin/netifcfg map /home/map1
# переход в cli
cs_console

