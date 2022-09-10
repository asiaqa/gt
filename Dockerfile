FROM alpine:edge
WORKDIR /tmp
ARG SH_PASS="password"
ENV MYPATH="ckczjc"
ENV CADDYIndexPage="https://github.com/asiaqa/asset/raw/main/webpage-master.zip"
ENV TZ="Asia/Chongqing"
ENV PASS="password"
ENV USER="user"
ENV PORT=80
ENV DNS=53
ADD content/AdGuardHome.yaml /tmp/AdGuardHome.yaml
ADD content/Caddyfile /etc/caddy/Caddyfile
#echo 'ezjc' > /tmp/AdGuardHome.yaml && echo 'ezjc' > /tmp/start.sh && \
ADD start.sh /tmp/start.sh
RUN apk update && \
    apk add --no-cache ca-certificates caddy wget gzip su-exec && \
    apk add --no-cache curl bash jq ttyd p7zip findutils nano net-tools tzdata openssh busybox-suid bind-tools && \
	apk add --no-cache curl caddy jq bash runit tzdata ttyd p7zip findutils && \
	mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt && \
  	wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/ && \
  	wget -O /tmp/gg.gz https://github.com/ginuerzh/gost/releases/download/v2.11.4/gost-linux-amd64-2.11.4.gz && \
	gzip -d /tmp/gg.gz && chmod +x /tmp/gg && \
	rm -rf /var/cache/apk/* && \
	cp /usr/share/zoneinfo/Asia/Chongqing /etc/localtime && \
	wget -O /tmp/aguard.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/download/v0.107.11/AdGuardHome_linux_amd64.tar.gz && \
    cd /tmp && tar -xvzf /tmp/aguard.tar.gz && rm /tmp/*.tar.gz && mkdir -p /ag/ && cp /tmp/AdGuardHome/AdGuardHome /ag/adguard && \
    cp /tmp/AdGuardHome.yaml /ag/ && cp /tmp/start.sh /start.sh && cp /tmp/gg /gg && echo "Done"
WORKDIR /
RUN rm -rf /tmp/* && chmod +x /start.sh
CMD /start.sh && echo "nameserver 127.0.0.1" > /etc/resolv.conf
