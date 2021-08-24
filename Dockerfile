FROM alpine:3.6

ENV PROXY "socks5 127.0.0.1 1080"

RUN set -x \
	&& apk add --update sniproxy \
	&& apk add --update proxychains-ng \
	&& rm -rf /var/cache/apk/*

WORKDIR /etc/sniproxy

EXPOSE 443

ENTRYPOINT ["/bin/sh","-c","sed -i \"s/^socks.*/$PROXY/g\" /etc/proxychains/proxychains.conf && proxychains /usr/sbin/sniproxy -c /etc/sniproxy/sniproxy.conf -f"]
