# F.A.Q 

# LICENSE
EULA

<div align="center">
    <img src="http://oi66.tinypic.com/2j0lgub.jpg" width="600px"</img> 
</div>


# What is it?
1. ICMP Attack Software to perform a blind mitm attack by redirecting victim traffic into our localhost

# Advantage
1. No noisy spoofings
2. This will not alarm IDS/Firewall
3. Sniff traffic using your localhost

# Attack Technique
1. This use ICMP TYPE 5 Attack, using IP Datagram of Transport Protocol used in Transport Layer 4 in OSI Model

# Blind Attacks
- Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && bettercap -t 127.0.0.1 --proxy -P POST
- Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && sslstrip -a -k -l 8080 -i logs.txt

# Tips
1. Try to local victim account, 90% of the time, victim will use gmail to recover password

# Breaking HTTPS
1. See traffic using localhost for PC, Mobile, I-PAD, Tablets
2. See Gmail, Facebook, Instagram and many others paswords

# Installation
1. Perl script to form automated and guided attack
2. Manual python script to redirect traffic and integrate it with other tools as well

# Requirement
1. In terminal: sudo apt-get install bettercap
2. In terminal: Perl -MCPAN -e shell, then, install Term::ANSIColor

# Contact
mrharoonawan@gmail.com
