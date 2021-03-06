########################################################################################################################
### Работа со строками
########################################################################################################################

# регистры
str.lower()
str.upper()
str.swapcase()
# отступы
str.center(40)
str.ljust(40)
str.rjust(20)
# нормализация (начинает с большой буквы, остальные - маленькие)
str.capitalize()
# начало/конец строки
str.startswith()
str.endswith()
# убрать лишние пробелы
str.strip()
str.lstrip()
str.rsplit()
# содержание цифр
str.isdigit()
# посчитать количество элементов
str.count('1')
str.count('IOS')
# разделение элементов по ключу
str.split('.')
# объединение элементов
str.join('\n')
# индекс элемента строки
str.index('o')
str.index('Version')
# найти положение элемента
    # если не найдено - возвращает '-1'
str.find('IOS')
# наличие элемента в строке
'Router' in str1

## форматирование строк
# %s
message = 'wdwdw %s qsqsqs %s dwdw %i wdwd %f' %(str1, str2, int1, float1)
#
ping = 'ping {} vrf {} '.format(dns, vrf)


########################################################################################################################
### Работа с листами
########################################################################################################################

# создать лист
testlist = ["object1", "object2", "object3"]

# вывести листа
print(testlist)
# вывести n-й элемент листа
print(testlist[1])
# длина списка
print(len(testlist))

# добавить элемент в конец листа
testlist.append("object4")
# добавить элемент на конкретное место листа
testlist.insert(0, "object10")
# удалить последний (или n-й) элемент листа
testlist.pop()
# удалить конкретный эдемен листа
testlist.remove("object1")
# объединение листов
router_list.extend(another_list)
router_list += another_list
# вставка
list.insert(3, 's3')
# удаление элемента листа
del list[-1]
# удалить элемент (последний по-умолчанию) и вернуть его 
list.pop()
# сортировка
list.sort()
list.reverce()
# копирование
list_b = list_a.copy() 

########################################################################################################################
### Работа со словарями
########################################################################################################################

dict1 = {
    'device' : 'cisco',
    'login' : 'admin',
    'password' : 'admin'
}

# проверка наличия элемента
'login' in dict1
# получить элемент
dict1.get('login')
# вывод ключей
dict1.keys()
# вывод значений
dict1.values()
# копировать
dict2 = dict1.copy()


########################################################################################################################
### операторы цикла
########################################################################################################################

# простейший цикл (действие для каждого элемента)
for x in movies:
    print(movies(x))
# оператор ветвления (true/false)
    # isinstance - функция проверки типа данных
if isinstance(x, list):
    """true suite"""
else:
    """false suite"""

### Функции
def function_name(argument(s)):
    """functional code suite"""
    return(a)

######################################################################################################################## 
### Работа с модулями
########################################################################################################################


#Модуль - простой файл .py , содержащий в себе набор функций и комменты к ним

## Создание и использование дистрибутива модулей
# дистры содержат в себе наборы мидулей и позволяют гибко ими управлять
# "setup.py" - в этом файле лежат метаданные к дистрибутиву

# Структура setup.py:
# из базового набора функций (distutils.core) импортируем фукцию "setup"
from distutils.core import setup
# аргументы функции "setup" (метаданные)
setup(name='nester',
      version='1.0.0',
      py_modules=['nester'],    # список доступных в дистре модулей
      author='hfpython',
      author_email='hfpython@headfirstlabs.com',
      url='http://www.headfirstlabs.com',
      description='A simple printer of nested lists')

# Сборка дистрибутива
# в cli
$ python3 setup.py sdist

# Установка дистра в локальный python3
# в cli
$ python3 setup.py install
# после установки структура папки изменится - добавится файт-описание, tar.gz архив дистра, .pyc бинарник и папки, оставшиеся после сборки

# Использование модулей в коде
# название модуля указывается без расширения файла
import nester
# функции из подключенных модулей внутри кода необходимо указывать с добавлением namespace нужного модуля
nester.print_lol(cast)

# можно добавлять к коду конкретные функции из модулей
from nester import print_lol
# так они будут добавлены сразу в MAIN namespace и каждый раз его уже не нужно будет указывать
# но в этом случае могут быть пересечения и так делать не рекомендуется

# Репозитории модулей
# Главный реп модулей - http://pypi.python.org/

