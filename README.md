# F.A.Q 

# LICENSE
EULA

<div align="center">
    <img src="" width="400px"</img> 
</div>


# What is it?
1. ICMP Attack Software for Blind MITM Using localhost Traffic
2. Seperately python script or use setup for automated attack
3. Find out HTTPS passwords in network using localhost in this Blind MITM
4. Web requests are automatically handled by Perl modules
5. Web requests are automatically handled by Python modules

# Advantage
1. It doesn't need ARP
2. It can quitely redirect victim traffic into your own computer
3. Using your own computer localhost, you can easily see HTTPS traffic
4. This will not alarm IDS/Firewall
5. ARP / Spoofing method will

# Attack Technique
1. This use ICMP TYPE 5 Attack, using IP Datagram of Transport Protocol used in Transport Layer 4 in OSI Model

# Blind Attacks
1.Perform ICMP Attack for Blind MITM Traffic Redirection
- Example: ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18
- Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && bettercap -t 127.0.0.1 --proxy -P POST
- Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && sslstrip -a -k -l 8080 -i logs.txt

# Breaking HTTPS
1. This method works very well
2. See traffic using localhost for PC
3. See traffic using localhost for Mobile
4. See traffic using localhost for I-PAD
5. See traffic using localhost for Tablets
6. See Gmail, Facebook, Instagram and many others paswords

# Installation
1. Automatic and guided attack use, Perl
2. Manual use Python 

# Requirement
1. In terminal: sudo apt-get install bettercap
2. In terminal: Perl -MCPAN -e shell, then, install Term::ANSIColor

# Contact
mrharoonawan@gmail.com
