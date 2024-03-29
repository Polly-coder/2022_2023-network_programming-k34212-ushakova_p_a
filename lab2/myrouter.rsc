# feb/15/2023 20:52:10 by RouterOS 7.5
# software id = 
#
/interface bridge
add name=Loopback
/interface ovpn-client
add certificate=profile-3.ovpn_1 cipher=aes256 connect-to=62.77.159.148 \
    mac-address=02:60:02:03:AF:02 name=ovpn-out1 port=443 user=mikrotik
/disk
set sata1 disabled=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/routing id
add disabled=no id=172.16.0.1 name=OSPF_ID select-dynamic-id=""
add disabled=no id=172.16.0.1 name=OSPF_ID select-dynamic-id=""
/routing ospf instance
add disabled=no name=ospf-instance-1 originate-default=always router-id=\
    OSPF_ID
/routing ospf area
add disabled=no instance=ospf-instance-1 name=Backbone
/ip address
add address=172.16.0.1 interface=Loopback network=172.16.0.1
/ip dhcp-client
add interface=ether1
/ip ssh
set allow-none-crypto=yes always-allow-password-login=yes forwarding-enabled=\
    both
/routing ospf interface-template
add area=Backbone auth=md5 auth-key=332915 disabled=no interfaces=ether1
/system ntp client
set enabled=yes
/system ntp client servers
add address=0.ru.pool.ntp.org