# Можно загрузить свои дистры на pypi:
# регистрация
$ python3 setup.py register
# загрузка дистра
$ python3 setup.py sdist upload


########################################################################################################################
### Работа с файлами
########################################################################################################################

## подключение модуля
import os
os.getcwd()        # возвращает текущую рабочую деректорию
# переход в нужную деректорию
os.chdir('../HeadFirstPython/chapter3')

## подключение файла
# открыть файл для работы
data = open('sketch.txt')

## построчное считывание файла
print(data.readlines(), end='')
# или так
with open('router.cfg') as f:
    list1 = f.read().splitlines() # возвращает лист со строками файла

## вывод всего файла
for each_line in data:
    print(each_line, end='')

# поиск символа в строке
data.seek(0)

# закрыть файл
data.close()

## запись в файл
with open('a.cfg', a) as f:
    f.write('\n some text')

## чтение CSV
import csv
with open('devices.txt') as f:
    csv.reader(f, delimeter=':')

## Запись в файл
try:
    out = open("data.out", "w")
    print("Norwegian Blues stun easily.", file=out)
except IOError:
    print('File error.')
finally:
    out.close()


########################################################################################################################
### Работа с serial-интерфейсами
########################################################################################################################

# кодирование строки (на выходе - байтовая последовательность)
x.encode('utf-8')
# декодирование строки
x.decode('utf-8')

## пример работы с serial
import serial
import time

def open_console (port='/dev/ttyUSB0', baudrate=9600):
    console = serial.Serial(port, baudrate, parity='N', stopbits=1, bytesize=8, timeout=8)
    if console.isOpen():
        print('Serial is opened')
        return(console)
    else:
        print('Console error!')
        return False

def run_command (console, cmd='\n', sleep=2):
    print('Sending command: ' + cmd)            
    # отправка в консоль
    console.write(cmd.encode() + b'\n')
    time.sleep()

def read_from_console (console):
    # считать данные с консоли
    bytes_to_be_read = console.inWaiting()
    if bytes_to_be_read:
        output = console.read(bytes_to_be_read)
        return console_data.decode()
    else:
        return False

def check_initial_configuration_dialog (console):
    run_command(console, '\n')
    promt = read_from_console(console)
    if 'Would you like to enter the initial configuration dialog?' in promt:
        run_command(console, 'no', 15)
        run_command(console, '\r\n')
        return True
    else:
        return False

console = open_console()
check_initial_configuration_dialog(console)

with open('config.cfg') as f:
    commands = f.readlines()

for cmd in commands:
    run_command(console, cmd)

output = read_from_console(console)
print(output)


########################################################################################################################
### Классы
########################################################################################################################

## на примере класса для telnet-подключений
class Device:
    def __init__ (self, ip, username, password, connection=None):
        self.ip = ip
        self.username = username
        sefl.password = password
        self.connection = None
    
    def connect (self):
        import telnetlib
        self.connection = telnetlib.Telnet(self.ip)
    
    def authenticate (self):
        self.connection.read_until('Username: ')
        self.connection.write(self.username + '\n')
        self.connection.read_until('Password: ')
        self.connection.write(self.password + '\n')

    def execute (self, command):
        self.connection.write(command)

    def show (self):
        output = self.connect.read_all()#.decode('utf-8')
        return output

router = Device('10.1.1.1', 'cisco', 'cisco')
router.connect()
router.authenticate()
router.execute('enable')
router.execute('cisco')
router.execute('terminal length 0')
output = router.show()
print(output)


## другой пример
class Numnchange :
    
    def __init__(self):
        self.__number = 0
    
    def addfive(self, num):
        self.__number = num
        return self.__number + 5

    def multiply(self, added):
        self.__added = added
        return self.__added * 2
# использование
maths = Numchange()
def main():
    num = float(input("Please enter the number\n"))
    added = maths.addfive(num)
    multip = maths.multiply(added)
    print("Result:", multip)

main()


########################################################################################################################
### Работа с ошибками
########################################################################################################################

# обход кода
try:
    print(hello)
except:
    print(bye)

# проверка доступности файла
if os.path.exists('sketch.txt'):
else:
    print('The data file is missing!')



########################################################################################################################
### Подключение по telnet
########################################################################################################################

import getpass
import telnetlib
import time

