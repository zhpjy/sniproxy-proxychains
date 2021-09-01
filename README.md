# sniproxy-proxychains
Proxy sniproxy traffic with proxychains

docker: https://hub.docker.com/r/zhpjy/sniproxy-proxychains

## Usage
Prepare sniproxy.conf config file in sniproxy folder, example:
```
user nobody
listen 443 {
  proto tls
  table https_hosts
}

table https_hosts {
.* *:443
}
```

Set the variable ```PROXY``` for proxychains like ```socks5 127.0.0.1 8888```, default is ```socks5 127.0.0.1 1080```
```bash
docker run \
        --restart always \
        --name sniproxy \
        -p 443:443 \
        -e PROXY="socks5 192.168.2.1 1080" \
        -v $(pwd)/sniproxy:/etc/sniproxy \
        -d zhpjy/sniproxy-proxychains
```
And you can use [gfwlist2dnsmasq.sh](https://github.com/zhpjy/gfwlist2dnsmasq) to generate gfwlist rules for dnsmasq
```
./gfwlist2dnsmasq.sh -d 192.168.2.1 -o gfw.conf
```
