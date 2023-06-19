FROM alpine:edge
WORKDIR /tmp
ARG SH_PASS="password"
ENV MYPATH="ckczjc" \
 CADDYIndexPage="https://github.com/asiaqa/asset/raw/main/webpage-master.zip" \
 TZ="Asia/Chongqing" \
 PASS="password" \
 USER="user" \
 PORT=80 \
 TUNNEL_TOKEN="" \
 ag_simple="https://gist.githubusercontent.com/asiaqa/a891d4cceaf15bcf834fd19875536e69/raw/a77ea0a00795f83d31bb0beb793123731818c2eb/ag_basic.yaml" \
 DNS=53 
COPY content/Caddyfile /etc/caddy/Caddyfile
COPY content/ /tmp/
#COPY content/AdGuardHome.yaml /tmp/AdGuardHome.yaml \
#echo 'ezjc' > /tmp/AdGuardHome.yaml && echo 'ezjc' > /tmp/start.sh && \
COPY start.sh /tmp/start.sh 
COPY start1.sh /tmp/start1.sh
#   content/gg.gz /tmp/gg.gz

RUN apk update && \
    apk add --no-cache ca-certificates caddy wget gzip su-exec tinyproxy && \
    apk add --no-cache curl bash jq ttyd p7zip findutils nano net-tools tzdata openssh busybox-suid bind-tools && \
	apk add --no-cache curl caddy jq bash runit tzdata ttyd p7zip findutils && \
	mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
  	wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/ && \
#  	wget -O /tmp/gg.gz https://github.com/ginuerzh/gost/releases/download/v2.11.4/gost-linux-amd64-2.11.4.gz && \
	gzip -d /tmp/gg.gz && chmod +x /tmp/gg && \
	rm -rf /var/cache/apk/* && \
	cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
	mkdir -p /cf/ && wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /cf/cd && chmod +x /cf/cd && \
	wget -O /tmp/aguard.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz && \
        cd /tmp && tar -xvzf /tmp/aguard.tar.gz && rm /tmp/*.tar.gz && mkdir -p /ag/ && cp /tmp/AdGuardHome/AdGuardHome /ag/adguard && \
         wget -O /ag/AdGuardHome.yaml $ag_simple && cp /tmp/start.sh /start.sh && cp /tmp/start1.sh /start1.sh && cp /tmp/gg /gg && rm -rf /tmp/* && chmod +x /start.sh && chmod +x /start1.sh && echo "Done"
WORKDIR /
#RUN rm -rf /tmp/* && chmod +x /start.sh
CMD /start.sh 
#CMD /start1.sh 
#&> /dev/null