def telnet_gns3(ip):
    wait = 2
    connection = telnetlib.Telnet(ip, 23, 5)
    user = raw_input('Enter your telnet username:')
    # для скрытого ввода пароля
    pswd = getpass.getpass()
   
    # Sign in 
    connection.read_until('Username:')
    connection.write(username + '\n')
    if paswd:
        connection.read_until('Password:', 5)    
        connection.write('cisco' + '\n')
    connection.write('enable' + '\n')
    connection.read_until('Password:', 5)
    connection.write('cisco' + '\n')
    time.sleep(wait)

    # Commands from file
    cmd_file = raw_input('Input path to a file:')
    cmd_file = open(cmd_file, 'r')
    cmd_file.seek(0)
    for each_line in cmd_file.readlines():
        time_sleep(wait)
        connection.write(each_line)
        connection.write('\n')

    # добавиление vlan
    for vlan_n in range(2, 20)
        connection.write('vlan ' + str(n) + '\n')
        connection.write('name VLAN_' + str(n) + '\n')

    connection.write('end\n')
    connection.write('exit\n')

    # Write output to a file
    # output = connection.read_very_eager()
    output = connection.read_all()
    R2 = open('R2', 'w')
    R2.write(output)
    R2.close

    print(output)
    connection.close()
    return




########################################################################################################################
### Paramiko
########################################################################################################################
# библиотека для работы с ssh


apt install build-essential libssl-dev
apt install python-pip
pip install --upgrade pip
pip install cryptography
pip install paramiko

import(paramiko)
import (time)

ssh_client = paramiko.SSHClient()
ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh_client.connect(hostname=ip_address, port=22, username=username, password=password,
                   look_for_keys=False, 
                   allow_agent=False)
remote_conection = ssh_client.invoke_shell()
remote_conection.send('conf t\n')
remote_conection.send('int fa0/1\n')
remote_conection.send('ip add 192.168.1.1 255.255.255.0\n')
output = remote_conection.recv(65536)
ssh_client.close()

## пример для работы с серверами (без invoke_shell)
import paramiko
ssh_client = paramiko.SSHClient()

ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh_client.connect('10.10.10.1', port=2232, username='user123', password='qwerty', 
                   look_for_keys = False, allow_agent=False)

stdin, stdout, stderr = ssh_client.exec_command('sudo apt update && sudo apt install nmap', get_pty=True)
stdin.write('qwerty\n')

# вывод ошибок
# print(stderr.read().decode())

output = stdout.read().decode()
print(output)

ssh_client.close()


## обёртки для paramiko
import paramiko
import time

def connect (ip, port, username, password):
    client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(ip, port=port, username=username, password=password, 
                       look_for_keys = False, allow_agent=False)
    return(client)

def get_shell (client):
    connection = client.invoke_shell()
    return(connection)

def send_command (connection, command):
    connection.send(command + '\n')
    time.sleep(2)
    output = connection.recv(4096)
    return(output)

def close (client):
    # print(client.get_transport().is_active())
    if client.get_transport().is_active():
        client.close()


## SCP
from scp import SCPClient

client = paramiko.SSHClient()
ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh_client.connect('192.168.1.1', port=22, username='cisco', password='cisco', 
                   look_for_keys = False, allow_agent=False)

scp = SCPClient(ssh_client.get_transport())
# для файла
scp.put('devices.txt', '/tmp/aa.txt')
# для папки 
scp.put('devices', recurcive=True, remote_path='/tmp/aa.txt')
# выгрузить 
scp.get('/tmp/aa.txt', 'devices')

scp.close()


########################################################################################################################
### Netmiko
########################################################################################################################
# расширенная версия paramiko

pip install netmiko
pip install simple-crypt

## подключение
from netmiko import ConnectHandler

iosv_l2 = {
    'device type':'cisco_ios',
    'ip':'192.168.1.1',
    'username':'cisco',
    'password':'cisco',
    'secret': 'cisco',
    'verbose': True
}
net_connect = ConnectHandler(**iosv_l2)
prompter = net_connect.find_prompt()
# проверка на enable
if '>' in prompter:
    net_connect.enable()

output = net_connect.send_command('sh run')
print(output)

config_commands = ['int lo0', 'ip add 10.1.0.1 255.255.255.255']
output = net_connect.send_config_set(config_commands)
print(output)

## к нескольким устройствам
all_devices = [iosv_l2_1, iosv_l2_2, iosv_l2_3]

