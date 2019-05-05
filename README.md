# F.A.Q 

# LICENSE
EULA

<div align="center">
    <img src="http://oi66.tinypic.com/2j0lgub.jpg" width="600px"</img> 
</div>


# What is blinder?
1. It can perform a blind mitm attack by redirecting victim traffic into our localhost
2. It will not alert IDS/Firewalls and no noise
3. It will use datagram redirection code in network/transport layer to communicate with TCP-IP

# Advantage
1. Sniff traffic using your localhost

# Attack Technique
1. This use ICMP TYPE 5 Attack, using IP Datagram of Transport Protocol used in Transport Layer 4 in OSI Model

# Blind Attacks
- Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && bettercap -t 127.0.0.1 --proxy -P POST
- Blind  : ICMPAttack.py -v -i wlan0 -g 192.168.15.0 -t 192.168.15.18 && sslstrip -a -k -l 8080 -i logs.txt

# Tips
1. Try to lock victim accounts, 90% of the time, victim will use gmail to recover password

# Breaking HTTPS
1. See traffic using localhost for PC, Mobile, I-PAD, Tablets

# Installation
1. Perl script to form automated and guided attack
2. Manual python script to redirect traffic and integrate it with other tools as well

# Requirement
1. In terminal: sudo apt-get install bettercap
2. In terminal: Perl -MCPAN -e shell, then, install Term::ANSIColor

# Contact
mrharoonawan@gmail.com
