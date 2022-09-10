echo "nameserver 127.0.0.1" > /etc/resolv.conf
/gg -L=ss2+ws://AEAD_CHACHA20_POLY1305:$PASS@:$PORT?path="/$MYPATH"&dns=127.0.0.1:$DNS/udp &> run.log& # | tee run.log&
sed -i "s/\$DNS/$DNS/g" /ag/AdGuardHome.yaml
/ag/adguard -c /ag/AdGuardHome.yaml -w /ag/ -l /ag/ag.log 
#if [ $DNS == 53 ]
#then 
 
#fi