for devices in all_devices:
    net_connect = ConnectHandler(**devices)

    for n in range(2,21):
        print 'Creating VLAN:' + str(n)
        config_commands = ['vlan ' + str(n), 'name Python_VLAN ' + str(n)]
        output = net_connect.send_config_set(config_commands)
        print output

## то же из файла
with open('iosv_l2_config') as f:
    lines = f.read().splitlines()
print lines

all_devices = [iosv_l2_1, iosv_l2_2, iosv_l2_3]

for devices in all_devices:
    net_connect = ConnectHandler(**devices)
    output = net_connect.send_config_set(lines)
    print output

## Контроль ошибок
from netmiko.ssh_exception import NetMikoTimeoutException
from netmiko.ssh_exception import SSHException
from netmiko.ssh_exception import AuthenticationException

try:
    net_connect = ConnectHandler(**ios_device)
except (AuthenticationException):
    print 'Authentication failture: ' + ip_address_of_device
    continue
except (NetMikoTimeoutException):
    print 'Timeout of device: ' + ip_address_of_device
    continue
except (EOFError):
    print 'End of file while attempting device: ' + ip_address_of_device
    continue
except (SSHException):
    print 'SSH Issue: ' + ip_address_of_device
    continue
except Exception as unknown_error
    print 'Some other error: ' + ip_address_of_device
    continue

## Контроль версии софта
list_versions = ['1', '2']

for ios_version in list_versions:
    print 'Checking for ' + ios_version
    output_version = net_connect.send_command('show version')
    int_version = 0
    int_version = output_version.find(ios_version)
    if int_version > 0:
        print 'Software version found: ' + ios_version
        break
    else:
        print 'Dis not find ' + ios_version
if ios_version == list_versions[0]:
    print 'Running ' + ios_version + ' commands'
    output = net_connect.send_config_set(config_file1)
elif ios_version == list_versions[1]
    print 'Running ' + ios_version + ' commands'
    output = net_connect.send_config_set(config_file2)
print output



## Шифрование 
from simplecrypt import encrept, decrypt
from pprint import pprint
import csv
import json

# шифрование
dc_in_filename = raw_input('\nEnter filename: ') or 'device_creds.cfg'
key = raw_input('Ecryption key: ') or 'cisco'

with open(dc_in_filename, 'r') as dc_in:
    device_creds_reader = csv.reader(dc_in)
    device_creds_list = [device for device in device_creds_reader]

encrypted_dc_out_filename = raw_input('\nOutput encrypted filename: ') or 'encrypted_device_creds.cfg'

with open(encrypted_dc_out_filename, 'wb') as dc_out:
    dc_out.write(encrypt(key, json.dumps(device_creds_list)))

# расшифровать
with open(encrypted_dc_out_filename, 'wb') as dc_in:
    device_creds_in = json.loads(decrypt(key, dc_in.read()))


## пример последовательного чтения конфигураций

from simplecrypt import encrypt, decrypt
from pprint import pprint
from netmiko import ConnectHandler
import json
from time import time

def read_devices( devices_filename ):
 
    devices = {}  # create our dictionary for storing devices and their info
 
    with open(devices_filename) as devices_file:
 
        for device_line in devices_file:
 
            device_info = device_line.strip().split(',')  #extract device info from line
 
            device = {'ipaddr': device_info[0],
                      'type':   device_info[1],
                      'name':   device_info[2]}  # create dictionary of device objects ...
 
            devices[device['ipaddr']] = device  # store our device in the devices dictionary
                                                # note the key for devices dictionary entries is ipaddr
 
    print '\n----- devices --------------------------'
    pprint( devices )
 
    return devices
#------------------------------------------------------------------------------
def read_device_creds( device_creds_filename, key ):
 
    print '\n... getting credentials ...\n'
    with open(device_creds_filename, 'rb') as device_creds_file: 
        device_creds_json = decrypt(key, device_creds_file.read())
    device_creds_list = json.loads( device_creds_json )
    pprint( device_creds_list )
    
    print '\n----- device_creds ----------------------'
 
    # convert to dictionary of lists using dictionary comprehension
    device_creds = { dev[0]:dev for dev in device_creds_list }
    pprint( device_creds )
 
    return device_creds 
