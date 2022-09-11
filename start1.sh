#!/bin/sh
#cat /etc/caddy/Caddyfile | sed  -e "s/\$MYPATH/$MYPATH/g" -e "1c :$PORT" > /file
#cp /file /etc/caddy/Caddyfile
#cat /file
#cat /etc/caddy/Caddyfile
#sed  -e "s/\$MYPATH/$MYPATH/g" -e "1c :$PORT" /etc/caddy/Caddyfile > /etc/caddy/Caddyfile 
if [[ $TUNNEL_TOKEN ]]
then
  /cf/cd tunnel --no-autoupdate run --token $TUNNEL_TOKEN --protocol auto& 
fi
echo "nameserver 127.0.0.1" > /etc/resolv.conf 
sed -i "s/\$DNS/$DNS/g" /ag/AdGuardHome.yaml 
/ag/adguard -c /ag/AdGuardHome.yaml -w /ag/ -l /ag/ag.log &
#/gg -L=ss2+ws://AEAD_CHACHA20_POLY1305:$PASS@:81?path="/$MYPATH"&dns=127.0.0.1:$DNS/udp &> run.log& # | tee run.log&
#/gg -L=http2://MP:$PASS@:$PORT?probe_resist=web:us.bing.com &> run-1.log&
/gg -L=ss2+ws://AEAD_CHACHA20_POLY1305:$PASS@:81?path="/$MYPATH"&dns=127.0.0.1:$DNS/udp >/dev/null 2>&1 # &> run.log&
/gg -L=http://MP:$PASS@:$PORT?probe_resist=web:duckduckgo.com >/dev/null 2>&1 # &> run1.log&
echo "DONE - 1"
#sed -i "s/\$MYPATH/$MYPATH/g" "1c :$PORT" /etc/caddy/Caddyfile 
#caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
#if [ $DNS == 53 ]
#then 
#fi
