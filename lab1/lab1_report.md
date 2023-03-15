University: [ITMO University](https://itmo.ru/ru/)
Faculty: [FICT](https://fict.itmo.ru)
Course: [Network programming](https://github.com/itmo-ict-faculty/network-programming)
Year: 2022/2023
Group: K34212
Author: Ushakova Polina Alexandrovna
Lab: Lab1
Date of create: 30.10.2022
Date of finished: 15.03.2023
___

## Цель работы

Целью данной работы является развертывание виртуальной машины на удаленном сервере с установленной
системой контроля конфигураций Ansible и установка CHR в VirtualBox.

## Ход работы
#### 1. Установка OpenVPN Server.

Была создана виртуальная машина на Яндекс.Облаке с установленным openVPN server.

<img width="769" alt="kHXo486Kpq" src="https://user-images.githubusercontent.com/60848581/225267211-53156362-fa74-4d7d-bfe6-38c95c9042b9.png">


На Ubuntu уже предустановлен python, так что для установки ansible нужно выполнить данные команды:

<code>apt install python3-pip</code>
<code>pip3 install ansible</code>

Через публичный ip заходим в интерфейc openVPN от администратора, логин и пароль выданы при загрузке виртуальной машины.

После этого на Access Server GUI(ip+943 порт) отключим TLS(/configuration/Advanced VPN), отключим поддержку UDP(/configuration/network settings),
и создадим пользователя с паролем(new profile).

![BoqtqsrUNX](https://user-images.githubusercontent.com/60848581/225269113-f4e2811d-166e-4b48-a0e7-e1552b4b67ed.png)



После этого начнется загрузка файла с расширение .ovpn в котором уже содержатся ключи и сертификаты.



#### 2. Установка CHR(RouterOS) на VirtualBox.

Образ RouterOS скачивается с сайта https://mikrotik.com/download из раздела Cloud Hosted Router(CHR) в формате vdi.

В VirtualBox при создании машины указывается тип - Other, версия Other/Unknown (64-bit), а в качестве хранилища указывается ранее скаченный файл в формате .vdi. 
В настройке ВМ в одном из адаптеров указывается тип подключения: Сетевой мост (Без этого не подключить WinBox)

<img width="727" alt="3vSp1tCBIT" src="https://user-images.githubusercontent.com/60848581/225268126-d2e2d050-bfe2-48d3-9100-425d43eead7b.png">

На https://mikrotik.com/download также нужно скачать WinBox для упрощенной работы с CHR.

При первом запуске CHR указываем логин admin, а пароль пропускаем и создаем при требовании. В WinBox подключаемся по MAC адресу к CHR, логин - admin, пароль - установленный.

#### 3. Настройка OpenVPN клиента на RouterOS

Загрузим через файлы скаченный ранее .ovpn файл с сервера.

Вытащим сертификаты и ключ через консоль (команда <code>certificate import file-name=profile.ovpn</code>)

<img src="https://user-images.githubusercontent.com/67152968/194859414-39ee2479-9794-4b32-be56-ee70c1068089.png" width="400"/>

Дальше создадим openvpn интерфейс. В разделе PPP создадим OVPN Client в котором укажем 

* ip 
* port
* user
* password(если установлен для пользователя на сервере)
* certificate(тот у которого KT флаги)
* cipher = aes256

<img width="415" alt="AQdaJfzkfW" src="https://user-images.githubusercontent.com/60848581/225267869-4a4c0b60-dffc-4cb9-b1df-787803126df0.png">

Снизу видим, что соединение установлено, статус connected


## Вывод
В ходе данной лабораторной работы был создан VPN тоннель между виртуальной машиной в облаке и виртуальной Routeros.