#------------------------------------------------------------------------------
def config_worker( device, creds ):

    if device['type'] == 'junos-srx': 
        device_type = 'juniper'
    elif device['type'] == 'cisco-ios': 
        device_type = 'cisco_ios'
    elif device['type'] == 'cisco-xr':  
        device_type = 'cisco_xr'
    else: 
        device_type = 'cisco_ios'    # attempt Cisco IOS as default
 
    print '---- Connecting to device {0}, username={1}, password={2}'.format(device['ipaddr'], creds[1], creds[2] )
 
    #---- Connect to the device
    session = ConnectHandler(device_type=device_type, ip=device['ipaddr'], username=creds[1], password=creds[2])
    #session = ConnectHandler(device_type=device_type, ip='172.16.0.1',  # Faking out IP address for now
    #                         username=creds[1], password=creds[2]) 
    if device_type == 'juniper':
        #---- Use CLI command to get configuration data from device
        print '---- Getting configuration from device'
        session.send_command('configure terminal')
        config_data = session.send_command('show configuration')
    if device_type == 'cisco_ios':
        #---- Use CLI command to get configuration data from device
        print '---- Getting configuration from device'
        config_data = session.send_command('show run')
    if device_type == 'cisco_xr':
        #---- Use CLI command to get configuration data from device
        print '---- Getting configuration from device'
        config_data = session.send_command('show configuration running-config')
    
    #---- Write out configuration information to file
    config_filename = 'config-' + device['ipaddr']  # Important - create unique configuration file name
 
    print '---- Writing configuration: ', config_filename
    with open(config_filename, 'w') as config_out:
        config_out.write( config_data )
 
    session.disconnect()
 
    return
 
devices = read_devices('devices-file')
creds = read_device_creds('encrypted-device-creds', 'cisco') 
starting_time = time()
 
print '\n---- Begin get config sequential ------\n'
for ipaddr,device in devices.items(): 
    print 'Getting config for: ', device
    config_worker(device, creds[ipaddr])
 
print '\n---- End get config sequential, elapsed time=', time()-starting_time


###########
## пример параллельного чтения конфигураций (через треды)
###########

import threading

devices = read_devices('devices-file')
creds = read_device_creds('encrypted-device-creds', 'cisco')
starting_time = time()

config_threads_list = []
for ipaddr, device in devices.items():
    print 'Creating thread for: ', device
    config_threads_list.append(threading.Thread(target=config_worker, args=(device, creds[ipaddr])))

print '\n---- Begin get config threading ----\n'
for config_thread in config_threads_list:
    config_thread.start()
 
for config_thread in config_threads_list:
    config_thread.join()
 
print '\n---- End get config threading, elapsed time=', time() - starting_time



## с регуляцией числа тредов

import threading

devices = read_devices('devices-file')
creds   = read_device_creds('encrypted-device-creds', 'cisco')

num_threads_str = raw_input('\nNumber of threads (5): ') or '5'
num_threads = int(num_threads_str)
 
#---- Create list for passing to config worker
config_params_list = []
for ipaddr,device in devices.items():
    config_params_list.append((device, creds[ipaddr]))
 
starting_time = time()
 
print '\n--- Creating threadpool, launching get config threads\n'
threads = ThreadPool(num_threads)
results = threads.map(config_worker, config_params_list)
 
threads.close()
threads.join()
 
print '\n---- End get config threadpool, elapsed time=', time() - starting_time



## очереди

from queue import Queue
import threading 

def connecrt_and_run (device, output_q, cmd='show run'):
    connection = ConnectHandler(**device)
    connection.enable()
    output = connection.send_command(cmd)

    output_q.put(output)

output_q = Queue()

for device in device_list:
    my_thread = threading.Thread(target=connect_and_run, args=(device, output_q, 'sh run'))

main_thread = threading.current_thread()
for my_thread in threading.enumerate():
    if my_thread != main_thread:
        my_thread.join()

while not output_q.empty():
    output = output_q.get()
    pint(output)


##########
## пример параллельного multiprocessing
##########

import multiprocessing as mp
import time

def print_name_and_time (name):
    print(name, ' current timestamp is: ', time.time())

if __name__ == '__main__':
    process_list = list()

    for i in range(10):
        process = mp.Process(target=print_name_and_time, args=('User',))
        process_list.append(process)

    for p in process_list:
        p.start()

    for p in process_list:
        p.stop()


## работа с linux
from netmiko import ConnectHandler

