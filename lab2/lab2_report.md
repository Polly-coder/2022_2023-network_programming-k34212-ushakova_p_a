University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming)
Year: 2022/2023
Group: K34212
Author: Ushakova Polina Aleksandrovna
Lab: Lab2
Date of create: 15.03.2023
Date of finished: 15.03.2023
___

## Цель работы

С помощью Ansible настроить несколько сетевых устройств и собрать информацию о них. Правильно собрать файл Inventory.

## Ход работы
#### 1. Установка второго CHR и второго openvpn клиента на нем.

В результате выполнения этого пункта, по аналогии с первой лабораторной работой, имеем 2 виртуальные машины, настроенные как OpenVPN client.

<img src="https://user-images.githubusercontent.com/67152968/197190209-a8e2cf5e-2ddd-467e-bd68-de75162ce295.png" width="600"/>

---
#### 2. Ansible.

2.1. Нужно создать файл hosts в /etc/ansible в котором разместим информацию о локальных ip двух CHR.

<img src="https://user-images.githubusercontent.com/67152968/199111161-90ff3fc3-9e9a-4c86-a021-fb2f73367869.png" width="400"/>



2.2. Настройка SSH соединения для виртуальных машин.


В VirtualBox добавим NAT соединение и пропишем SSH с портами.

<img src="https://user-images.githubusercontent.com/67152968/197198533-aeac78ef-ac45-417e-a5ed-a4449098384f.png" width="400"/>

Проверить подключение можно командой на сервере:
<code>ssh -p 22 admin@172.27.244.8</code>
После чего потребуется ввести установленый на CHR пароль.


2.3. Playbook

Создадим первый playbook.yml файл в /etc/ansible. В качесте проверки соединения выведем информацию о роутерах с помощью "/system resource print". Также запишем команды, требующиеся для задания.

Настройка NTP: https://smartadm.ru/mikrotik-ntp-server-sntp-client/

Настройка OSPF: https://itproffi.ru/ospf-mikrotik-polnaya-instruktsiya-po-nastrojki-ospf-na-mikrotik/

<img src="https://user-images.githubusercontent.com/67152968/199102670-560a7f3c-52bc-4604-b1b0-a44bc1b12061.png" width="700"/>

Результат выполнения playbook (команда ansible-playbook playbook.yml):

<img src="https://user-images.githubusercontent.com/67152968/199105514-1852c8bc-8bf5-4657-8664-bda332d4f6c7.png" width="400"/><img src="https://user-images.githubusercontent.com/67152968/199106552-c673c106-03e9-4037-86b5-0209964438a6.png" width="600"/>


2.4. Проверка на роутерах.


Изменения отобразилось на обоих роутерах.

![image](https://user-images.githubusercontent.com/60848581/225277754-05e84aaa-27fd-4db6-9a2c-3509d580d305.png)
Пропингуем роутеры в полученной локальной сети.

<img src="https://user-images.githubusercontent.com/67152968/201069090-3918db1a-1f4c-4a7b-ac47-d33a83734b64.png"/>

Для сохранения конфигурации используем команду из рисунка ниже. После этого в /files можной найти нужный нам файл и скачать на основную машину.

<img src="https://user-images.githubusercontent.com/60848581/225274826-11c11ea1-0a85-4df9-ae0f-4decd82c788e.png" width="500"/>


___

#### 3. Схема связи

В draw.io была нарисована схема связи

<img src="https://user-images.githubusercontent.com/60848581/225272886-7add4c7d-7c31-40b8-95ae-50baa972d3f4.png" width="600"/>


---
#### 4. Вывод

В результате работы были настроены два роутера через ansibe с удаленного сервера. Использоване Ansible удобно для настройки одинаковых конфигураций.






