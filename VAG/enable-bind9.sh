DNSIP=$1
apt-get update
apt-get install -y bind9 bind9utils bind9-doc
 
cat <<EOF >/etc/bind/named.conf.options
acl "allowed" {
    192.148.1.0/24;
};

options {
    directory "/var/cache/bind";
    dnssec-validation auto;

    listen-on port 53 { localhost; 192.148.1.0/24; };
    allow-query { localhost; 192.148.1.0/24; };
    forwarders { 8.8.8.8; 8.8.4.4; };
    recursion yes;
    allow-recursion { localhost; allowed; };

    listen-on-v6 { none; };
};
EOF

cat <<EOF >/etc/bind/named.conf.local
zone "aula104.local" IN {
        type master;
        file "/var/lib/bind/aula104.local";
        };

zone "1.148.192.in-addr.arpa" IN {
        type master;
        file "/var/lib/bind/aula104.local.rev";
        };
EOF

cat <<EOF >/var/lib/bind/aula104.local
$TTL 3600
aula104.local   IN      SOA     ns.aula104.local root.aula104.local. (
                3            ; serial
                7200         ; refresh after 2 hours
                3600         ; retry after 1 hour
                604800       ; expire after 1 week
                86400 )      ; minimum TTL of 1 day

aula104.local          IN      NS      ns.aula104.local
ns.aula104.local       IN      A       192.148.1.101
root.aula104.local     IN      A       192.148.1.102

dns                    IN      A       192.148.1.103
apache.aula104.local   IN      A       192.148.1.104
apache1                IN      A       192.148.1.110

EOF

cat <<EOF >/var/lib/bind/1.148.192.rev

$ttl 3600
1.148.192.in-addr.arpa.  IN      SOA     ns.aula104.local (
                3            ; serial
                7200         ; refresh after 2 hours
                3600         ; retry after 1 hour
                604800       ; expire after 1 week
                86400 )      ; minimum TTL of 1 day

100 IN  NS ns.aula104.local

103 IN  PTR dns.aula104.local
104 IN  PTR apache.aula104.local
110 IN  PTR   apache1

; aqui pones los hosts inversos

EOF

cp /etc/resolv.conf{,.bak}
cat <<EOF >/etc/resolv.conf
nameserver 127.0.0.1
domain aula104.local
EOF

named-checkconf
named-checkconf /etc/bind/named.conf.options
named-checkzone aula104.local /var/lib/bind/aula104.local
named-checkzone 1.148.192.in-addr.arpa /var/cache/bind/192.148.1.rev
sudo systemctl restart bind9