linux = {
    'device_type': 'linux',
    'ip': '10.1.1.1',
    'username': 'admin',
    'password': 'cisco',
    'port': 22,
    'secret': 'cisco',
    'verbose': True
}
connection = ConnectHandler(**linux)

connection.enable()
output = connection.send_command('apt-get update')
print(output)
connection.close()

## SCP
connection = ConnectHandler(**cisco_device)
transfer_output = file_transfer(connection, source_file='1.cfg', dest_file='config.cfg', 
                                file_system='disk0:', direction='put', overwrite_file=True)
connection.disconnect()

## логирование
import logging
logging.basicConfig(filename='test.log', level=logging.DUBUG)
logger = logging.getLogger('netmiko')

# через каналы
connection.write_channel('show run\n')
time.sleep(3)
output = connection.read_channel()
print(output)


## проверка состояния интерфейса
output = net_connect.send_command('show ip int ' + interface)
if 'Invalid input detected' in output:
    print('Invalid interface!!')
else:
    first_line = output.splitlines()[0]
    print(first_line)
    if not 'up' in first_line:
        print('Interface is down. Enabling the interface.')
        commands = ['int' + interface, 'no shut', 'exit']
        output = net_connect.send_config_set(commands)
        print(output)
        print('#' * 40)
        print('Interface has been enabled')
    else:
        print('Interface ' + interface + ' is already enabled')




     
########################################################################################################################
### NAPALM
########################################################################################################################
# требует netmiko

pip install napalm



## вывод operational команд
# всю информацию napalm выдаёт в JSON

import json
from napalm import get_network_driver

# подключение к устройству
driver = get_network_driver('ios')
optional_args = {'secret' : 'cisco'} # enable pswd
iosvl2 = driver('192.168.1.1', 'username', 'pswd', optional_args=optional_args)
# открыть сессию
iosvl2.open()

# информация о железе 
ios_output = iosvl2.get_facts()
# статистика по интертфейсам
ios_output = iosvl2.get_interfaces()
ios_output = iosvl2.get_interfaces_counters()
# L2 данные
ios_output = iosvl2.get_mac_address_table()
ios_output = iosvl2.get_arp_table()
# ping
ios_output = iosvl2.ping('google.com', destination='10.0.0.1', cont=2)
# BGP
ios_output = iosvl2.get_bgp_neighbors()

print json.dumps(ios_output, sort_keys= TRUE, ident=4)

# закрыть сессию
iosvl2.close()




## заливка конфигурации
iosv_l2.open()

iosv_l2.load_replace_candidate(filename='example.cfg') # заменить
iosv_l2.load_merge_candidate(filename='example.cfg')

iosv_l2.commit_config()
iosv_l2.rollback()

iosv_l2.close()

## проверка конфига
diffs = iosv_l2.compare_config()
if len(diffs) > 0:
    print(diffs)
    iosv_l2.commit_config()
else:
    print('No changes required.')
    iosv_l2.discard_config()


########################################################################################################################
### pyntc
########################################################################################################################

pip install pyntc

##
import json
from pyntc import ntc_device as NTC

iosv_l2 = NTC(host='192.168.1.1', username='cisco', password='cisco',device_type='cisco_ios_ssh')
iosv_l2.open()
ios_output = iosvl2.facts
print(json.dumps(ios_output, ident=4))
iosvl2.config_list(['hostname cisco_test'])
ios_output = iosvl2.running_config

# бэкап
ios_output = iosvl2.backup_running_config









########################################################################################################################
### Полезные функции
########################################################################################################################


# генерирует число в заданном диапазоне
range()
# генерирует list из чисел
enumerate()
# конвертирует строку или число в int (если возможно)
int()
# возвращает уникальный идентификатор объекта
id()
# возвращает следующий элемент структуры данных (например, листа)
next()
# вывод информации
print()
# вывести табуляцию и поставить '' в конце
print("\t", end='')

# возвращает рабочую папку
os.getcwd()
# переход в другую папку
os.chdir('../HeadFirstPython/chapter3')

# открыть файл для работы с ним
data = open('sketch.txt')
# построчное считывание файла
data.readline()
# перейти в начало файла
data.seek(0)
# закрыть файл
data.close()   

### Даты
import datetime
now = datetime.datetime.now()
today = str(now.year + '-' + str(now.month) + '-' + str(now.day))

### Перемещения
config_fileos.chdir(path)
os.listdir()

