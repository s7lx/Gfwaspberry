sudo echo
echo "---Downloading China Mainland IP list ..."
curl 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /home/pi/chnroute.txt
curl https://raw.githubusercontent.com/shadowsocks/ChinaDNS/master/iplist.txt >/home/pi/iplist.txt
echo "---Restarting ChinaDNS now ..."
sudo killall chinadns
/home/pi/chinadns -m -l /home/pi/iplist.txt -p 5354 -c /home/pi/chnroute.txt -s  119.29.29.29,8.8.8.8 &
#sudo /etc/rc.local
echo "---Update gfwlist"
python /home/pi/gfwlist2dnsmasq.py gfwlist /home/pi/dnsmasq-bypass.conf
sudo service dnsmasq restart
echo "---update done--"
