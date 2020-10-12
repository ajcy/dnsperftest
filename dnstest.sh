#!/usr/bin/env bash
# 
# Copyright (c) 2020 Anoop Joe Cyriac
#

# For sorted output, pipe through sort 
# eg: bash ./dnstest.sh | sort -b -k 20 -n  # here 20 == ($totaldomains+1) * 2
#
# For analysing historical records
# (echo "========="; date; bash ./dnstest.sh; echo "----------") | tee -a ~/tmp/dnsperftest.txt
# cat dnsperftest.txt | sed -n '356,411p' | sort -bnk 20 | less 
#

command -v bc > /dev/null || { echo "bc was not found. Please install bc."; exit 1; }
{ command -v drill > /dev/null && dig=drill; } || { command -v dig > /dev/null && dig=dig; } || { echo "dig was not found. Please install dnsutils."; exit 1; }



NAMESERVERS=`cat /etc/resolv.conf | grep ^nameserver | cut -d " " -f 2 | sed 's/\(.*\)/&#&/'`

PROVIDERS="
1.1.1.1#cloudflare-P1
1.0.0.1#cloudflare-S1
209.244.0.3#level3-P1
209.244.0.4#level3-P2
4.2.2.1#level3-S1
4.2.2.2#level3-S2
4.2.2.3#level3-S3
4.2.2.4#level3-S4
4.2.2.5#level3-S5
4.2.2.6#level3-S6
8.8.8.8#google-P1
8.8.4.4#google-S1
80.67.169.12#French-P1
80.67.169.40#French-S1
82.200.69.80#DNS.Watch-P1
84.200.70.40#DNS.Watch-S1
9.9.9.9#quad9-P1
149.112.112.112#quad9-S1
9.9.9.10#quad9-P2
149.112.112.10#quad9-S2
9.9.9.11#quad9-P3
149.112.112.11#quad9-S3
80.80.80.80#freenom-P1
80.80.81.81#freenom-S1
208.67.222.222#opendns-P1
208.67.220.220#opendns-S1
208.67.222.123#opendnsFamily-P1
208.67.220.123#opendnsFamily-S1
176.9.62.58#Keweon-P1
176.9.62.62#Keweon-S1
195.46.39.39#SafeDNS-P1
195.46.39.40#SafeDNS-S1
64.6.64.6#Verisgn-P1 
64.6.65.6#Verisgn-S1
80.80.80.80#Freenom-P1
80.80.81.81#Freenom-S1
156.154.70.5#Neustar-P1
156.154.71.5#Neustar-S1
156.154.70.3#Neustar-P2
37.235.1.174#FreeDNS-P1
37.235.1.177#FreeDNS-S1
199.85.126.20#norton-P1
185.228.168.168#cleanbrowsing-P1
77.88.8.7#yandex-P1
176.103.130.132#adguard-P1 
8.26.56.26#Comodo-P1
8.20.247.20#Comodo-S1
203.201.60.12#BellTele-P1
49.45.0.1#JIO-P1
202.86.251.201#Artech-P1
103.245.147.201#Artech-S1
"

# Domains to test. Duplicated domains are ok
DOMAINS2TEST="www.google.com#GOOG https://github.com#GHUB stackoverflow.com#STOF www.youtube.com#YTUB wikipedia.org#WIKI twitter.com#TWTR gmail.com#GMIL whatsapp.com#WTAP www.mathrubhumi.com#MTBM"


totaldomains=0
printf "%-18s" ""
for d in $DOMAINS2TEST; do
    nick_name=${d##*#}
    totaldomains=$((totaldomains + 1))
    #printf "%-8s" "test$totaldomains"
    printf "%-8s" "$nick_name"
done
printf "%-8s" "Average"
echo ""


for p in $NAMESERVERS $PROVIDERS; do
    pip=${p%%#*}
    pname=${p##*#}
    ftime=0

    printf "%-18s" "$pname"
    for d in $DOMAINS2TEST; do
        d_name=${d%%#*}
        ttime=`$dig +tries=1 +time=2 +stats @$pip $d_name |grep "Query time:" | cut -d : -f 2- | cut -d " " -f 2`
        if [ -z "$ttime" ]; then
	        #let's have time out be 1s = 1000ms
	        ttime=1000
        elif [ "x$ttime" = "x0" ]; then
	        ttime=1
	    fi

        printf "%-8s" "$ttime ms"
        ftime=$((ftime + ttime))
    done
    avg=`bc -lq <<< "scale=2; $ftime/$totaldomains"`

    echo "  $avg"
done


exit 0;
